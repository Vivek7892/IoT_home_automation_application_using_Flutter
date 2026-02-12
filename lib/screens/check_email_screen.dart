import 'package:flutter/material.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Stack(
          children: [
            // Envelope Icon
            Positioned(
              left: 155,
              top: 85,
              child: Icon(
                Icons.mail_outline,
                size: 50,
                color: Color(0xFF787DF4),
              ),
            ),

            // Title
            Positioned(
              left: 101,
              top: 172,
              child: Text(
                "Check Your Email",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1.15,
                  color: Color(0xFF484B9A),
                ),
              ),
            ),

            // Description
            Positioned(
              left: 16,
              top: 225,
              width: 328,
              child: Text(
                "We have sent a password recovery instructions to your registered email.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  height: 1.17,
                  color: Color(0xFF8E8E8E),
                ),
              ),
            ),

            // Button
            Positioned(
              left: 105,
              top: 297,
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A75F2), Color(0xFFE46BBE)],
                  ),
                ),
                child: Center(
                  child: Text(
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

            // Spam Folder Text
            Positioned(
              left: 16,
              top: 367,
              width: 328,
              child: Text(
                "Didn't received the email? Check your spam folder or try again",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.17,
                  color: Color(0xFF8E8E8E),
                ),
              ),
            ),

            // Bulb Image
            Positioned(
              left: 122,
              top: 474,
              child: SizedBox(
                width: 262,
                height: 248,
                child: Image.asset(
                  "assets/bulb.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
