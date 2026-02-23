import 'package:flutter/material.dart';

class ConnectionSuccessScreen extends StatelessWidget {
  const ConnectionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Migro_CH1",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A56A6),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Image.asset(
                "assets/plug.png",
                height: 220,
              ),
            ),
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(Icons.check, color: Colors.green, size: 40),
            ),
            const SizedBox(height: 20),
            const Text(
              "Channel Connected!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              "Remote Access Enabled",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 260,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF6C7AE0), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/channel-home',
                    (route) => false,
                  );
                },
                child: const Text(
                  "Done, take me Home",
                  style: TextStyle(fontSize: 18, color: Color(0xFF6C7AE0)),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/add-channel-qr');
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.add, color: Color(0xFF6C7AE0)),
                        const SizedBox(width: 5),
                        const Text(
                          "Add more channels",
                          style: TextStyle(color: Color(0xFF6C7AE0)),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/add-device-to-channel');
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add, color: Color(0xFF6C7AE0)),
                        SizedBox(width: 5),
                        Text(
                          "Add devices",
                          style: TextStyle(color: Color(0xFF6C7AE0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
