import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/core/routes/app_routes.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/profile/profile.dart';
import 'package:study_scroll/presentation/widgets/logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Scroll'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authCubit.signOut();
              print(authCubit.state);
            },
          ),
        ],
      ),
      body: const Center(child: Text("Welcome!")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: const Icon(Icons.leaderboard), label: ''),
          BottomNavigationBarItem(icon: const Icon(Icons.quiz), label: ''),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
