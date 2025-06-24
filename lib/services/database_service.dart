import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // Importar debugPrint

// ----------------------------------------------------
// Modelos de datos (Clases para representar tus objetos Firestore)
// ----------------------------------------------------

/// Representa un usuario de la aplicación.
class AppUser {
  final String id; // UID del usuario de Firebase Authentication
  final String email;
  final Timestamp registrationDate; // Usamos Timestamp para fechas de Firestore

  AppUser({
    required this.id,
    required this.email,
    required this.registrationDate,
  });

  // Constructor de fábrica para crear un AppUser desde un documento de Firestore
  // Se ha ajustado para aceptar DocumentSnapshot<Object?> y hacer el cast interno.
  factory AppUser.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?; // Cast seguro
    if (data == null) {
      throw StateError('missing data for user document ${doc.id}');
    }
    return AppUser(
      id: doc.id,
      email: data['email'] ?? '',
      registrationDate: data['registrationDate'] ?? Timestamp.now(),
    );
  }

  // Método para convertir AppUser a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'registrationDate': registrationDate,
    };
  }
}

/// Representa una mascota propiedad de un usuario.
class Pet {
  final String id; // ID del documento de la mascota en Firestore
  final String name;
  final String breed;
  final double weight;
  final int age;
  final String ownerId; // UID del propietario
  final String? profileImageUrl; // URL opcional de la imagen de perfil

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.weight,
    required this.age,
    required this.ownerId,
    this.profileImageUrl,
  });

  // Constructor de fábrica para crear una Pet desde un documento de Firestore
  factory Pet.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('missing data for pet document ${doc.id}');
    }
    return Pet(
      id: doc.id,
      name: data['name'] ?? 'Desconocido',
      breed: data['breed'] ?? 'Mestizo',
      weight: (data['weight'] as num?)?.toDouble() ?? 0.0,
      age: (data['age'] as num?)?.toInt() ?? 0,
      ownerId: data['ownerId'] ?? '',
      profileImageUrl: data['profileImageUrl'],
    );
  }

  // Método para convertir Pet a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'breed': breed,
      'weight': weight,
      'age': age,
      'ownerId': ownerId,
      'profileImageUrl': profileImageUrl,
    };
  }
}

/// Representa una rutina para una mascota.
class Routine {
  final String id; // ID del documento de la rutina en Firestore
  final String type; // Ej. "Alimentación", "Caminata", "Medicación"
  final String description;
  final String time; // Ej. "08:00 AM"
  final String frequency; // Ej. "Diario", "Semanal"
  final bool isCompleted;

  Routine({
    required this.id,
    required this.type,
    required this.description,
    required this.time,
    required this.frequency,
    required this.isCompleted,
  });

  // Constructor de fábrica para crear una Routine desde un documento de Firestore
  factory Routine.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('missing data for routine document ${doc.id}');
    }
    return Routine(
      id: doc.id,
      type: data['type'] ?? '',
      description: data['description'] ?? '',
      time: data['time'] ?? '',
      frequency: data['frequency'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  // Método para convertir Routine a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'type': type,
      'description': description,
      'time': time,
      'frequency': frequency,
      'isCompleted': isCompleted,
    };
  }
}

/// Representa un recordatorio para una mascota.
class Reminder {
  final String id; // ID del documento del recordatorio en Firestore
  final String title;
  final Timestamp date; // Usamos Timestamp para la fecha del recordatorio
  final String? notes; // Notas opcionales
  final bool isCompleted;

  Reminder({
    required this.id,
    required this.title,
    required this.date,
    this.notes,
    required this.isCompleted,
  });

  // Constructor de fábrica para crear un Reminder desde un documento de Firestore
  factory Reminder.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('missing data for reminder document ${doc.id}');
    }
    return Reminder(
      id: doc.id,
      title: data['title'] ?? '',
      date: data['date'] ?? Timestamp.now(),
      notes: data['notes'],
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  // Método para convertir Reminder a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'date': date,
      'notes': notes,
      'isCompleted': isCompleted,
    };
  }
}

/// Representa un consejo general de cuidado de mascotas.
class Consejo {
  final String id; // ID del documento del consejo en Firestore
  final String title;
  final String text;
  final String iconCodePoint; // Representa el código del icono de Material

  Consejo({
    required this.id,
    required this.title,
    required this.text,
    required this.iconCodePoint,
  });

  // Constructor de fábrica para crear un Consejo desde un documento de Firestore
  factory Consejo.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('missing data for consejo document ${doc.id}');
    }
    return Consejo(
      id: doc.id,
      title: data['title'] ?? '',
      text: data['text'] ?? '',
      iconCodePoint: data['iconCodePoint'] ??
          '0xe80d', // Un icono por defecto si no se especifica
    );
  }

  // Método para convertir Consejo a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'text': text,
      'iconCodePoint': iconCodePoint,
    };
  }
}

