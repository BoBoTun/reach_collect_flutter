import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reach_collect/screens/splash_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
void main() async {
WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS) { 
    // Initialize FFI 
    sqfliteFfiInit(); 
    //  WindowManager.instance.setMinimumSize(const Size(1200, 600));
    //  WindowManager.instance.setMaximumSize(const Size(2000, 2000));
  }
  
 
 databaseFactory = databaseFactoryFfi; 
 
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
