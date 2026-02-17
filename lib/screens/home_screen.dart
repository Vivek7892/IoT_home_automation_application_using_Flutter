import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Color(0xFF484B9A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Color(0xFF484B9A)),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Greeting Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF4B4FA3),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Vivek V",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "May 30",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "10:30 PM",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// My Channels Title
            const Row(
              children: [
                Icon(Icons.square, color: Color(0xFF0C0C54), size: 14),
                SizedBox(width: 10),
                Text(
                  "My Channels",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C0C54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// Description
            const Center(
              child: Text(
                "There are no channels yet, please add a\nchannel & configure it to see the power of\nour system.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.4),
              ),
            ),

            const SizedBox(height: 40),

            /// Image
            Center(child: Image.asset("assets/home.png", height: 200)),

            const SizedBox(height: 30),

            /// Add Channels Button
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  side: const BorderSide(color: Color(0xFF6A75F2), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                onPressed: () {
                  Navigator.pushNamed(context, '/add-channel-qr');
                },

                child: const Text(
                  "Add Channels +",
                  style: TextStyle(
                    color: Color(0xFF6A75F2),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /// Floating Buttons
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildCircle(Icons.nightlight_round),
          const SizedBox(width: 12),
          buildCircle(Icons.crop_square),
          const SizedBox(width: 12),
          buildCircle(Icons.power),
          const SizedBox(width: 12),
          buildCircle(Icons.meeting_room),
          const SizedBox(width: 12),

          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget buildCircle(IconData icon) {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
        color: Color(0xFF0C0C54),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
