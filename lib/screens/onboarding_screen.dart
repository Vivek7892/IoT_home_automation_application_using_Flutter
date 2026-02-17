import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  int currentIndex = 0;

  List<String> images = [
    //"assets/connect.png",
    //"assetts/control.png",
    "assets/save.png",
  ];

  void nextPage() {
    if (currentIndex < images.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => loginScreen()),
      );
    }
  }

  void skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Image.asset(images[index])),
                    SizedBox(height: 20),

                    /// Dots indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (dotIndex) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: currentIndex == dotIndex ? 12 : 8,
                          height: currentIndex == dotIndex ? 12 : 8,
                          decoration: BoxDecoration(
                            color: currentIndex == dotIndex
                                ? Colors.purple
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: nextPage,
                      child: Text(
                        currentIndex == images.length - 1
                            ? "Get Started"
                            : "Next",
                      ),
                    ),

                    TextButton(onPressed: skip, child: Text("Skip")),

                    SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
