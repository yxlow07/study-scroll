import 'package:flutter/material.dart';
import '/core/theme/AppTheme.dart';
import '/core/constants/images.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello, World!', style: TextStyle(fontSize: 24, color: Colors.black)),
              Image(image: AssetImage(images.logo), width: 100, height: 100),
            ],
          ),
        ),
      ),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
