class Deportivo {
  final String? id;
  final String marca;
  final String modelo;
  final double velocidadMaxima;
  final double peso;

  Deportivo({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.velocidadMaxima,
    required this.peso,
  });

  factory Deportivo.fromJson(Map<String, dynamic> json) {
    return Deportivo(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      velocidadMaxima: json['velocidadMaxima'],
      peso: json['peso'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'velocidadMaxima': velocidadMaxima,
      'peso': peso,
    };
  }
}
