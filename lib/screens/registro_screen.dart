import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/service/task_form_service.dart';
import 'package:tasks_app/service/tasks_service.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context)?.settings.arguments != null
        ? ModalRoute.of(context)?.settings.arguments as Task
        : Task(nombre: '', descripcion: '', idTask: '');
    final taskFormService = Provider.of<TaskFormService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de tareas'),
        centerTitle: true,
        backgroundColor: const Color(0xff023047),
      ),
      floatingActionButton: _BtnSave(buildContext: context, task: task),
      body: Container(
          width: double.infinity,
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: _BoxDecorationForm(),
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: task.nombre,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff023047)),
                      ),
                      //Cambiar el color del borde
                      labelText: 'Tarea',
                      hintText: 'Ingrese la tarea',
                      prefixIcon: Icon(
                        Icons.assignment,
                        color: Color(0xff023047),
                      ),
                    ),
                    onChanged: (value) => taskFormService.title = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo no puede estar vacío';
                      } else if (value.length < 5) {
                        return 'El nombre de la tarea debe tener al menos 5 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: task.descripcion,
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // Permite un número ilimitado de líneas
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripción',
                      hintText: 'Ingrese la descripción',
                      prefixIcon: Icon(
                        Icons.description,
                        color: Color(0xff023047),
                      ),
                    ),
                    onChanged: (value) => taskFormService.description = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo no puede estar vacío';
                      } else if (value.length < 10) {
                        return 'La descripción de la tarea debe tener al menos 10 caracteres';
                      }
                      return null;
                    },
                  ),
                ],
              ))),
    );
  }

  // ignore: non_constant_identifier_names
  BoxDecoration _BoxDecorationForm() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ]);
  }
}

class _BtnSave extends StatelessWidget {
  final BuildContext buildContext;
  final Task task;

  const _BtnSave({Key? key, required this.buildContext, required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskFormService = Provider.of<TaskFormService>(context);
    final taskService = Provider.of<TasksService>(context);
    return FloatingActionButton(
      onPressed: !taskFormService.isSaving
          ? () async {
            final newTask = Task(nombre: taskFormService.title, descripcion: taskFormService.description);
            if (task.idTask != '') {
              //Actualizar
              newTask.idTask = task.idTask;
              await taskService.updateTask(newTask);
            } else {
              //Crear
              await taskService.saveTask(newTask);
            }
            redireccionar();
          }
          : null,
      backgroundColor: !taskFormService.isSaving ? const Color(0xff219ebc) : Colors.grey,
      child: const Icon(
        Icons.save,
        color: Colors.white,
      ),
    );
  }

  void redireccionar() {
    Navigator.pushReplacementNamed(buildContext, 'home');
  }
}
