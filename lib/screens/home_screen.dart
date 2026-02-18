import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Spacer(),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: Color(0xFF4B4FA3),
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.notifications_none,
                        color: Color(0xFF4B4FA3),
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
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
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Morning!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Vivek V",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "May 30",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "10:30 PM",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.square_rounded,
                        color: Color(0xFF0A0F66),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "My Channels",
                        style: TextStyle(
                          color: Color(0xFF0A0F66),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF6C74F3),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                        ),
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF6C74F3),
                        ),
                        label: const Text(
                          "View All Channels",
                          style: TextStyle(
                            color: Color(0xFF6C74F3),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "List of existing channels",
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.pushNamed(context, '/channel-home');
                    },
                    child: Container(
                      width: 156,
                      height: 116,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCFD0E6),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.square_rounded,
                            color: Color(0xFF4B4FA3),
                            size: 18,
                          ),
                          Spacer(),
                          Text(
                            "Migro_CH1",
                            style: TextStyle(
                              color: Color(0xFF4B4FA3),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "3/4 Devices",
                            style: TextStyle(
                              color: Color(0xFFF08A2A),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const Icon(
                        Icons.power,
                        color: Color(0xFF0A0F66),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "My Devices",
                        style: TextStyle(
                          color: Color(0xFF0A0F66),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF6C74F3),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                        ),
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF6C74F3),
                        ),
                        label: const Text(
                          "View All Devices",
                          style: TextStyle(
                            color: Color(0xFF6C74F3),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "List of my electronic devices",
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 156 / 127,
                    children: [
                      _buildHomeDeviceCard(
                        name: "Light Bulb",
                        channel: "Migro_CH1",
                        plug: "Plug 1",
                        icon: Icons.lightbulb_outline,
                        switchColor: const Color(0xFF5ACB5A),
                      ),
                      _buildHomeDeviceCard(
                        name: "Fan",
                        channel: "Migro_CH1",
                        plug: "Plug 2",
                        icon: Icons.toys,
                        switchColor: const Color(0xFFE86B6B),
                      ),
                      _buildHomeDeviceCard(
                        name: "Desktop",
                        channel: "Migro_CH1",
                        plug: "Plug 3",
                        icon: Icons.desktop_windows,
                        switchColor: const Color(0xFFE86B6B),
                      ),
                      _buildHomeDeviceCard(
                        name: "TV",
                        channel: "Migro_CH1",
                        plug: "Plug 4",
                        icon: Icons.tv,
                        switchColor: const Color(0xFF8E8E8E),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildDockCircle(Icons.person),
                        const SizedBox(width: 10),
                        _buildDockCircle(Icons.nightlight_round),
                        const SizedBox(width: 10),
                        _buildDockCircle(Icons.square_rounded),
                        const SizedBox(width: 10),
                        _buildDockCircle(Icons.power),
                        const SizedBox(width: 10),
                        _buildDockCircle(Icons.meeting_room),
                        const SizedBox(width: 12),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF4A4A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDockCircle(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: Color(0xFF0C0C54),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 14),
    );
  }

  Widget _buildHomeDeviceCard({
    required String name,
    required String channel,
    required String plug,
    required IconData icon,
    required Color switchColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4B4FA3), size: 22),
              const Spacer(),
              Container(
                width: 38,
                height: 38,
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
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF4B4FA3),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  channel,
                  style: const TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFF08A2A), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  plug,
                  style: const TextStyle(
                    color: Color(0xFFF08A2A),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
