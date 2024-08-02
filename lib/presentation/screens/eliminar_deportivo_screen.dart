import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/deportivo_cubit.dart';

class EliminarDeportivoScreen extends StatelessWidget {
  final String id;

  EliminarDeportivoScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eliminar Deportivo')),
      body: BlocConsumer<DeportivoCubit, DeportivoState>(
        listener: (context, state) {
          if (state is DeportivoDeleted) {
            Navigator.pop(context);
          } else if (state is DeportivoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('¿Estás seguro de que deseas eliminar este deportivo?'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<DeportivoCubit>().deleteDeportivo(id);
                  },
                  child: Text('Eliminar Deportivo'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
