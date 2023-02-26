import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Imagen de Fondo
          const _Background(),
          _BodyHome()
        ],
      ),
   );
  }
}

class _BodyHome extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,      
        children: [

          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: const [
                TextSpan(text: 'Bienvenido, ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35)),
                TextSpan(text: 'Pinguinito', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, fontSize: 35)),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'registro'),
                child: const _ContainerService(img: 'assets/tarea.png',titulo: 'Registro de tareas')
              ),

              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'consulta'),
                child: const _ContainerService(img: 'assets/lista-tareas.png',titulo: 'Consulta de tareas')
              ),
            ],
          )    
        ]
      ),
    );
  }
}

class _ContainerService extends StatelessWidget {
  final String titulo;
  final String img;
  
  const _ContainerService({
    required this.titulo, required this.img,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      margin: const EdgeInsets.only(top: 20,right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Img
          Image.asset(img, width: 75, height: 75,),
          //Titulo
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}