/// Representa un servicio disponible en la aplicación (ej. veterinaria, peluquería).
class AppService {
  final String id; // ID del documento del servicio en Firestore
  final String name;
  final String description;
  final String iconCodePoint; // Código de icono para el servicio

  AppService({
    required this.id,
    required this.name,
    required this.description,
    required this.iconCodePoint,
  });

  // Constructor de fábrica para crear un AppService desde un documento de Firestore
  factory AppService.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('missing data for AppService document ${doc.id}');
    }
    return AppService(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      iconCodePoint: data['iconCodePoint'] ??
          '0xe531', // Icono por defecto (Icons.miscellaneous_services)
    );
  }

  // Método para convertir AppService a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'iconCodePoint': iconCodePoint,
    };
  }
}

/// Representa una definición de trofeo.
/// Estos son los trofeos que el usuario puede "ganar" o registrar.
class TrophyDefinition {
  final String id;
  final String title;
  final String description;
  final String
      category; // Ej. "Actividad Física", "Alimentación", "Higiene", "Relación y Cariño"
  final String iconCodePoint; // Icono para el trofeo

  TrophyDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.iconCodePoint,
  });

  factory TrophyDefinition.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('missing data for TrophyDefinition document ${doc.id}');
    }
    return TrophyDefinition(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? 'General',
      iconCodePoint:
          data['iconCodePoint'] ?? '0xe88a', // Icono de trofeo por defecto
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'iconCodePoint': iconCodePoint,
    };
  }
}

