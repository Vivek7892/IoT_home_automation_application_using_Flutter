import 'package:flutter/material.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.mail_outline,
                  size: 50,
                  color: Color(0xFF787DF4),
                ),
                const SizedBox(height: 28),
                const Text(
                  "Check Your Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 1.15,
                    color: Color(0xFF484B9A),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "We have sent password recovery instructions to your registered email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    height: 1.17,
                    color: Color(0xFF8E8E8E),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 150,
                  height: 42,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A75F2), Color(0xFFE46BBE)],
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Didn't receive the email? Check your spam folder or try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.17,
                    color: Color(0xFF8E8E8E),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 262,
                  height: 248,
                  child: Image.asset("assets/bulb.png", fit: BoxFit.contain),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
