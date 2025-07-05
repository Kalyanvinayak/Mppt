import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/dashboard/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MPPTApp());
}

class MPPTApp extends StatelessWidget {
  const MPPTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MPPT Solar App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}