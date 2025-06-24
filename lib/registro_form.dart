import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importar Firebase Auth
import 'package:patania_app/services/database_service.dart'; // Importar DatabaseService

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Clave para el formulario.

  // Controladores para los campos de texto del formulario.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController =
      TextEditingController(); // Aunque no se usa en Firebase Auth, se mantiene si es para tu lógica.
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Instancia de Firebase Auth.
  final DatabaseService _databaseService =
      DatabaseService(); // Instancia de tu servicio de base de datos.

  // Función para manejar el proceso de registro.
  void _register() async {
    // Valida todos los campos del formulario.
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final username = _usernameController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;
      final email = _emailController.text;

      debugPrint('Nombre: $name');
      debugPrint('Usuario: $username');
      debugPrint('Contraseña: $password');
      debugPrint('Email: $email');

      // Verifica que las contraseñas coincidan.
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden.')),
        );
        return; // Detiene el proceso si no coinciden.
      }

      try {
        // Intenta crear un nuevo usuario con email y contraseña en Firebase Auth.
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Si el registro fue exitoso, `userCredential.user` no será nulo.
        if (userCredential.user != null) {
          // Después de crear el usuario en Auth, crea su perfil en Firestore.
          await _databaseService.createUserProfile(userCredential.user!, email);

          // Muestra un mensaje de éxito.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('¡Registro exitoso! Ahora puedes iniciar sesión.')),
          );

          // Navega de vuelta a la pantalla de login.
          Navigator.pushReplacementNamed(context, '/login');
        }
      } on FirebaseAuthException catch (e) {
        // Captura errores específicos de Firebase Authentication.
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = 'La contraseña es demasiado débil.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'El correo electrónico ya está en uso.';
        } else {
          errorMessage = 'Error de registro: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        debugPrint('FirebaseAuthException: ${e.code} - ${e.message}');
      } catch (e) {
        // Captura cualquier otro tipo de error.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error inesperado durante el registro: $e')),
        );
        debugPrint('Error general de registro: $e');
      }
    }
  }

  @override
  void dispose() {
    // Limpia los controladores cuando el widget se elimina.
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EAEA), // Color de fondo del Scaffold
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context)
                        .padding
                        .vertical, // Ajusta para el SafeArea
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey, // Asocia el GlobalKey con el Form
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Crea tu cuenta',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      // Campo de nombre
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDecoration('Nombre completo'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu nombre.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Campo de usuario (manteniéndolo si es necesario para tu lógica,
                      // aunque no se use directamente para Firebase Auth)
                      TextFormField(
                        controller: _usernameController,
                        decoration: _inputDecoration('Usuario'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un nombre de usuario.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Campo de email
                      TextFormField(
                        controller: _emailController,
                        decoration: _inputDecoration('Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu email.';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Ingresa un email válido.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Campo de contraseña
                      TextFormField(
                        controller: _passwordController,
                        decoration: _inputDecoration('Contraseña'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa una contraseña.';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Campo de confirmar contraseña
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: _inputDecoration('Confirmar Contraseña'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirma tu contraseña.';
                          }
                          if (value != _passwordController.text) {
                            return 'Las contraseñas no coinciden.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      // Botón de registro
                      ElevatedButton(
                        onPressed: _register, // Llama a la función _register
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Registrarse',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      const SizedBox(height: 24),
                      // Texto para iniciar sesión si ya tiene cuenta
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context); // Vuelve a la pantalla de login
                        },
                        child: RichText(
                          text: TextSpan(
                            text: '¿Ya tienes una cuenta? ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                            children: [
                              TextSpan(
                                text: 'Inicia sesión',
                                style: TextStyle(
                                  color: Colors.blue[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Decoración común para los campos de entrada de texto.
  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.blue, width: 1.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
    );
  }
}
