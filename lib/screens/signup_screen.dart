import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

// ─── Sign Up ──────────────────────────────────────────────────────────────────
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePass = true, _obscureConfirm = true, _accepted = false;

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
              const Expanded(child: Center(child: Text('Sign Up', style: TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.w700)))),
              const SizedBox(width: 48),
            ]),
            const SizedBox(height: 20),
            _label('Email'), _field('email@email.com', false),
            const SizedBox(height: 16),
            _label('Password'), _passField('password@123', _obscurePass, () => setState(() => _obscurePass = !_obscurePass)),
            const SizedBox(height: 16),
            _label('Confirm Password'), _passField('password@123', _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm)),
            const SizedBox(height: 16),
            Row(children: [
              SizedBox(width: 20, height: 20, child: Checkbox(value: _accepted, onChanged: (v) => setState(() => _accepted = v ?? false), activeColor: AppColors.primary, side: const BorderSide(color: Color(0xFF999999), width: 1.5))),
              const SizedBox(width: 8),
              const Text('I accept the policy and terms.', style: TextStyle(color: Color(0xFF888888), fontSize: 13)),
            ]),
            const SizedBox(height: 24),
            GradientButton(text: 'Continue', onPressed: () => Navigator.pushReplacementNamed(context, '/home'), height: 52),
            const SizedBox(height: 14),
            Center(child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text.rich(TextSpan(text: 'Already have an account? ', style: TextStyle(color: Color(0xFF888888), fontSize: 13), children: [TextSpan(text: 'Login here', style: TextStyle(color: AppColors.primary))])),
            )),
            const SizedBox(height: 40),
            Align(alignment: Alignment.centerRight, child: Opacity(opacity: 0.5, child: Icon(Icons.lightbulb_outline, size: 140, color: const Color(0xFFFFD600).withOpacity(0.7)))),
          ]),
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(t, style: const TextStyle(color: Color(0xFF888888), fontSize: 15)));

  Widget _field(String hint, bool obscure) => TextField(
    obscureText: obscure,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 15),
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
    ),
  );

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
