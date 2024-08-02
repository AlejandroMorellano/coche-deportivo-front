import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'actualizar_deportivo_screen.dart';

class ConsultarDeportivosScreen extends StatefulWidget {
  @override
  _ConsultarDeportivosScreenState createState() => _ConsultarDeportivosScreenState();
}

class _ConsultarDeportivosScreenState extends State<ConsultarDeportivosScreen> {
  Future<List<dynamic>> _fetchDeportivos() async {
    final response = await http.get(Uri.parse('https://7k0l7wv97d.execute-api.us-west-1.amazonaws.com/Dev/consultar_deportivos'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _deleteDeportivo(String id) async {
    final response = await http.delete(
      Uri.parse('https://7k0l7wv97d.execute-api.us-west-1.amazonaws.com/Dev/eliminar_deportivo/$id'),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Coche Deportivo eliminado.')),
      );
      setState(() {}); // Refresh the list
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete deportivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Deportivos'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchDeportivos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay Coches Deportivos registrados'));
          } else {
            final deportivos = snapshot.data!;
            return ListView.builder(
              itemCount: deportivos.length,
              itemBuilder: (context, index) {
                final deportivo = deportivos[index];
                return ListTile(
                  title: Text('${deportivo['marca']} ${deportivo['modelo']}'),
                  subtitle: Text('Velocidad: ${deportivo['velocidadMaxima']} km/h, Peso: ${deportivo['peso']} kg'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Eliminar Deportivo'),
                          content: Text('¿Estás seguro de que deseas eliminar este coche deportivo?'),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Eliminar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _deleteDeportivo(deportivo['id'].toString());
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActualizarDeportivoScreen(id: deportivo['id'].toString()),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
