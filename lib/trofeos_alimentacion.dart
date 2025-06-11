import 'package:flutter/material.dart';

class TrofeosAlimentacionScreen extends StatelessWidget {
  const TrofeosAlimentacionScreen({super.key});

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
                          fontWeight: FontWeight.bold, fontSize: 16)),
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
                              const Text('Trofeos de Alimentación',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 16),
                              _buildTrophyCard(Icons.fastfood, 'Comida al Día',
                                  'Registrar las comidas durante un día completo.'),
                              _buildTrophyCard(Icons.check_circle, 'Semana Saludable',
                                  'Alimentar correctamente durante 7 días.'),
                              _buildTrophyCard(Icons.access_time, 'Hora Exacta',
                                  'Alimentar a la misma hora 3 días seguidos.'),
                              _buildTrophyCard(Icons.recommend, 'Nutrición Premium',
                                  'Elegir alimentos recomendados por veterinarios.'),
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
                              const Text('Trofeos de Higiene',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 16),
                              _buildTrophyCard(Icons.clean_hands, 'Baño Perfecto',
                                  'Registrar un baño en el tiempo recomendado.'),
                              _buildTrophyCard(Icons.content_cut, 'Uñas a Tiempo',
                                  'Cortar las uñas según el calendario.'),
                              _buildTrophyCard(Icons.health_and_safety, 'Limpieza Dental',
                                  'Registrar cepillados dentales regulares.'),
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