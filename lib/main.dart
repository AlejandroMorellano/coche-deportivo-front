import 'package:coche_deportivo_front/presentation/screens/actualizar_deportivo_screen.dart';
import 'package:coche_deportivo_front/presentation/screens/consultar_deportivos_screen.dart';
import 'package:coche_deportivo_front/presentation/screens/crear_deportivo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coche Deportivo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/crear': (context) => CrearDeportivoScreen(),
        '/consultar': (context) => ConsultarDeportivosScreen(),
        '/actualizar': (context) => ActualizarDeportivoScreen(id: '',),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coche Deportivo App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/consultar');
              },
              child: Text('Consultar Deportivos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/crear');
              },
              child: Text('Crear Deportivo'),
            ),
          ],
        ),
      ),
    );
  }
}
