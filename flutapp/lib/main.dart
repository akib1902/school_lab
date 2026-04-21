import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/theme/theme_provider.dart';
import 'core/state/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔗 Supabase init
  await Supabase.initialize(
    url: 'https://rfsblhznlphinacraitf.supabase.co',
    anonKey: 'sb_publishable_Cdqwa0wagyi8tZPu94bh9w_yKybxucu',
  );

  // 💾 Hive init
  await Hive.initFlutter();
  await Hive.openBox('appBox');
  await Hive.openBox('cacheBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final appState = AppState();
            appState.loadFromStorage();
            return appState;
          },
        ),
      ],
      child: const MyApp(), // 👈 use your real app entry, not FlutApp
    ),
  );
}