import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_scroll/app.dart';
import 'package:study_scroll/data/datasource/backblaze_api.dart';
import 'package:study_scroll/data/repositories/backblaze_storage_repo.dart';
import 'package:study_scroll/data/repositories/fb_auth_repo.dart';
import 'package:study_scroll/data/repositories/fb_profile_repo.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_pic_cubit.dart';

import 'firebase_options.dart';

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

  print(backblazeApi.toString());

  // final storageRepo = BackblazeStorageRepo(backBlazeApi: backblazeApi);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(authRepository: authRepo)..checkAuthStatus()),
        BlocProvider(create: (context) => ProfileCubit(profileRepo: profileRepo)),
        BlocProvider(create: (context) => ProfilePicCubit(backblazeApi: backblazeApi, profileRepo: profileRepo)),
      ],
      child: MyApp(),
    ),
  );
}
