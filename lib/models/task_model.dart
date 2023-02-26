import 'dart:convert';

class Task {
    Task({
        this.idTask,
        required this.nombre,
        required this.descripcion,
    });

    String? idTask;
    String nombre;
    String descripcion;

    factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Task.fromMap(Map<String, dynamic> json) => Task(
        idTask: '',
        nombre: json["nombre"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "descripcion": descripcion,
    };
}
