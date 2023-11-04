import 'package:flutter/material.dart';
import 'package:flutter_todo/model/person_model.dart';
import 'package:flutter_todo/views/screen_home.dart';

import 'package:hive_flutter/adapters.dart';

void main() async {
  Hive.registerAdapter(PersonAdapter());
  await Hive.initFlutter();
  var box = await Hive.openBox<Person>('personBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 81, 104, 114)),
        useMaterial3: true,
      ),
      home: ScreenHome(),
    );
  }
}
