import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/firebase_options.dart';
import 'package:tasks_app/screens/consulta_screen.dart';
import 'package:tasks_app/screens/home_screen.dart';
import 'package:tasks_app/screens/registro_screen.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/service/task_form_service.dart';
import 'package:tasks_app/service/tasks_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => TasksService()),
        ChangeNotifierProvider(create: (_) => TaskFormService()),        
      ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks App',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'registro': (_) => const RegistroScreen(),
        'consulta': (_) => const ConsultaScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
