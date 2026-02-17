import 'package:flutter/material.dart';
import 'add_channel_screen.dart';

class AddChannelQRScreen extends StatefulWidget {
  const AddChannelQRScreen({super.key});

  @override
  State<AddChannelQRScreen> createState() => _AddChannelQRScreenState();
}

class _AddChannelQRScreenState extends State<AddChannelQRScreen> {
  bool rememberWifi = true;

  final TextEditingController channelNameController = TextEditingController(
    text: "Migro_CH1",
  );

  @override
  void dispose() {
    channelNameController.dispose();
    super.dispose();
  }

  /// NAVIGATE TO WIFI SETUP
  void goNext() {
    String channelName = channelNameController.text.trim();

    if (channelName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter channel name")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddChannelScreen(
          channelName: channelName,
          rememberWifi: rememberWifi,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      /// APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,

        /// BACK BUTTON
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5E60CE)),
          onPressed: () => Navigator.pop(context),
        ),

        /// TITLE
        title: const Text(
          "Add Channel",
          style: TextStyle(
            color: Color(0xFF5E60CE),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        /// NEXT BUTTON (TOP RIGHT)
        actions: [
          TextButton(
            onPressed: goNext,
            child: const Text(
              "Next",
              style: TextStyle(
                color: Color(0xFF5E60CE),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),

        child: Column(
          children: [
            const SizedBox(height: 20),

            /// DEVICE IMAGE
            Image.asset("assets/plug.png", height: 220),

            const SizedBox(height: 30),

            /// SCAN QR BUTTON
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                side: const BorderSide(color: Color(0xFF6A75F2), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("QR Scanner will open here")),
                );
              },
              child: const Text(
                "Scan QR Code",
                style: TextStyle(color: Color(0xFF6A75F2), fontSize: 18),
              ),
            ),

            const SizedBox(height: 25),

            /// OR DIVIDER
            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 25),

            /// CHANNEL NAME
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Set Channel Name",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),

            TextField(
              controller: channelNameController,
              decoration: const InputDecoration(hintText: "Migro_CH1"),
            ),

            const SizedBox(height: 30),

            /// REMEMBER WIFI SWITCH
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Remember WiFi Settings",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "(Saving WiFi settings will make future device setup much easier)",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Switch(
                  value: rememberWifi,
                  activeColor: const Color(0xFF5E60CE),
                  onChanged: (value) {
                    setState(() => rememberWifi = value);
                  },
                ),
              ],
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
