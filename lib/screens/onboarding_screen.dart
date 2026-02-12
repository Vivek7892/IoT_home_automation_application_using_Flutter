import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "CONNECT",
      "description":
          "Connect all your smart home devices using easiest steps and manage fast.",
      "image": "assets/connect.png"
    },
    {
      "title": "CONTROL",
      "description":
          "Control your devices from home, abroad or from anywhere in the world and just relax.",
      "image": "assets/control.png"
    },
    {
      "title": "SAVE",
      "description":
          "Create scenes as per your mood and needs, just one click and manage your home.",
      "image": "assets/save.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return buildPage(
                    onboardingData[index]["title"]!,
                    onboardingData[index]["description"]!,
                    onboardingData[index]["image"]!,
                  );
                },
              ),
            ),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index),
              ),
            ),

            const SizedBox(height: 30),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  side: const BorderSide(color: Color(0xFF8E6CEF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (currentIndex == onboardingData.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Text(
                  currentIndex == onboardingData.length - 1
                      ? "Get Started"
                      : "Skip",
                  style: const TextStyle(
                    color: Color(0xFF8E6CEF),
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildPage(String title, String description, String image) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8E6CEF),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: currentIndex == index ? 30 : 10,
      decoration: BoxDecoration(
        color: currentIndex == index ? const Color(0xFF8E6CEF) : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
