import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'class.dart';
import 'new spalsh.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>CatProvider(),child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retro_station',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),debugShowCheckedModeBanner: false,
      home:spalsh1(),
    );
  }
}
