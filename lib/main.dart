import 'package:flutter/material.dart';
import 'views/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // configuração

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(NotasApp());
}
