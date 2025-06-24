import 'package:flutter/material.dart';
// Importa tus pantallas de navegación:
import 'package:patania_app/consejos.dart';
import 'package:patania_app/servicios_screen.dart';
import 'package:patania_app/trofeos_actividad.dart';
import 'package:patania_app/trofeos_alimentacion.dart';

import 'package:patania_app/services/database_service.dart'; // Importa tu servicio de base de datos
import 'package:firebase_auth/firebase_auth.dart'; // Necesario para obtener el UID del usuario
import 'package:cloud_firestore/cloud_firestore.dart'; // Necesario para usar Timestamp

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex =
      0; // Índice de la pestaña de navegación superior (0 para Home).
  final DatabaseService _databaseService =
      DatabaseService(); // Instancia de tu servicio de base de datos.

  // ID de la mascota actualmente seleccionada. Será nulo al principio.
  String? _currentPetId;

  // NUEVA VARIABLE DE ESTADO: Para controlar si la carga inicial de datos de la mascota ha terminado.
  bool _isLoadingInitialPetData = true;

  // Controladores para el diálogo de añadir mascota (si usas un diálogo).
  final TextEditingController _dialogNameController = TextEditingController();
  final TextEditingController _dialogBreedController = TextEditingController();
  final TextEditingController _dialogWeightController = TextEditingController();
  final TextEditingController _dialogAgeController = TextEditingController();
  final _dialogFormKey =
      GlobalKey<FormState>(); // Clave para validar el formulario del diálogo.

  @override
  void initState() {
    super.initState();
    // Escucha los cambios en el estado de autenticación de Firebase.
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        debugPrint("Usuario autenticado con UID: ${user.uid}");
        // Si hay un usuario, intenta cargar la primera mascota.
        _loadInitialPetData(user.uid);
      } else {
        // Si no hay usuario autenticado, reinicia y marca la carga como finalizada.
        debugPrint("No hay usuario autenticado.");
        setState(() {
          _currentPetId = null;
          _isLoadingInitialPetData =
              false; // Importante: marca la carga como finalizada.
        });
      }
    });
  }

  // Carga el ID de la primera mascota del usuario.
  Future<void> _loadInitialPetData(String userId) async {
    try {
      final pets = await _databaseService
          .streamPets()
          .first; // Obtiene la primera emisión del stream.
      if (pets.isNotEmpty) {
        setState(() {
          _currentPetId = pets.first.id;
          _isLoadingInitialPetData = false; // Carga inicial finalizada.
        });
        debugPrint("Mascota inicial cargada: ${_currentPetId}");
      } else {
        debugPrint(
            "No se encontraron mascotas para el usuario. Sugiere añadir una.");
        setState(() {
          _currentPetId = null; // Si no hay mascotas, el ID de mascota es nulo.
          _isLoadingInitialPetData = false; // Carga inicial finalizada.
        });
      }
    } catch (e) {
      debugPrint("Error al cargar mascota inicial: $e");
      setState(() {
        _currentPetId = null; // Reinicia el ID de mascota en caso de error.
        _isLoadingInitialPetData =
            false; // Carga inicial finalizada (con error).
      });
    }
  }

  // Widget para construir cada pestaña de navegación superior.
  Widget _buildNavTab(String label, int index, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            setState(() {
              _selectedTabIndex = index;
              debugPrint('Pestaña seleccionada: $label');
            });
            if (label == 'Home') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            } else if (label == 'Consejos') {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Consejos()));
            } else if (label == 'Servicios') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ServiciosScreen()));
            } else if (label == 'Rutinas') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Funcionalidad de Rutinas no implementada.')),
              );
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

  // Widget para construir un icono de rutina (usado en la sección "Rutinas de Hoy").
  Widget _buildRoutineIcon(IconData icon, String label) {
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

  // Widget para construir una tarjeta de recordatorio.
  Widget _buildReminderCard(IconData icon, String title, String date) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.black),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dialogNameController.dispose();
    _dialogBreedController.dispose();
    _dialogWeightController.dispose();
    _dialogAgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Si la carga inicial de los datos de la mascota aún no ha finalizado, muestra la pantalla de carga.
    // Esto se ejecutará solo una vez al inicio.
    if (_isLoadingInitialPetData) {
      return Scaffold(
        backgroundColor: const Color(0xFFF3EAEA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                _databaseService.currentUserId == null
                    ? 'Esperando autenticación...'
                    : 'Cargando datos de la mascota...',
                style: const TextStyle(color: Colors.black),
              ),
              if (_databaseService.currentUserId != null)
                Text('ID Usuario: ${_databaseService.currentUserId}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    // Si la carga inicial ha finalizado, construye la interfaz principal.
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
                      _buildNavTab('Home', 0),
                      _buildNavTab('Rutinas', 1),
                      _buildNavTab('Consejos', 2),
                      _buildNavTab('Servicios', 3),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Sección de perfil de la mascota (¡Datos desde Firestore!)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: StreamBuilder<List<Pet>>(
                        stream: _databaseService.streamPets(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            debugPrint(
                                'Error en StreamBuilder de mascotas: ${snapshot.error}');
                            return Center(
                                child: Text(
                                    'Error al cargar mascota: ${snapshot.error}',
                                    style:
                                        const TextStyle(color: Colors.black)));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          // AQUÍ ES DONDE SE MANEJA SI NO HAY DATOS O LA LISTA ESTÁ VACÍA
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Text('No hay mascotas registradas.',
                                        style: TextStyle(color: Colors.black)),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showAddPetDialog(context);
                                      },
                                      child: const Text('Añadir Nueva Mascota'),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }

                          final pet = snapshot.data!.first;
                          _currentPetId =
                              pet.id; // Actualiza el ID de la mascota actual.

                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage: pet.profileImageUrl != null
                                        ? NetworkImage(pet.profileImageUrl!)
                                        : null,
                                    backgroundColor: Colors.blueGrey,
                                    child: pet.profileImageUrl == null
                                        ? const Icon(Icons.pets,
                                            size: 35, color: Colors.white)
                                        : null,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(pet.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black)),
                                      Text(pet.breed,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      const SizedBox(height: 4),
                                      Text(
                                          '${pet.weight} kg  ·  ${pet.age} años',
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Sección "Rutinas de Hoy"
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
                              const Text('Rutinas de Hoy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                              const SizedBox(height: 16),
                              if (_currentPetId != null)
                                StreamBuilder<List<Routine>>(
                                  stream: _databaseService
                                      .streamRoutines(_currentPetId!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      debugPrint(
                                          'Error en StreamBuilder de rutinas: ${snapshot.error}');
                                      return Text(
                                          'Error al cargar rutinas: ${snapshot.error}',
                                          style: const TextStyle(
                                              color: Colors.black));
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Text(
                                          'No hay rutinas programadas.',
                                          style: const TextStyle(
                                              color: Colors.black));
                                    }

                                    final routines = snapshot.data!;
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: routines
                                            .map((routine) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: _buildRoutineIcon(
                                                    _getIconForRoutineType(
                                                        routine.type),
                                                    '${routine.description} (${routine.time})',
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    );
                                  },
                                )
                              else
                                const Text(
                                    'Selecciona una mascota para ver rutinas.',
                                    style:
                                        const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Sección "Recordatorios"
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
                              const Text('Recordatorios',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                              const SizedBox(height: 16),
                              if (_currentPetId != null)
                                StreamBuilder<List<Reminder>>(
                                  stream: _databaseService
                                      .streamReminders(_currentPetId!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      debugPrint(
                                          'Error en StreamBuilder de recordatorios: ${snapshot.error}');
                                      return Text(
                                          'Error al cargar recordatorios: ${snapshot.error}',
                                          style: const TextStyle(
                                              color: Colors.black));
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Text('No hay recordatorios.',
                                          style: const TextStyle(
                                              color: Colors.black));
                                    }

                                    final reminders = snapshot.data!;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: reminders.length,
                                      itemBuilder: (context, index) {
                                        final reminder = reminders[index];
                                        return _buildReminderCard(
                                          Icons.alarm,
                                          reminder.title,
                                          'el ${reminder.date.toDate().day}/${reminder.date.toDate().month}/${reminder.date.toDate().year}',
                                        );
                                      },
                                    );
                                  },
                                )
                              else
                                const Text(
                                    'Selecciona una mascota para ver recordatorios.',
                                    style:
                                        const TextStyle(color: Colors.black)),
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
      bottomNavigationBar: Container(
        color: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.pets, color: Colors.white, size: 30),
              onPressed: () {
                debugPrint('Navegar a Rutinas o Perfil');
              },
            ),
            IconButton(
              icon:
                  const Icon(Icons.emoji_events, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrofeosActividadScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForRoutineType(String type) {
    switch (type) {
      case 'Alimentación':
        return Icons.fastfood;
      case 'Caminata':
        return Icons.directions_walk;
      case 'Medicación':
        return Icons.local_pharmacy;
      default:
        return Icons.event;
    }
  }

  void _showAddPetDialog(BuildContext context) {
    _dialogNameController.clear();
    _dialogBreedController.clear();
    _dialogWeightController.clear();
    _dialogAgeController.clear();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Añadir Nueva Mascota'),
          content: SingleChildScrollView(
            child: Form(
              key: _dialogFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _dialogNameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Requerido';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dialogBreedController,
                    decoration: const InputDecoration(labelText: 'Raza'),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Requerido';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dialogWeightController,
                    decoration: const InputDecoration(labelText: 'Peso (kg)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Requerido';
                      if (double.tryParse(value) == null)
                        return 'Número válido';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dialogAgeController,
                    decoration: const InputDecoration(labelText: 'Edad (años)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Requerido';
                      if (int.tryParse(value) == null) return 'Número válido';
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Añadir'),
              onPressed: () async {
                if (_dialogFormKey.currentState!.validate()) {
                  final newPet = Pet(
                    id: '',
                    name: _dialogNameController.text,
                    breed: _dialogBreedController.text,
                    weight: double.parse(_dialogWeightController.text),
                    age: int.parse(_dialogAgeController.text),
                    ownerId: _databaseService.currentUserId!,
                  );
                  try {
                    await _databaseService.addPet(newPet);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Mascota añadida con éxito!')),
                    );
                    Navigator.of(dialogContext).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al añadir mascota: $e')),
                    );
                    debugPrint('Error al añadir mascota: $e');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
