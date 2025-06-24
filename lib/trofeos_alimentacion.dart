import 'package:flutter/material.dart';
import 'package:patania_app/home_pr.dart'; // Importa HomeScreen para la navegación.
import 'package:patania_app/consejos.dart'; // Importa Consejos para la navegación.
import 'package:patania_app/servicios_screen.dart'; // Importa ServiciosScreen para la navegación.
import 'package:patania_app/trofeos_actividad.dart'; // Importa TrofeosActividadScreen para la navegación.

import 'package:patania_app/services/database_service.dart'; // Importa tu servicio de base de datos.

class TrofeosAlimentacionScreen extends StatelessWidget {
  // SE QUITO 'const' de aquí en una corrección anterior.
  TrofeosAlimentacionScreen({super.key});

  // Instancia de tu servicio de base de datos.
  final DatabaseService _databaseService = DatabaseService();

  // Widget para construir una tarjeta de trofeo.
  Widget _buildTrophyCard(IconData icon, String title, String description) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir una pestaña de navegación superior.
  // RECIBE 'BuildContext context' como argumento.
  Widget _buildNavTab(String label, BuildContext context,
      {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            // Lógica de navegación.
            if (label == 'Home') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen())); // SE QUITO 'const' AQUI
            } else if (label == 'Rutinas') {
              // TODO: Navegar a Rutinas.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Funcionalidad de Rutinas no implementada.')),
              );
            } else if (label == 'Consejos') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Consejos())); // SE QUITO 'const' AQUI
            } else if (label == 'Servicios') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ServiciosScreen())); // SE QUITO 'const' AQUI
            } else if (label == 'Trofeos') {
              // Navega a la pantalla de Trofeos de Actividad por defecto para el tab "Trofeos".
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TrofeosActividadScreen())); // SE QUITO 'const' AQUI
            }
          },
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EAEA),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFF3EAEA),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Column(
                children: [
                  const Text(
                    'Patania',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SE PASA 'context' Y SE QUITA 'const' DE LAS LLAMADAS A CONSTRUCTORES
                      _buildNavTab('Home', context,
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()))),
                      _buildNavTab('Rutinas', context),
                      _buildNavTab('Consejos', context,
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Consejos()))),
                      _buildNavTab('Servicios', context,
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ServiciosScreen()))),
                      _buildNavTab('Trofeos', context,
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TrofeosActividadScreen()))),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Perfil de la mascota (estático aquí).
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.pets,
                                    size: 35, color: Colors.white),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Tommy',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black)),
                                  Text('Golden retriever',
                                      style: TextStyle(color: Colors.grey)),
                                  SizedBox(height: 4),
                                  Text('8 kg  ·  2 años',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // --- Sección de Trofeos de Alimentación (¡Datos desde Firestore!) ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Trofeos de Alimentación',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                              const SizedBox(height: 16),
                              // StreamBuilder para obtener las definiciones de trofeos.
                              StreamBuilder<List<TrophyDefinition>>(
                                stream:
                                    _databaseService.streamTrophyDefinitions(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    debugPrint(
                                        'Error en StreamBuilder de trofeos de alimentación: ${snapshot.error}');
                                    return Center(
                                        child: Text(
                                            'Error al cargar logros: ${snapshot.error}',
                                            style: const TextStyle(
                                                color: Colors.black)));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Text(
                                        'No hay logros de alimentación definidos.',
                                        style: const TextStyle(
                                            color: Colors.black));
                                  }

                                  // Filtra los trofeos por categoría "Alimentación".
                                  final foodTrophies = snapshot.data!
                                      .where((trophy) =>
                                          trophy.category == 'Alimentación')
                                      .toList();

                                  if (foodTrophies.isEmpty) {
                                    return const Text(
                                        'No hay logros de alimentación definidos en esta categoría.',
                                        style: const TextStyle(
                                            color: Colors.black));
                                  }

                                  return Column(
                                    children: foodTrophies
                                        .map((trophy) => _buildTrophyCard(
                                              IconData(
                                                  int.parse(
                                                      trophy.iconCodePoint),
                                                  fontFamily: 'MaterialIcons'),
                                              trophy.title,
                                              trophy.description,
                                            ))
                                        .toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),
                    // --- Sección de Trofeos de Higiene (¡Datos desde Firestore!) ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Trofeos de Higiene',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                              const SizedBox(height: 16),
                              StreamBuilder<List<TrophyDefinition>>(
                                stream:
                                    _databaseService.streamTrophyDefinitions(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    debugPrint(
                                        'Error en StreamBuilder de trofeos de higiene: ${snapshot.error}');
                                    return Center(
                                        child: Text(
                                            'Error al cargar logros: ${snapshot.error}',
                                            style: const TextStyle(
                                                color: Colors.black)));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Text(
                                        'No hay logros de higiene definidos.',
                                        style: const TextStyle(
                                            color: Colors.black));
                                  }

                                  // Filtra los trofeos por categoría "Higiene".
                                  final hygieneTrophies = snapshot.data!
                                      .where((trophy) =>
                                          trophy.category == 'Higiene')
                                      .toList();

                                  if (hygieneTrophies.isEmpty) {
                                    return const Text(
                                        'No hay logros de higiene definidos en esta categoría.',
                                        style: const TextStyle(
                                            color: Colors.black));
                                  }

                                  return Column(
                                    children: hygieneTrophies
                                        .map((trophy) => _buildTrophyCard(
                                              IconData(
                                                  int.parse(
                                                      trophy.iconCodePoint),
                                                  fontFamily: 'MaterialIcons'),
                                              trophy.title,
                                              trophy.description,
                                            ))
                                        .toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
