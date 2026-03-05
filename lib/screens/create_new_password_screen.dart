import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});
  @override
  State<CreateNewPasswordScreen> createState() => _State();
}

class _State extends State<CreateNewPasswordScreen> {
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
