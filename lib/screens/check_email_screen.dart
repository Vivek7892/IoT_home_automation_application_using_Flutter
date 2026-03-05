import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            const Spacer(flex: 2),
            const Icon(Icons.mark_email_read_outlined, size: 80, color: Color(0xFFCCCCCC)),
            const SizedBox(height: 24),
            const Text('Check Your Email', style: TextStyle(color: Color(0xFF444444), fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            const Text('We have sent a password recovery\ninstructions to your registered email.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF888888), fontSize: 15, height: 1.5)),
            const SizedBox(height: 32),
            GradientButton(text: 'Ok', onPressed: () => Navigator.pushReplacementNamed(context, '/login'), height: 52, width: 200),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text.rich(TextSpan(text: "Didn't received the email? Check your spam folder or ", style: TextStyle(color: Color(0xFF888888), fontSize: 13), children: [TextSpan(text: 'try again', style: TextStyle(color: AppColors.primary))]), textAlign: TextAlign.center),
            ),
            const Spacer(flex: 3),
          ]),
        ),
      ),
    );
  }
}
