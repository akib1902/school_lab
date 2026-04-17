import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/theme_provider.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.menu_book, size: 28),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "StudyHub DIU",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "LEARNING PLATFORM",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              )
            ],
          ),

          Row(
            children: [
              IconButton(
                icon: Icon(
                  themeProvider.isDark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}