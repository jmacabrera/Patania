import 'package:flutter/material.dart';

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _register() {
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

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('¡Registro exitoso! (Datos impresos en consola)')),
        );
      }
    }
  }

  @override
  void dispose() {
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
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Patania',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDecoration('Nombre'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _usernameController,
                        decoration: _inputDecoration('Usuario'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un nombre de usuario';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: _inputDecoration('Contraseña'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa una contraseña';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: _inputDecoration('Confirmar contraseña'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor confirma tu contraseña';
                          }
                          if (value != _passwordController.text) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration('Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu email';
                          }

                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Por favor ingresa un email válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          debugPrint('Navegar a pantalla de inicio de sesión');
                        },
                        child: RichText(
                          text: TextSpan(
                            text: '¿Ya estás registrado? ',
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
