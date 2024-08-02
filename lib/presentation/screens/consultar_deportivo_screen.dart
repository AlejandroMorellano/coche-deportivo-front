import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/deportivo_cubit.dart';
import '../../data/models/deportivo_model.dart';

class ConsultarDeportivoScreen extends StatelessWidget {
  final String id;

  ConsultarDeportivoScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consultar Deportivo')),
      body: BlocBuilder<DeportivoCubit, DeportivoState>(
        builder: (context, state) {
          if (state is DeportivoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DeportivoLoadedSingle) {
            final deportivo = state.deportivo;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Marca: ${deportivo.marca}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Text('Modelo: ${deportivo.modelo}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Text('Velocidad Máxima: ${deportivo.velocidadMaxima}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Text('Peso: ${deportivo.peso}', style: TextStyle(fontSize: 20)),
                ],
              ),
            );
          } else if (state is DeportivoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No se encontró el deportivo'));
          }
        },
      ),
    );
  }
}
