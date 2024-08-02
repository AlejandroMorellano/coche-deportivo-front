import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ActualizarDeportivoScreen extends StatefulWidget {
  final String id;

  ActualizarDeportivoScreen({required this.id});

  @override
  _ActualizarDeportivoScreenState createState() => _ActualizarDeportivoScreenState();
}

class _ActualizarDeportivoScreenState extends State<ActualizarDeportivoScreen> {
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _velocidadMaximaController = TextEditingController();
  final _pesoController = TextEditingController();

  Future<void> _fetchDeportivo() async {
    final response = await http.get(Uri.parse('https://7k0l7wv97d.execute-api.us-west-1.amazonaws.com/Dev/consultar_deportivo/${widget.id}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final deportivo = data['data'];

      _marcaController.text = deportivo['marca'];
      _modeloController.text = deportivo['modelo'];
      _velocidadMaximaController.text = deportivo['velocidadMaxima'].toString();
      _pesoController.text = deportivo['peso'].toString();
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch deportivo')),
      );
    }
  }

  Future<void> _updateDeportivo() async {
    final response = await http.put(
      Uri.parse('https://7k0l7wv97d.execute-api.us-west-1.amazonaws.com/Dev/actualizar_deportivo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': widget.id,
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
        SnackBar(content: Text('Failed to update deportivo')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDeportivo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Deportivo'),
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
              onPressed: _updateDeportivo,
              child: Text('Actualizar Deportivo'),
            ),
          ],
        ),
      ),
    );
  }
}
