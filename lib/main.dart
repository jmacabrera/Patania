import 'package:flutter/material.dart';
import 'package:patania_app/registro_form.dart';
import 'package:patania_app/home_pr.dart';

void main() => runApp(patania_app());

class patania_app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFF3EAEA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Patania',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 16),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(Icons.pets, size: 40, color: Colors.black),
              ),
              SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text('¿Olvidaste contraseña?',
                      style: TextStyle(fontSize: 12)),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  backgroundColor: Colors.black,
                ),
                child: Text('Iniciar sesión'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿No tienes cuenta?'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Crea tu cuenta'),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text('O conéctate con'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.mail, size: 30),
                    onPressed: () {},
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.facebook, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
