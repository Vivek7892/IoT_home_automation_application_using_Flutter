import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "image": "assets/connect.png",
      "title": "CONNECT",
      "desc": "Connect all your smart home\n"
          "devices using easiest steps\n"
          "and manage fast.",
      "accent": const Color(0xFF8A6FEA),
    },
    {
      "image": "assets/control.png",
      "title": "CONTROL",
      "desc": "Control your devices from home,\n"
          "abroad or from anywhere in the\n"
          "world and just relax.",
      "accent": const Color(0xFFE86BC0),
    },
    {
      "image": "assets/save.png",
      "title": "SAVE",
      "desc": "Create scenes as per your\n"
          "mood and needs, just one click\n"
          "and manage your home.",
      "accent": const Color(0xFF6B79EA),
    },
  ];

  void skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Center(
                    child: Image.asset(
                      pages[index]["image"] as String,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  pages[index]["title"] as String,
                  style: TextStyle(
                    color: pages[index]["accent"] as Color,
                    fontWeight: FontWeight.w700,
                    fontSize: 26 * 1.1,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  pages[index]["desc"] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF868686),
                    fontSize: 19 * 1.1,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 42),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (dotIndex) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: currentIndex == dotIndex
                            ? const Color(0xFF8A6FEA)
                            : const Color(0xFFC4C4C4),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 210,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: skip,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE86BC0), width: 1.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Color(0xFFE86BC0),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
