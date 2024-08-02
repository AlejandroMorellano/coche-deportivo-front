import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/deportivo_model.dart';

class DeportivoRepository {
  final String apiUrl = 'https://7k0l7wv97d.execute-api.us-west-1.amazonaws.com/Dev';

  Future<List<Deportivo>> obtenerDeportivos() async {
    final response = await http.get(Uri.parse('$apiUrl/consultar_deportivos'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((item) => Deportivo.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load deportivos');
    }
  }

  Future<Deportivo> obtenerDeportivo(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/consultar_deportivo/$id'));

    if (response.statusCode == 200) {
      return Deportivo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load deportivo');
    }
  }

  Future<void> crearDeportivo(Deportivo deportivo) async {
    final response = await http.post(
      Uri.parse('$apiUrl/crear_deportivo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(deportivo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create deportivo');
    }
  }

  Future<void> actualizarDeportivo(Deportivo deportivo) async {
    final response = await http.put(
      Uri.parse('$apiUrl/actualizar_deportivo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(deportivo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update deportivo');
    }
  }

  Future<void> eliminarDeportivo(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/eliminar_deportivo/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete deportivo');
    }
  }
}
