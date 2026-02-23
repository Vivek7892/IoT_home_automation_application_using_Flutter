import 'package:flutter/material.dart';
import '../constants/channel_store.dart';

class AddChannelScreen extends StatefulWidget {
  final String channelName;
  final bool rememberWifi;

  const AddChannelScreen({
    super.key,
    required this.channelName,
    required this.rememberWifi,
  });

  @override
  State<AddChannelScreen> createState() => _AddChannelScreenState();
}

class _AddChannelScreenState extends State<AddChannelScreen> {
  final TextEditingController ssidController = TextEditingController(
    text: "MY_Home_WiFi",
  );

  final TextEditingController passwordController = TextEditingController(
    text: "MY_Home_WiFi_Password",
  );

  @override
  void dispose() {
    ssidController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// FINISH SETUP
  void finishSetup() {
    String ssid = ssidController.text.trim();
    String password = passwordController.text.trim();

    if (ssid.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter WiFi SSID and Password")),
      );
      return;
    }

    ChannelStore.instance.addChannel(name: widget.channelName);

    /// SUCCESS MESSAGE
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${widget.channelName} added successfully")),
    );

    /// GO TO CHANNELS LIST
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/my-channels',
        (route) => route.settings.name == '/home',
      );
    });
  }

  Widget stepText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 15)),
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

        /// BACK BUTTON (go to QR page)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5E60CE)),
          onPressed: () => Navigator.pop(context),
        ),

        /// TITLE
        title: Text(
          widget.channelName,
          style: const TextStyle(
            color: Color(0xFF5E60CE),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        /// NEXT BUTTON TOP RIGHT
        actions: [
          TextButton(
            onPressed: finishSetup,
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
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Follow our simple steps to configure the channel",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            stepText("Step 1: Turn Off your smartphone internet data."),
            stepText("Step 2: Go to WiFi settings of your smart phone."),
            stepText("Step 3: Start scanning for available WiFi networks."),
            stepText("Step 4: Find Migro Switch in the WiFi networks list."),
            stepText("Step 5: Connect to Migro Switch."),
            stepText("Step 6: Once connected, come back to the app."),
            stepText("Step 7: Provide SSID and Password of your home WiFi."),

            const SizedBox(height: 25),

            /// SSID
            const Text(
              "Enter SSID",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            TextField(
              controller: ssidController,
              decoration: const InputDecoration(hintText: "MY_Home_WiFi"),
            ),

            const SizedBox(height: 20),

            /// PASSWORD
            const Text(
              "Enter Password",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "MY_Home_WiFi_Password",
              ),
            ),

            const SizedBox(height: 40),

            /// BOTTOM BUTTON (same as Next)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A75F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: finishSetup,
                child: const Text(
                  "Finish Setup",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
