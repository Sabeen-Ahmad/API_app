import 'package:api_app/home_screen.dart';
import 'package:api_app/screen_three.dart';
import 'package:flutter/material.dart';
import 'package:api_app/upload_image.dart';
import 'package:api_app/sign_up.dart';
import 'package:api_app/screen_two.dart';
import 'package:api_app/screen_four.dart';
import 'package:api_app/screen_five.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadImage(),
    );
  }
}


