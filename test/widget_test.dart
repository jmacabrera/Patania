import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patania_app/main.dart';

void main() {
  testWidgets('Renderiza correctamente la pantalla de login', (WidgetTester tester) async {
    // Renderiza la app
    await tester.pumpWidget(PataniaApp());

    // Verifica que el título esté presente
    expect(find.text('Patania'), findsOneWidget);

    // Verifica que hay dos campos de texto
    expect(find.byType(TextField), findsNWidgets(2));

    // Verifica que el botón "Iniciar sesión" aparece
    expect(find.text('Iniciar sesión'), findsOneWidget);

    // Verifica que el botón de recuperación de contraseña está presente
    expect(find.text('¿Olvidaste contraseña?'), findsOneWidget);

    // Verifica que el texto de crear cuenta está
    expect(find.text('Crea tu cuenta'), findsOneWidget);

    // Verifica que el texto de redes sociales está
    expect(find.text('O conéctate con'), findsOneWidget);
  });
}