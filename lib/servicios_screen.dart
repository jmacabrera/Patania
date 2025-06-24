import 'package:flutter/material.dart';
import 'package:patania_app/home_pr.dart'; // Importa HomeScreen
import 'package:patania_app/consejos.dart'; // Importa Consejos
import 'package:patania_app/trofeos_actividad.dart'; // Importa TrofeosActividadScreen
import 'package:patania_app/trofeos_alimentacion.dart'; // Importa TrofeosAlimentacionScreen

import 'package:patania_app/services/database_service.dart'; // Importa tu servicio de base de datos

class ServiciosScreen extends StatefulWidget {
  // SE QUITA 'const' de aquí
  ServiciosScreen({super.key});

  @override
  State<ServiciosScreen> createState() => _ServiciosScreenState();
}

class _ServiciosScreenState extends State<ServiciosScreen> {
  int _selectedTabIndex =
      3; // 3 para Servicios (esta pantalla estará seleccionada).
  final DatabaseService _databaseService =
      DatabaseService(); // Instancia del servicio.

  // Widget para construir cada pestaña de navegación superior.
  Widget _buildNavTab(String label, int index, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            setState(() {
              _selectedTabIndex = index;
            });
            // Lógica de navegación.
            if (label == 'Home') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen())); // SE QUITO 'const'
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
                      builder: (context) => Consejos())); // SE QUITO 'const'
            } else if (label == 'Servicios') {
              // Ya estamos en esta pantalla.
            } else if (label == 'Trofeos') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TrofeosActividadScreen())); // SE QUITO 'const'
            }
          },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: _selectedTabIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Widget para construir un icono de servicio.
  Widget _buildServiceIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Icon(icon, size: 40, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EAEA),
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado y tabs superiores (igual que en otras pantallas).
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
                      _buildNavTab('Home', 0,
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen()))), // SE QUITO 'const'
                      _buildNavTab('Rutinas', 1),
                      _buildNavTab('Consejos', 2,
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Consejos()))), // SE QUITO 'const'
                      _buildNavTab(
                          'Servicios', 3), // Esta pestaña estará seleccionada.
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Contenido principal scrollable.
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // --- Card de servicios (¡Datos desde Firestore!) ---
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Servicios Disponibles',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // StreamBuilder para escuchar cambios en la colección 'services' en tiempo real.
                            StreamBuilder<List<AppService>>(
                              stream: _databaseService
                                  .streamServices(), // Obtiene el stream de servicios públicos.
                              builder: (context, snapshot) {
                                // Manejo de estados: error, carga, o sin datos.
                                if (snapshot.hasError) {
                                  debugPrint(
                                      'Error en StreamBuilder de servicios: ${snapshot.error}');
                                  return Center(
                                      child: Text(
                                          'Error al cargar servicios: ${snapshot.error}',
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
                                      'No hay servicios disponibles.',
                                      style:
                                          const TextStyle(color: Colors.black));
                                }

                                final services = snapshot.data!;
                                // Muestra los servicios en una fila desplazable horizontalmente.
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, // Alinea al inicio si hay pocos ítems.
                                    children: services
                                        .map((service) => Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                      8.0), // Espacio entre iconos.
                                              child: _buildServiceIcon(
                                                // Convierte el iconCodePoint (String) de vuelta a IconData.
                                                IconData(
                                                    int.parse(
                                                        service.iconCodePoint),
                                                    fontFamily:
                                                        'MaterialIcons'),
                                                service.name,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Sección de recordatorios (estática en esta pantalla, podría ser dinámica si se conecta a los recordatorios de mascotas).
                    // Para hacerla dinámica, necesitarías el ID de la mascota actual, quizás pasándolo desde HomeScreen.
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.alarm,
                                size: 30, color: Colors.black),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Recordatorios',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Vacuna el 27 de julio', // Estos datos son estáticos actualmente.
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Peluquería el 12 de julio', // Estos datos son estáticos actualmente.
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
      // Barra de navegación inferior.
      bottomNavigationBar: Container(
        color: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen())); // SE QUITO 'const'
              },
            ),
            IconButton(
              icon: const Icon(Icons.pets, color: Colors.white, size: 30),
              onPressed: () {
                debugPrint('Navegar a Rutinas o Perfil');
                // TODO: Implementar navegación a la pantalla de Rutinas/Perfil.
              },
            ),
            IconButton(
              icon:
                  const Icon(Icons.emoji_events, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TrofeosActividadScreen())); // SE QUITO 'const'
              },
            ),
          ],
        ),
      ),
    );
  }
}
