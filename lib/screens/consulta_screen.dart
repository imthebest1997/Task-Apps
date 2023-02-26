import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/service/tasks_service.dart';

class ConsultaScreen extends StatelessWidget {
  const ConsultaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasksService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de tareas'),
        centerTitle: true,
        backgroundColor: const Color(0xff023047),
        actions: [
          IconButton(
              onPressed: () async {
                await taskProvider.deleteAllTasks();
              },
              icon: const FaIcon(FontAwesomeIcons.trashCan))
        ],
      ),
      body: ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, int i) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                taskProvider.deleteTask(taskProvider.tasks[i]);
              },
              child: CardTask(
                task: taskProvider.tasks[i],
              ),
            );
          }),
    );
  }
}

class CardTask extends StatelessWidget {
  final Task task;

  const CardTask({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffedf6f9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Contenedor con la información de la tarea
            SizedBox(
              width: size.width * 0.70,
              child: _InfoCardTask(
                  id: task.idTask!,
                  task: task.nombre,
                  descripcion: task.descripcion),
            ),

            IconButton(
                onPressed: () {
                  //Enviar el id a la pantalla de registro para la actualizacion
                  Navigator.pushNamed(context, 'registro', arguments: task);
                },
                icon: const FaIcon(FontAwesomeIcons.pencil))
          ],
        ),
      ),
    );
  }
}

class _InfoCardTask extends StatelessWidget {
  const _InfoCardTask({
    required this.id,
    required this.task,
    required this.descripcion,
  });

  final String id;
  final String task;
  final String descripcion;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //ID
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              const TextSpan(
                  text: 'ID de la tarea:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              TextSpan(
                  text: ' $id',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 20)),
            ],
          ),
        ),

        //Task
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              const TextSpan(
                  text: 'Tarea:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              TextSpan(
                  text: ' $task',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 20)),
            ],
          ),
        ),

        //Descripcion
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              const TextSpan(
                  text: 'Descripción:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              TextSpan(
                  text: ' $descripcion',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 20)),
            ],
          ),
        ),
      ],
    );
  }
}
