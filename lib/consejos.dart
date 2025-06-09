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