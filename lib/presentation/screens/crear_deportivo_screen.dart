import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CrearDeportivoScreen extends StatefulWidget {
  @override
  _CrearDeportivoScreenState createState() => _CrearDeportivoScreenState();
}

class _CrearDeportivoScreenState extends State<CrearDeportivoScreen> {
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _velocidadMaximaController = TextEditingController();
  final _pesoController = TextEditingController();

  Future<void> _createDeportivo() async {
    final response = await http.post(
      Uri.parse('https://7k0l7wv97d.execute-api.us-west-1.amazonaws.com/Dev/crear_deportivo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'marca': _marcaController.text,
        'modelo': _modeloController.text,
        'velocidadMaxima': double.parse(_velocidadMaximaController.text),
        'peso': double.parse(_pesoController.text),
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create deportivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Deportivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: _velocidadMaximaController,
              decoration: InputDecoration(labelText: 'Velocidad Máxima'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(labelText: 'Peso'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createDeportivo,
              child: Text('Crear Deportivo'),
            ),
          ],
        ),
      ),
    );
  }
}
