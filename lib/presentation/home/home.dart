import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_scroll/core/routes/app_routes.dart';
import 'package:study_scroll/core/theme/AppColors.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavbarTap(int index, BuildContext context) {
    _selectedIndex = index;
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.push(AppRoutes.leaderboard);
        break;
      case 2:
        context.push(AppRoutes.quiz);
        break;
      case 3:
        context.push(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: Scaffold(
        body: SafeArea(child: widget.child),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => _onNavbarTap(index, context),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: const Icon(Icons.leaderboard), label: 'Leaderboard'),
            BottomNavigationBarItem(icon: const Icon(Icons.quiz), label: 'Quiz'),
            BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
