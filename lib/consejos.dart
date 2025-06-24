import 'package:flutter/material.dart';
import 'package:patania_app/home_pr.dart';
import 'package:patania_app/servicios_screen.dart';
import 'package:patania_app/trofeos_actividad.dart';
import 'package:patania_app/trofeos_alimentacion.dart';

import 'package:patania_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Necesario para obtener el UID del usuario

class Consejos extends StatefulWidget {
  Consejos({super.key});

  @override
  State<Consejos> createState() => _ConsejosState();
}

// PAGINA DE CONSEJOS
class _ConsejosState extends State<Consejos> {
  final DatabaseService _databaseService = DatabaseService();

  // Índice para controlar la pestaña seleccionada en la navegación superior (2 para Consejos).
  int _selectedTabIndex = 2;

  // Widget para construir cada pestaña de navegación superior.
  Widget _navTab(String label,
      {bool isSelected = false, VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            setState(() {
              _selectedTabIndex = label == 'Home'
                  ? 0
                  : (label == 'Rutinas'
                      ? 1
                      : (label == 'Consejos'
                          ? 2
                          : (label == 'Servicios' ? 3 : 0)));
            });
            if (label == 'Home') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            } else if (label == 'Rutinas') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Funcionalidad de Rutinas no implementada.')),
              );
            } else if (label == 'Servicios') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ServiciosScreen()));
            } else if (label == 'Trofeos') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrofeosActividadScreen()));
            }
          },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              decoration:
                  isSelected ? TextDecoration.underline : TextDecoration.none,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Widget para construir una tarjeta de consejo.
  Widget _consejoCard({
    required IconData icon,
    required String title,
    required String text,
    bool hasFavorite = false,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: Colors.black),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 8),
                  Text(text, style: const TextStyle(color: Colors.black87)),
                ],
              ),
            ),
            if (hasFavorite)
              const Icon(Icons.favorite_border, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Si el usuario no está autenticado, muestra una pantalla de carga.
    // Esto es vital porque no podemos obtener mascotas sin un UID.
    if (_databaseService.currentUserId == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF3EAEA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text('Esperando autenticación...',
                  style: const TextStyle(color: Colors.black)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: [
            // Navegación superior
            Container(
              color: const Color(0xFFF3EAEA),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navTab('Home',
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()))),
                  _navTab('Rutinas'),
                  _navTab('Consejos', isSelected: true),
                  _navTab('Servicios',
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServiciosScreen()))),
                ],
              ),
            ),

            // Perfil de la mascota (AHORA CARGA DINÁMICAMENTE DESDE FIRESTORE)
            Container(
              color: const Color(0xFFF3EAEA),
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<List<Pet>>(
                stream: _databaseService
                    .streamPets(), // Obtiene el Stream de mascotas del usuario actual.
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    debugPrint(
                        'Error en StreamBuilder de mascotas en Consejos: ${snapshot.error}');
                    return Center(
                        child: Text(
                            'Error al cargar mascota: ${snapshot.error}',
                            style: const TextStyle(color: Colors.black)));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No hay mascota principal registrada.',
                        style: TextStyle(color: Colors.black));
                  }

                  final pet = snapshot.data!
                      .first; // Asume que siempre mostrarás la primera mascota.

                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: pet.profileImageUrl != null
                            ? NetworkImage(pet.profileImageUrl!)
                            : null,
                        backgroundColor: Colors.grey,
                        child: pet.profileImageUrl == null
                            ? const Icon(Icons.pets,
                                size: 30, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pet.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(pet.breed,
                              style: const TextStyle(color: Colors.black87)),
                          Text('${pet.weight} kg   ·   ${pet.age} años',
                              style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            // Lista de consejos
            Expanded(
              child: Container(
                color: const Color(0xFFF3EAEA),
                child: StreamBuilder<List<Consejo>>(
                  stream: _databaseService.streamConsejos(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      debugPrint(
                          'Error en StreamBuilder de consejos: ${snapshot.error}');
                      return Center(
                          child: Text(
                              'Error al cargar consejos: ${snapshot.error}',
                              style: const TextStyle(color: Colors.black)));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No hay consejos disponibles aún.',
                              style: const TextStyle(color: Colors.black)));
                    }

                    final consejos = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: consejos.length,
                      itemBuilder: (context, index) {
                        final consejo = consejos[index];
                        return _consejoCard(
                          icon: IconData(int.parse(consejo.iconCodePoint),
                              fontFamily: 'MaterialIcons'),
                          title: consejo.title,
                          text: consejo.text,
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // Navegación inferior
            Container(
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
                              builder: (context) => HomeScreen()));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.pets, color: Colors.white, size: 30),
                    onPressed: () {
                      debugPrint('Navegar a Rutinas o Perfil');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_events,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrofeosActividadScreen()));
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
}
