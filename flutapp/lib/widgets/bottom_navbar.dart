import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/ai/ai_screen.dart';
import '../features/resources/resources_screen.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int index = 0;

  final screens = [
    const HomeScreen(),
    const AiScreen(),
    const ResourcesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: screens[index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          setState(() => index = i);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.smart_toy), label: "AI"),
          NavigationDestination(icon: Icon(Icons.folder), label: "Resources"),
        ],
      ),
    );
  }
}