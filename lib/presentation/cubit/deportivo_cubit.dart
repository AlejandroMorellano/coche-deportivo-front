import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repository/deportivo_repository.dart';
import '../../data/models/deportivo_model.dart';

part 'deportivo_state.dart';

class DeportivoCubit extends Cubit<DeportivoState> {
  final DeportivoRepository repository;

  DeportivoCubit(this.repository) : super(DeportivoInitial());

  Future<void> fetchDeportivos() async {
    emit(DeportivoLoading());
    try {
      final deportivos = await repository.obtenerDeportivos();
      emit(DeportivoLoaded(deportivos));
    } catch (e) {
      emit(DeportivoError(e.toString()));
    }
  }

  Future<void> fetchDeportivo(String id) async {
    emit(DeportivoLoading());
    try {
      final deportivo = await repository.obtenerDeportivo(id);
      emit(DeportivoLoadedSingle(deportivo));
    } catch (e) {
      emit(DeportivoError(e.toString()));
    }
  }

  Future<void> createDeportivo(Deportivo deportivo) async {
    emit(DeportivoLoading());
    try {
      await repository.crearDeportivo(deportivo);
      emit(DeportivoCreated());
      fetchDeportivos();
    } catch (e) {
      emit(DeportivoError(e.toString()));
    }
  }

  Future<void> updateDeportivo(Deportivo deportivo) async {
    emit(DeportivoLoading());
    try {
      await repository.actualizarDeportivo(deportivo);
      emit(DeportivoUpdated());
      fetchDeportivos();
    } catch (e) {
      emit(DeportivoError(e.toString()));
    }
  }

  Future<void> deleteDeportivo(String id) async {
    emit(DeportivoLoading());
    try {
      await repository.eliminarDeportivo(id);
      emit(DeportivoDeleted());
      fetchDeportivos();
    } catch (e) {
      emit(DeportivoError(e.toString()));
    }
  }
}
