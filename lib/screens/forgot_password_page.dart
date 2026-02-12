import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),

              const SizedBox(height: 10),

              // Title
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A5DAA),
                ),
              ),

              const SizedBox(height: 25),

              // Description
              const Text(
                "Enter the email associated with your account and we’ll send an email with instructions to reset your password.",
                style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
              ),

              const SizedBox(height: 30),

              // Email Label
              const Text(
                "Email",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 8),

              // Email Field
              const TextField(
                decoration: InputDecoration(
                  hintText: "email@email.com",
                  hintStyle: TextStyle(color: Colors.indigo),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Continue Button
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7B7BFF), Color(0xFFFF7BC3)],
                    ),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Reset email sent!")),
                      );
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Bottom Image
              Center(child: Image.asset("assets/forgot.png", height: 180)),
            ],
          ),
        ),
      ),
    );
  }
}
