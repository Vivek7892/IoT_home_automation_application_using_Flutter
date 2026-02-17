import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/check_email_screen.dart';
import 'screens/create_new_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_channel_qr_screen.dart';
import 'screens/add_channel_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),

      routes: {
        '/login': (context) => const LoginScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/check-email': (context) => const CheckEmailScreen(),
        '/create-password': (context) => const CreateNewPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/add-channel-qr': (context) => const AddChannelQRScreen(),
      },
    );
  }
}
