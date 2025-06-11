import 'package:flutter/material.dart';

class TrofeosActividadScreen extends StatelessWidget {
  const TrofeosActividadScreen({super.key});

  Widget _buildTrophyCard(IconData icon, String title, String date) {
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
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(date,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTab(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
        color: Colors.black,
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
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
                      _buildNavTab('Home'),
                      _buildNavTab('Rutinas'),
                      _buildNavTab('Consejos'),
                      _buildNavTab('Servicios'),
                      _buildNavTab('Trofeos'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                child: Icon(Icons.pets, size: 35, color: Colors.white),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Tommy',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18)),
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
                              const Text('Logros de Actividad Física',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 16),
                              _buildTrophyCard(Icons.directions_walk, 'Paseo Diario',
                                  'Registrar al menos un paseo diario durante una semana.'),
                              _buildTrophyCard(Icons.fitness_center, 'Semana Activa',
                                  'Cumplir la cuota de actividad semanal.'),
                              _buildTrophyCard(Icons.nature_people, 'Aventura al aire libre',
                                  'Registrar un paseo en un lugar nuevo.'),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),
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
                              const Text('Logros de Salud',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 16),
                              _buildTrophyCard(Icons.local_hospital, 'Veterinario al Día',
                                  'Registrar una visita veterinaria.'),
                              _buildTrophyCard(Icons.vaccines, 'Vacunas al Día',
                                  'Mantener el calendario de vacunación completo.'),
                              _buildTrophyCard(Icons.assignment, 'Chequeo Completo',
                                  'Completar los campos de salud de la mascota.'),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),
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
                              const Text('Relación y Cariño',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 16),
                              _buildTrophyCard(Icons.cake, 'Día Especial',
                                  'Registrar el cumpleaños o adopción.'),
                              _buildTrophyCard(Icons.favorite, 'Tiempo de Calidad',
                                  'Pasar al menos 30 minutos de juego o interacción.'),
                              _buildTrophyCard(Icons.loyalty, 'Amigo Fiel',
                                  'Cuidar a la mascota más de 6 meses sin interrupciones.'),
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
