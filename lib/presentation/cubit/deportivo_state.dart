part of 'deportivo_cubit.dart';

@immutable
abstract class DeportivoState {}

class DeportivoInitial extends DeportivoState {}

class DeportivoLoading extends DeportivoState {}

class DeportivoLoaded extends DeportivoState {
  final List<Deportivo> deportivos;

  DeportivoLoaded(this.deportivos);
}

class DeportivoLoadedSingle extends DeportivoState {
  final Deportivo deportivo;

  DeportivoLoadedSingle(this.deportivo);
}

class DeportivoCreated extends DeportivoState {}

class DeportivoUpdated extends DeportivoState {}

class DeportivoDeleted extends DeportivoState {}

class DeportivoError extends DeportivoState {
  final String message;

  DeportivoError(this.message);
}
