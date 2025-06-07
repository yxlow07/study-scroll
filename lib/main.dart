import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_scroll/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}