// ----------------------------------------------------
// DatabaseService (Clase para interactuar con Firestore)
// ----------------------------------------------------

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Obtiene el ID del usuario actualmente autenticado.
  String? get currentUserId => _auth.currentUser?.uid;

  // Define las rutas base para los datos en Firestore.
  static const String _appId =
      'pataniaapp'; // Reemplaza con tu ID de aplicación Firebase

  // Ruta para datos públicos (ej. consejos, definiciones de servicios, definiciones de trofeos)
  // La ruta completa será /artifacts/pataniaapp/public/data/
  // Las subcolecciones como 'consejos' o 'services' irán dentro de 'data'.
  CollectionReference _publicDataCollection(String collectionName) {
    // La estructura esperada en Firestore es artifacts/appId/public/data/{collectionName}
    // Donde 'public' es una colección, un documento Auto-ID, luego la colección 'data',
    // luego un documento Auto-ID, y finalmente la subcolección con collectionName.
    // Para simplificar la búsqueda a nivel de código, usaremos rutas directas para los datos públicos.
    // Esto asume que tienes un documento singular 'data' dentro de 'public'.
    return _firestore
        .collection('artifacts')
        .doc(_appId)
        .collection('public')
        .doc('data')
        .collection(collectionName);
  }

  // Ruta para datos privados de un usuario (ej. mascotas, rutinas, recordatorios)
  // La ruta completa será /artifacts/pataniaapp/users/{userId}/
  CollectionReference _userDataCollection(
      String userId, String collectionName) {
    return _firestore
        .collection('artifacts')
        .doc(_appId)
        .collection('users')
        .doc(userId)
        .collection(collectionName);
  }

  // NUEVO MÉTODO: Crear perfil de usuario en Firestore después de registrarse/loguearse
  Future<void> createUserProfile(User firebaseUser, String email) async {
    final userRef = _firestore
        .collection('artifacts')
        .doc(_appId)
        .collection('users')
        .doc(firebaseUser.uid);
    final userDoc = await userRef.get();

    if (!userDoc.exists) {
      debugPrint('Creando perfil de usuario para UID: ${firebaseUser.uid}');
      await userRef.set(AppUser(
        id: firebaseUser.uid,
        email: email,
        registrationDate: Timestamp.now(),
      ).toFirestore());
    } else {
      debugPrint('Perfil de usuario para UID: ${firebaseUser.uid} ya existe.');
    }
  }

  // ----------------------------------------------------
  // Operaciones de Usuario y Mascota
  // ----------------------------------------------------

  // Obtener un Stream de todas las mascotas del usuario actual.
  Stream<List<Pet>> streamPets() {
    if (currentUserId == null) {
      debugPrint('No hay usuario autenticado para obtener mascotas.');
      return Stream.value([]); // Retorna un stream vacío si no hay usuario
    }
    return _userDataCollection(currentUserId!, 'pets').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Pet.fromFirestore(
                doc)) // Aquí doc es QueryDocumentSnapshot<Object?>
            .toList());
  }

  // Añadir una nueva mascota para el usuario actual.
  Future<void> addPet(Pet pet) async {
    if (currentUserId == null) {
      throw Exception('No hay usuario autenticado para añadir una mascota.');
    }
    await _userDataCollection(currentUserId!, 'pets').add(pet.toFirestore());
  }

  // Actualizar una mascota existente.
  Future<void> updatePet(Pet pet) async {
    if (currentUserId == null) {
      throw Exception(
          'No hay usuario autenticado para actualizar una mascota.');
    }
    await _userDataCollection(currentUserId!, 'pets')
        .doc(pet.id)
        .update(pet.toFirestore());
  }

  // Eliminar una mascota.
  Future<void> deletePet(String petId) async {
    if (currentUserId == null) {
      throw Exception('No hay usuario autenticado para eliminar una mascota.');
    }
    await _userDataCollection(currentUserId!, 'pets').doc(petId).delete();
  }

  // ----------------------------------------------------
  // Operaciones de Rutinas
  // ----------------------------------------------------

  // Obtener un Stream de rutinas para una mascota específica.
  Stream<List<Routine>> streamRoutines(String petId) {
    if (currentUserId == null) {
      debugPrint('No hay usuario autenticado para obtener rutinas.');
      return Stream.value([]);
    }
    return _userDataCollection(currentUserId!, 'pets')
        .doc(petId)
        .collection('routines')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Routine.fromFirestore(doc)).toList());
  }

  // Añadir una rutina para una mascota.
  Future<void> addRoutine(String petId, Routine routine) async {
    if (currentUserId == null) {
      throw Exception('No hay usuario autenticado para añadir una rutina.');
    }
    await _userDataCollection(currentUserId!, 'pets')
        .doc(petId)
        .collection('routines')
        .add(routine.toFirestore());
  }

  // Actualizar una rutina.
  Future<void> updateRoutine(String petId, Routine routine) async {
    if (currentUserId == null) {
      throw Exception('No hay usuario autenticado para actualizar una rutina.');
    }
    await _userDataCollection(currentUserId!, 'pets')
        .doc(petId)
        .collection('routines')
        .doc(routine.id)
        .update(routine.toFirestore());
  }

  // Eliminar una rutina.
  Future<void> deleteRoutine(String petId, String routineId) async {
    if (currentUserId == null) {
      throw Exception('No hay usuario autenticado para eliminar una rutina.');
    }
    await _userDataCollection(currentUserId!, 'pets')
        .doc(petId)
        .collection('routines')
        .doc(routineId)
        .delete();
  }

  // ----------------------------------------------------
  // Operaciones de Recordatorios
  // ----------------------------------------------------

  // Obtener un Stream de recordatorios para una mascota específica.
  Stream<List<Reminder>> streamReminders(String petId) {
    if (currentUserId == null) {
      debugPrint('No hay usuario autenticado para obtener recordatorios.');
      return Stream.value([]);
    }
    return _userDataCollection(currentUserId!, 'pets')
        .doc(petId)
        .collection(
            'reminders') // Asegúrate de que esta es la subcolección correcta
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Reminder.fromFirestore(doc)).toList());
  }

  // Añadir un recordatorio para una mascota.
  Future<void> addReminder(String petId, Reminder reminder) async {
    if (currentUserId == null) {
      throw Exception(
          'No hay usuario autenticado para añadir un recordatorio.');
    }
    await _userDataCollection(currentUserId!, 'pets')
        .doc(petId)
        .collection('reminders')
        .add(reminder.toFirestore());
  }

  // Actualizar un recordatorio.
  Future<void> updateReminder(String petId, Reminder reminder) async {
    if (currentUserId == null) {
      throw Exception(
          'No hay usuario autenticado para actualizar un recordatorio.');
    }
    await _userDataCollection(currentUserId!, 'pets')
        .doc(petId)
        .collection('reminders')
        .doc(reminder.id)
        .update(reminder.toFirestore());
  }

  // Eliminar un recordatorio.
  Future<void> deleteReminder(String petId, String reminderId) async {
    if (currentUserId == null) {
      throw Exception(
          'No hay usuario autenticado para eliminar un recordatorio.');
    }
    await _userDataCollection(currentUserId!, 'pets')
        .doc(petId)
        .collection('reminders')
        .doc(reminderId)
        .delete();
  }

  // ----------------------------------------------------
  // Operaciones de Consejos (Datos Públicos)
  // ----------------------------------------------------

  // Obtener un Stream de todos los consejos públicos.
  Stream<List<Consejo>> streamConsejos() {
    // La ruta pública es: artifacts/pataniaapp/public/data/{collectionName}
    // Asegúrate de que en Firebase, 'public' y 'data' son colecciones,
    // y dentro de 'data' está la colección 'consejos'.
    return _publicDataCollection('consejos').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Consejo.fromFirestore(doc)).toList());
  }

  // ----------------------------------------------------
  // Operaciones de Servicios (Datos Públicos)
  // ----------------------------------------------------

  // Obtener un Stream de todos los servicios públicos.
  Stream<List<AppService>> streamServices() {
    return _publicDataCollection('services').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => AppService.fromFirestore(doc)).toList());
  }

  // ----------------------------------------------------
  // Operaciones de Definiciones de Trofeos (Datos Públicos)
  // ----------------------------------------------------

  // Obtener un Stream de todas las definiciones de trofeos.
  Stream<List<TrophyDefinition>> streamTrophyDefinitions() {
    return _publicDataCollection('trophyDefinitions').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => TrophyDefinition.fromFirestore(doc))
            .toList());
  }
}
