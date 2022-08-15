$(function() {
	// Inicio de validacion de registro
	$("form[name='registration']").validate({
	  // Specify validation rules
	  rules: {
		// of an input field. Validation rules are defined
		// on the right side
		firstname: "required",
		lastname: "required",
		email: {
		  required: true,
		  // specificacion del correo 
		  // Regla de correo incorporadas
		  email: true
		},
		password: {
		  required: true,
		  minlength: 5
		}
	  },
      // Specificacion de error en mensages
	  messages: {
		firstname: "Por favor, introduzca su nombre",
		lastname: "Por favor, introduzca su apellido",
		password: {
		  required: "Por favor introdusca una contraseña",
		  minlength: "Su contraseña debe tener al menos 5 caracteres."
		},
		email: "Por favor, introduce una dirección de correo electrónico válida"
	  },
	  submitHandler: function(form) {
		form.submit();
	  }
	});
  });