import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 8),
            Row(children: [
              IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.primary), onPressed: () => Navigator.pop(context)),
              const Expanded(child: Center(child: Text('Forgot Password', style: TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.w700)))),
              const SizedBox(width: 48),
            ]),
            const SizedBox(height: 24),
            const Text("Enter the email associated with your account and we'll send an email with instructions to reset your password.", style: TextStyle(color: Color(0xFF666666), fontSize: 15, height: 1.5)),
            const SizedBox(height: 28),
            const Text('Email', style: TextStyle(color: Color(0xFF888888), fontSize: 15)),
            const SizedBox(height: 6),
            const TextField(
              decoration: InputDecoration(
                hintText: 'email@email.com',
                hintStyle: TextStyle(color: Color(0xFFAAAAAA), fontSize: 15),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
              ),
            ),
            const SizedBox(height: 36),
            GradientButton(text: 'Continue', onPressed: () => Navigator.pushNamed(context, '/check-email'), height: 52),
            const SizedBox(height: 80),
            Align(alignment: Alignment.centerRight, child: Opacity(opacity: 0.5, child: Icon(Icons.lightbulb_outline, size: 140, color: const Color(0xFFFFD600).withOpacity(0.7)))),
          ]),
        ),
      ),
    );
  }
}

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

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});
  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  bool _obscure1 = true, _obscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 8),
            Row(children: [
              IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.primary), onPressed: () => Navigator.pop(context)),
              const Expanded(child: Center(child: Text('Create New Password', style: TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.w700)))),
              const SizedBox(width: 48),
            ]),
            const SizedBox(height: 24),
            const Text("Your new password must be different from your previous used passwords.", style: TextStyle(color: Color(0xFF666666), fontSize: 14, height: 1.5)),
            const SizedBox(height: 28),
            const Text('Password', style: TextStyle(color: Color(0xFF888888), fontSize: 15)),
            const SizedBox(height: 6),
            _passField('password@123', _obscure1, () => setState(() => _obscure1 = !_obscure1)),
            const SizedBox(height: 6),
            const Text('Must be atleast 8 characters.', style: TextStyle(color: Color(0xFF999999), fontSize: 12)),
            const SizedBox(height: 20),
            const Text('Confirm Password', style: TextStyle(color: Color(0xFF888888), fontSize: 15)),
            const SizedBox(height: 6),
            _passField('password@123', _obscure2, () => setState(() => _obscure2 = !_obscure2)),
            const SizedBox(height: 6),
            const Text('Both passwords must match.', style: TextStyle(color: Color(0xFF999999), fontSize: 12)),
            const SizedBox(height: 36),
            GradientButton(text: 'Reset Password', onPressed: () => Navigator.pushReplacementNamed(context, '/login'), height: 52),
            const SizedBox(height: 60),
            Align(alignment: Alignment.centerRight, child: Opacity(opacity: 0.5, child: Icon(Icons.lightbulb_outline, size: 130, color: const Color(0xFFFFD600).withOpacity(0.7)))),
          ]),
        ),
      ),
    );
  }

  Widget _passField(String hint, bool obscure, VoidCallback toggle) => TextField(
    obscureText: obscure,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 15),
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
      suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey, size: 20), onPressed: toggle),
    ),
  );
}
