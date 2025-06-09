import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/app.dart';
import 'package:study_scroll/data/repositories/fb_auth_repo.dart';
import 'package:study_scroll/data/repositories/fb_profile_repo.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_cubit.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepo = FirebaseAuthRepository();
  final profileRepo = FirebaseProfileRepo();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(authRepository: authRepo)..checkAuthStatus()),
        BlocProvider(create: (context) => ProfileCubit(profileRepo: profileRepo)),
      ],
      child: MyApp(),
    ),
  );
}
