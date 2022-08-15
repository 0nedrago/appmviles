--- Identificar objetos directorio existentes.

select directory_name
     , directory_path 
  from dba_directories;
  
--- crear objeto directorio  
  create directory escritorio as 'escritorio';
 
 --- Validar archivos bajo objeto directorio:
 select object_name, bytes from table(dbms_cloud.LIST_FILES('ESCRITORIO'));
 

--- Crear credencial   
BEGIN
dbms_cloud.CREATE_CREDENTIAL(CREDENTIAL_NAME=>'credencialsammy'
                            ,USERNAME=>'sammy'
                            ,PASSWORD=>'Oracle.1234567890');
END;
/

--- Obtener archivo desde el bucket.
BEGIN
   DBMS_CLOUD.GET_OBJECT(
   credential_name => 'credencialsammy',
   object_uri => 'https://objectstorage.sa-saopaulo-1.oraclecloud.com/p/TVr6BsXJUa5U_P8jkeqWRvPMe9oQo4DBPcP6aJHkBYP4Et4223otFV61cC7ZeElh/n/grfjpkromtvq/b/pepito/o/30.jpg',
   directory_name => 'ESCRITORIO');
END;
/

-- EJEMPLO: trabajando con BLOB en tablas:

create table tabla005d
(id number(10)
,nombre varchar2(50)
,imagen blob  DEFAULT EMPTY_BLOB());

--- PRUEBAS:
--- 1 Insertar primer registro sin imagen
--- 2 Insertar segundo registro con imagen
--- 3 Actualizar imagen del segundo registro:

select * from tabla005D

insert into tabla005d 
      columns(id, nombre)
       values (1,'Nombre1');


DECLARE
v_blob BLOB; 
v_bfile BFILE;
BEGIN
  INSERT INTO tabla005d 
         COLUMNS(id, nombre, imagen)
         VALUES(20,'Juan ',EMPTY_BLOB())
  RETURNING imagen INTO v_blob;
  --  A la variable v_bfile se le asigna la ruta y nombre del archive jpg que se desea cargar
  v_bfile:=BFILENAME('ESCRITORIO','20.jpg');
  -- Abrir archivo en modo lectura
  DBMS_LOB.OPEN(v_bfile,DBMS_LOB.LOB_READONLY);
  -- Cargar contenido del archivo en variable blob
  DBMS_LOB.LOADFROMFILE(v_blob,v_bfile,DBMS_LOB.GETLENGTH(v_bfile));
  -- Cerrar archivo
  DBMS_LOB.CLOSE(v_bfile);
  COMMIT;
END;
/ 
-- 3
DECLARE
reg_tabla tabla005d%ROWTYPE;
v_blob blob;
v_bfile bfile;
v_existe_archivo number(38);
v_foto VARCHAR2(20);
BEGIN
     SELECT * 
       INTO reg_tabla
       FROM tabla005d 
       WHERE id = 20 FOR UPDATE;
       v_blob:=reg_tabla.imagen;
       v_foto:= '10.jpg';
       v_bfile:= BFILENAME ('ESCRITORIO',v_foto);
       DBMS_LOB.FILEOPEN(v_bfile, DBMS_LOB.FILE_READONLY);
       DBMS_LOB.LOADFROMFILE(v_blob,v_bfile, DBMS_LOB.GETLENGTH(v_bfile));
       DBMS_LOB.FILECLOSE(v_bfile);
       COMMIT;
END;
/