import 'package:flutter/material.dart';
import 'package:patania_app/home_pr.dart';
import 'package:patania_app/trofeos_actividad.dart';

class RutinasScream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Home', style: TextStyle(color: Colors.black)),
            Text('Rutinas', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
            Text('Consejos', style: TextStyle(color: Colors.black)),
            Text('Servicios', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Card de la mascota
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/tommy.jpg'), // Cambia por tu imagen
                  radius: 24,
                ),
                title: Text('Tommy'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Golden retriever'),
                    Row(
                      children: [
                        Text('8 kg', style: TextStyle(fontSize: 12)),
                        SizedBox(width: 16),
                        Text('2 años', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Botones Crear y Editar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Crear'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB8E986),
                    foregroundColor: Colors.black,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  label: Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB8E986),
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            // Leyenda de colores
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem(Color(0xFF00E676), 'Alimentación'),
                _buildLegendItem(Color(0xFFFFFF00), 'Caminata'),
                _buildLegendItem(Color(0xFFFFEB3B), 'Medicación'),
                _buildLegendItem(Color(0xFFFFF176), 'Vacunas programadas'),
              ],
            ),
            SizedBox(height: 24),
            // Barra de progreso
            Text('Progreso'),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.2,
              backgroundColor: Colors.grey[300],
              color: Color(0xFF00E676),
              minHeight: 16,
              borderRadius: BorderRadius.circular(8),
            ),
            Spacer(),
            // Barra de navegación inferior
            Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home, color: Colors.white, size: 32),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.pets, color: Colors.white, size: 32),
                    onPressed: () {
                      // Ya estás en Rutinas, puedes dejarlo vacío o mostrar un mensaje
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.emoji_events, color: Colors.white, size: 32),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TrofeosActividadScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            color: color,
            margin: EdgeInsets.only(right: 8),
          ),
          Text(text),
        ],
      ),
    );
  }
}