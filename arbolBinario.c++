/* #include <iostream>
#include <conio.h>
#include <stdlib.h>
using namespace std;

struct Nodo{
	int dato;
	Nodo *der;
	Nodo *izq;	
};


// portotipos
void menu();
Nodo *crearNodo(int);
void insertarNodo(Nodo *&, int);

Nodo *arbol = NULL;



int main(){
	
	menu();
	
	
	getch();
	return 0;
}

// funcion para insertasr elementos en el arbol
void insertarNodo(Nodo *&arbol, int n){
	if(arbol == NULL){ // si el arbol esta vacio
		Nodo *nuevo_nodo = crearNodo(n);
		arbol = nuevo_nodo;
	}else{ // si el arbol tiene un nodo o mas nodos 
	
		int valorRaiz = arbol->dato; // obtenemos el valor de la raiz 
		
		if(n < valorRaiz){// si el elemento es menor a la raiz, insertamos en izq
		
			insertarNodo(arbol->der,n);
		}else{
			insertarNodo(arbol->der,n);
		}
	}
}



// funcion de menu
void menu(){
	int dato, opcion;
	
	do{
		cout<<"\t :MENU:"<<endl;
		cout<<"1. Insertar un nuevo nodo"<<endl;
		cout<<"2. salir"<<endl;
		cout<<"Ingrese una opcion: ";
		cin>>opcion;
		switch(opcion){
			case 1:
				cout<<"\nDigite un numero: ";
				cin>>dato;
				insertarNodo(arbol, dato); // insertamos un nuevo nodo
				cout<<"\n";
				system("pause");
				break;
		}
		system("cls");
	}while(opcion != 2);
}


// funcion para crea un tipo de nodo
Nodo *crearNodo(int n){
	Nodo *nuevoNodo = new Nodo();
	
	nuevoNodo ->dato = n;
	nuevoNodo ->der = NULL;
	nuevoNodo ->izq = NULL;
	
	return nuevoNodo;
}
*/