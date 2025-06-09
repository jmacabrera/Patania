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

//PAGINA DE CONSEJOS
class ConsejosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: [
            // Navegación superior
            Container(
              color: Color(0xFFF3EAEA),
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navTab('Home'),
                  _navTab('Rutinas'),
                  _navTab('Consejos', isSelected: true),
                  _navTab('Servicios'),
                ],
              ),
            ),

            // Perfil de la mascota
            Container(
              color: Color(0xFFF3EAEA),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/dog.png'), // Tu imagen
                    radius: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tommy',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Golden retriever'),
                      Text('8 kg   ·   2 años'),
                    ],
                  ),
                ],
              ),
            ),

            // Lista de consejos
            Expanded(
              child: Container(
                color: Color(0xFFF3EAEA),
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    _consejoCard(
                      icon: Icons.opacity,
                      title: 'Hidratación constante',
                      text:
                          'Asegúrate de que tu mascota tenga siempre agua fresca disponible. Cambia el agua al menos dos veces al día, especialmente en días calurosos.',
                    ),
                    _consejoCard(
                      icon: Icons.pets,
                      title: 'Paseos con correa adecuada',
                      text:
                          'Utiliza una correa del tamaño y tipo adecuado según la raza y energía de tu mascota. Esto mejora la seguridad y la experiencia del paseo.',
                      hasFavorite: true,
                    ),
                    _consejoCard(
                      icon: Icons.pets,
                      title: 'Revisión dental mensual',
                      text:
                          'Revisa los dientes y encías de tu mascota una vez al mes. El mal aliento o encías rojas pueden ser signos de problemas.',
                      hasFavorite: true,
                    ),
                  ],
                ),
              ),
            ),

            // Navegación inferior
            Container(
              color: Colors.black87,
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, color: Colors.white),
                  Icon(Icons.pets,
                      color:
                          Colors.white), // Necesitarías un ícono personalizado
                  Icon(Icons.emoji_events, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navTab(String label, {bool isSelected = false}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            decoration:
                isSelected ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget _consejoCard({
    required IconData icon,
    required String title,
    required String text,
    bool hasFavorite = false,
  }) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(text),
                ],
              ),
            ),
            if (hasFavorite) Icon(Icons.favorite_border),
          ],
        ),
      ),
    );
  }
}
