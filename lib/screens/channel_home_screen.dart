import 'package:flutter/material.dart';

class ChannelHomeScreen extends StatelessWidget {
  const ChannelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF4B4FA3),
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.square_rounded,
                        color: Color(0xFF4B4FA3),
                        size: 34,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "Migro_CH1",
                          style: TextStyle(
                            color: Color(0xFF4B4FA3),
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.notifications_none,
                        color: Color(0xFF4B4FA3),
                        size: 32,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B4FA3),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Morning!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Nitin",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Total Devices",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "3/4",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      const Icon(Icons.power, color: Color(0xFF0A0F66), size: 32),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "Devices in Migro_CH 1",
                          style: TextStyle(
                            color: Color(0xFF0A0F66),
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF7480F0), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                        ),
                        icon: const Icon(Icons.settings_suggest, color: Color(0xFF7480F0)),
                        label: const Text(
                          "Manage",
                          style: TextStyle(
                            color: Color(0xFF7480F0),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "List of all devices in this channel.\n"
                    "Slide left to remove device, slide right to edit.",
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "You can add 1 more electronic devices in this Channel.",
                    style: TextStyle(
                      color: Color(0xFFF08A2A),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildChannelDeviceCard(
                    name: "Light Bulb",
                    plug: "Plug 1",
                    icon: Icons.lightbulb_outline,
                    switchColor: const Color(0xFF5ACB5A),
                  ),
                  const SizedBox(height: 16),
                  _buildChannelDeviceCard(
                    name: "Fan",
                    plug: "Plug 1",
                    icon: Icons.toys,
                    switchColor: const Color(0xFFE86B6B),
                  ),
                  const SizedBox(height: 16),
                  _buildChannelDeviceCard(
                    name: "Desktop",
                    plug: "Plug 3",
                    icon: Icons.desktop_windows,
                    switchColor: const Color(0xFFE86B6B),
                  ),
                  const SizedBox(height: 16),
                  _buildChannelDeviceCard(
                    name: "TV",
                    plug: "Plug 2",
                    icon: Icons.tv,
                    switchColor: const Color(0xFF8E8E8E),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 20,
              child: Row(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: const Color(0xFF070B72),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.home, color: Colors.white, size: 40),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4A4A),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add-device-to-channel');
                      },
                      icon: const Icon(Icons.add, color: Colors.white, size: 44),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelDeviceCard({
    required String name,
    required String plug,
    required IconData icon,
    required Color switchColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4B4FA3), size: 34),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFF4B4FA3),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFF08A2A), width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        plug,
                        style: const TextStyle(
                          color: Color(0xFFF08A2A),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Tap the button to on/off the device",
                  style: TextStyle(
                    color: Color(0xFF7D7D7D),
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: switchColor, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.power_settings_new,
              color: switchColor,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
