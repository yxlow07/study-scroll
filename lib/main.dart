import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_scroll/app.dart';
import 'package:study_scroll/core/config/firebase_options.dart';
import 'package:study_scroll/core/theme/AppTheme.dart';
import 'package:study_scroll/data/datasource/backblaze_api.dart';
import 'package:study_scroll/data/repositories/fb_auth_repo.dart';
import 'package:study_scroll/data/repositories/fb_profile_repo.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/home/bloc/ThemeCubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_pic_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // ENV
  await dotenv.load(fileName: '.env');

  final authRepo = FirebaseAuthRepository();
  final profileRepo = FirebaseProfileRepo();
  final backblazeApi = BackBlazeApi(
    keyId: dotenv.env['BACKBLAZE_KEY_ID']!,
    applicationKey: dotenv.env['BACKBLAZE_APPLICATION_KEY']!,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit(AppTheme.darkTheme)),
        BlocProvider(create: (context) => AuthCubit(authRepository: authRepo)..checkAuthStatus()),
        BlocProvider(create: (context) => ProfileCubit(profileRepo: profileRepo, backblazeApi: backblazeApi)),
        BlocProvider(create: (context) => ProfilePicCubit(backblazeApi: backblazeApi, profileRepo: profileRepo)),
      ],
      child: MyApp(),
    ),
  );
}
