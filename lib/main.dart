import 'package:flutter/material.dart'; // Librería fundamental para la UI de Flutter.
import 'package:flutter/services.dart'; // Para interactuar con servicios de plataforma (ej. barra de estado).
import 'package:patania_app/registro_form.dart'; // Importa tu pantalla de registro.
import 'package:patania_app/home_pr.dart'; // Importa tu pantalla principal (Home).

// Importaciones de Firebase necesarias:
import 'package:firebase_core/firebase_core.dart'; // El core de Firebase para inicialización.
import 'package:firebase_auth/firebase_auth.dart'; // Para gestionar la autenticación de usuarios.
import 'package:cloud_firestore/cloud_firestore.dart'; // Aunque no se usa directamente aquí, es buena práctica tenerla por si acaso.

// Importa el archivo generado automáticamente por 'flutterfire configure'.
// Contiene las opciones de configuración de tu proyecto Firebase.
import 'package:patania_app/firebase_options.dart';

// Importa tus otras pantallas para poder definirlas en las rutas.
import 'package:patania_app/consejos.dart';
import 'package:patania_app/servicios_screen.dart';
import 'package:patania_app/trofeos_actividad.dart';
import 'package:patania_app/trofeos_alimentacion.dart';

// La función 'main' es el punto de entrada de la aplicación Flutter.
// Se marca como 'async' porque contiene operaciones que toman tiempo ('await').
void main() async {
  // 1. Asegura que los widgets de Flutter estén inicializados.
  // Esto es CRÍTICO. Debe llamarse antes de usar cualquier método de Flutter o plugins (como Firebase).
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Configura el modo de UI del sistema a inmersivo.
  // Esto oculta las barras de estado y navegación para dar una experiencia de pantalla completa.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // **** BLOQUE DE INICIALIZACIÓN DE FIREBASE ****
  // Este bloque maneja la conexión de tu aplicación con tu proyecto Firebase en la nube.
  try {
    // 3. Inicializar la aplicación Firebase usando las opciones generadas automáticamente
    // por 'flutterfire configure' en el archivo 'firebase_options.dart'.
    // 'await' asegura que la inicialización se complete antes de continuar.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint(
        "Firebase inicializado con éxito usando firebase_options.dart."); // Mensaje de depuración.

    // 4. Autenticar un usuario.
    // Firestore requiere que el usuario esté autenticado para aplicar las reglas de seguridad.
    // Obtenemos la instancia de FirebaseAuth.
    final auth = FirebaseAuth.instance;

    // Si no hay un usuario actualmente logueado, intentamos la autenticación anónima.
    // Un usuario anónimo obtiene un UID único, lo que permite que las reglas de seguridad funcionen
    // y puedas empezar a guardar datos privados.
    if (auth.currentUser == null) {
      await auth.signInAnonymously();
      debugPrint("Autenticado anónimamente.");
    } else {
      debugPrint("Usuario ya autenticado: ${auth.currentUser!.uid}");
    }
  } catch (e) {
    // Captura cualquier error durante la inicialización o autenticación de Firebase.
    debugPrint("Error al inicializar Firebase o autenticar: $e");
    // En una aplicación real, podrías considerar mostrar una pantalla de error al usuario
    // o un mensaje que indique que la aplicación no pudo cargar correctamente.
  }

  // 5. Finalmente, ejecuta la aplicación PataniaApp.
  // Esto solo sucede después de que el proceso de inicialización de Firebase haya terminado (éxito o error).
  runApp(PataniaApp());
}

// Clase principal de la aplicación, define la estructura de navegación.
class PataniaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget raíz para una aplicación de Material Design.
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Oculta la pequeña bandera "DEBUG" en la esquina.
      initialRoute:
          '/login', // Define la ruta que se mostrará primero al iniciar la app.
      routes: {
        // Define un mapa de rutas nombradas. Permite navegar entre pantallas por su nombre.
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/registro': (context) => RegisterFormScreen(),
        '/consejos': (context) =>
            Consejos(), // Ruta para la pantalla de consejos.
        '/servicios': (context) =>
            ServiciosScreen(), // Ruta para la pantalla de servicios.
        '/trofeosActividad': (context) =>
            TrofeosActividadScreen(), // Ruta para trofeos de actividad.
        '/trofeosAlimentacion': (context) =>
            TrofeosAlimentacionScreen(), // Ruta para trofeos de alimentación.
      },
    );
  }
}

// -------------------------------------------------------------
// Clase LoginScreen (Se quitaron 'const' de TextField y InputDecoration
// para solucionar errores de constructor no constante)
// -------------------------------------------------------------
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EAEA),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Patania',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.pets, size: 40, color: Colors.black),
                    ),
                    const SizedBox(height: 24),
                    // Se quitó 'const' de TextField y InputDecoration
                    TextField(
                      // AQUI SE QUITO EL 'const'
                      decoration: InputDecoration(
                        // AQUI SE QUITO EL 'const'
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      // AQUI SE QUITO EL 'const'
                      obscureText: true,
                      decoration: InputDecoration(
                        // AQUI SE QUITO EL 'const'
                        hintText: 'Contraseña',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // Muestra un SnackBar (mensaje temporal) ya que la funcionalidad no está implementada.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Funcionalidad de recuperación de contraseña (no implementada)')),
                          );
                        },
                        child: const Text('¿Olvidaste contraseña?',
                            style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Simula el inicio de sesión navegando directamente a la pantalla Home.
                        // En una app real, aquí iría la validación de credenciales y la llamada a FirebaseAuth.
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text('Iniciar sesión'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('¿No tienes cuenta?'),
                        TextButton(
                          child: const Text('Crea tu cuenta'),
                          onPressed: () {
                            // Navega a la pantalla de registro.
                            Navigator.pushNamed(context, '/registro');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('O conéctate con'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.mail, size: 30),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Conectar con Google (no implementado)')),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.facebook, size: 30),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Conectar con Facebook (no implementado)')),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
