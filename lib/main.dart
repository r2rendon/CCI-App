import 'package:cci_app/home/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils/Anuncio.dart';

// Providers
final notificationsPluginProvider = Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

// Theme provider
final themeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    primarySwatch: Colors.blue,
    // Add more theme configurations here
  );
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notifications
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  final initSettings = InitializationSettings(android: androidSettings);
  
  final notifications = FlutterLocalNotificationsPlugin();
  await notifications.initialize(initSettings);

  // Initialize Hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(AnuncioAdapter());
  }
  // await Hive.openBox('noticiasBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CCI San Pedro Sula',
      theme: theme,
      home: const SplashScreen(),
    );
  }
}
