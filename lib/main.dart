/* url: 'https://djfwhenqqkyhzbedgzfx.supabase.co', // 🔁 Replace with your URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRqZndoZW5xcWt5aHpiZWRnemZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM2NzQ2NzIsImV4cCI6MjA1OTI1MDY3Mn0.AK_KZStRsB4a0897QcbTTle4MU3YIJdYDMeonEg0hPI', // 🔁 Replace with your anon key
  );
*/

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';
import 'admin_dashboard.dart';
import 'employee_dashboard.dart';
import 'doctor_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://djfwhenqqkyhzbedgzfx.supabase.co', // 🔁 Replace with your URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRqZndoZW5xcWt5aHpiZWRnemZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM2NzQ2NzIsImV4cCI6MjA1OTI1MDY3Mn0.AK_KZStRsB4a0897QcbTTle4MU3YIJdYDMeonEg0hPI', // 🔁 Replace with your anon key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRMS Portal',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode:
          ThemeMode.system, // Automatically switches between light and dark
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}
/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRMS Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
*/

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Widget> _navigateUser() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) return const LoginScreen();

    final userData =
        await supabase
            .from('users')
            .select('user_type')
            .eq('email', user.email ?? '')
            .maybeSingle();

    switch (userData?['user_type']) {
      case 'Admin':
        return const AdminDashboard();
      case 'Doctor':
        return const DoctorDashboard();
      case 'Employee':
        return const EmployeeDashboard();
      default:
        return const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _navigateUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return snapshot.data!;
      },
    );
  }
}
