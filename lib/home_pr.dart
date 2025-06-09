import 'package:flutter/material.dart';
import 'package:patania_app/consejos.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int _selectedTabIndex =
      0; // 0 para Home, 1 para Rutinas, 2 para Consejos, 3 para Servicios


  Widget _buildNavTab(String label, int index) {
 
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex =
              index; // Actualiza el índice de la pestaña seleccionada
        
          debugPrint('Pestaña seleccionada: $label');
        });
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: _selectedTabIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
              
              decoration: TextDecoration.none, // Siempre sin subrayado
              color: Colors.black, // El texto de las pestañas es negro
            ),
          ),
          // Eliminado el indicador de línea debajo de la pestaña seleccionada
          // if (_selectedTabIndex == index)
          //   Container(
          //     margin: const EdgeInsets.only(top: 4),
          //     height: 2,
          //     width: 30,
          //     color: Colors.black, 
          //   ),
        ],
      ),
    );
  }

  
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
          child: Icon(icon,
              size: 40,
              color: Colors.black), // Icono de rutina (ej. hueso, pata)
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(color: Colors.black)), 
      ],
    );
  }

  // Función para construir una tarjeta de recordatorio
  Widget _buildReminderCard(IconData icon, String title, String date) {
    return Card(
      elevation: 3, // Sombra para la tarjeta de recordatorio
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon,
                size: 30,
                color: Colors.black), // Icono del recordatorio (ej. reloj)
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16)), 
                const SizedBox(height: 4),
                Text(date,
                    style: const TextStyle(
                        color: Colors.grey)), 
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor:
          const Color(0xFFF3EAEA), // Color de fondo claro como en la imagen
      body: SafeArea(
       
        child: Column(
          children: [
            
            Container(
              color: const Color(0xFFF3EAEA), // Fondo de esta sección
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
                      //_buildNavTab('Consejos', 2),
                      //Text('Consejos'),
                      TextButton(
                        child: Text('Consejos'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Consejos()));
                    },
                  ),
                      _buildNavTab('Servicios', 3),
                    ],
                  ),
                ],
              ),
            ),
           
            const SizedBox(height: 16.0),

            // *******************************************************************
            // INICIO DE LA CORRECCIÓN DE DESBORDAMIENTO
            // Envolvemos el contenido principal en Expanded y SingleChildScrollView
            // *******************************************************************
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  // Esta columna contendrá todas las tarjetas y secciones que necesitan scroll
                  children: [
                    // Sección de perfil de la mascota (Tommy)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 5, // Sombra para la tarjeta de perfil
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Imagen de Tommy (reemplaza con tu asset de imagen)
                              const CircleAvatar(
                                radius: 35,
                                // backgroundImage: AssetImage('assets/tommy_dog.png'), // Asume que tienes esta imagen en 'assets/'
                                backgroundColor: Colors
                                    .grey, 
                                child: Icon(Icons.pets,
                                    size: 35,
                                    color:
                                        Colors.white), 
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Tommy',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  const Text('Golden retriever',
                                      style: TextStyle(color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  const Text('8 kg  ·  2 años',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                                      fontSize: 18)),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround, // Espacio equitativo entre iconos
                                children: [
                                  _buildRoutineIcon(Icons.fastfood,
                                      'Alimentación'), // Icono de comida
                                  _buildRoutineIcon(Icons.pets,
                                      'Caminatas'), // Icono de pata o paseo
                                  _buildRoutineIcon(Icons.local_pharmacy,
                                      'Medicación'), // Icono de medicina
                                ],
                              ),
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
                                      fontSize: 18)),
                              const SizedBox(height: 16),
                              _buildReminderCard(Icons.alarm, 'Vacuna',
                                  'el 27 de mayo'), // Icono de alarma
                              _buildReminderCard(Icons.alarm, 'Peluquería',
                                  'el 3 de junio'), // Icono de alarma
                              // Puedes añadir más recordatorios aquí y la pantalla hará scroll
                              // _buildReminderCard(Icons.alarm, 'Otro', 'Fecha'),
                              // _buildReminderCard(Icons.alarm, 'Otro más', 'Fecha'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        height:
                            16.0), // Espacio al final de la última tarjeta antes del borde de la pantalla
                  ],
                ),
              ),
            ),
            // *******************************************************************
            // FIN DE LA CORRECCIÓN DE DESBORDAMIENTO
            // *******************************************************************
          ],
        ),
      ),
      // Barra de navegación inferior
      bottomNavigationBar: Container(
        color: Colors.black87, // Fondo oscuro para la barra inferior
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home,
                  color: Colors.white, size: 30), // Icono Home
              onPressed: () {
                // Lógica de navegación o estado
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                debugPrint('Navegar a Home');
              },
            ),
            IconButton(
              icon: const Icon(Icons.pets,
                  color: Colors.white,
                  size: 30), // Icono de mascota (ej. para rutinas/perfil)
              onPressed: () {
                debugPrint('Navegar a Rutinas o Perfil');
              },
            ),
            IconButton(
              icon: const Icon(Icons.emoji_events,
                  color: Colors.white, size: 30), // Icono de premios/logros
              onPressed: () {
                debugPrint('Navegar a Logros');
              },
            ),
          ],
        ),
      ),
    );
  }
}
