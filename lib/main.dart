import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/app.dart';
import 'package:study_scroll/data/repositories/fb_auth_repo.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepo = FirebaseAuthRepository();

  runApp(BlocProvider(create: (context) => AuthCubit(authRepository: authRepo)..checkAuthStatus(), child: MyApp()));
}
