import 'package:flutter/material.dart';

class MyScenesScreen extends StatefulWidget {
  const MyScenesScreen({super.key});

  @override
  State<MyScenesScreen> createState() => _MyScenesScreenState();
}

class _MyScenesScreenState extends State<MyScenesScreen> {
  final List<Map<String, dynamic>> _scenes = [
    {"name": "Party", "devices": "4 Devices", "isOn": true},
    {"name": "Outdoor", "devices": "12 Devices", "isOn": false},
    {"name": "Night", "devices": "3 Devices", "isOn": null},
    {"name": "Rainy", "devices": "6 Devices", "isOn": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
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
                          size: 34,
                        ),
                      ),
                      const Spacer(),
                      const Row(
                        children: [
                          Icon(Icons.nightlight_round, color: Color(0xFF4B4FA3), size: 24),
                          SizedBox(width: 4),
                          Text(
                            "My Scenes",
                            style: TextStyle(
                              color: Color(0xFF4B4FA3),
                              fontSize: 22 * 1.2 / 2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(Icons.notifications_none, color: Color(0xFF4B4FA3), size: 28),
                          Positioned(
                            right: -5,
                            top: -5,
                            child: CircleAvatar(
                              radius: 9,
                              backgroundColor: Color(0xFFE2AD73),
                              child: Text(
                                "4",
                                style: TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B4FA3),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(color: Color(0x26000000), blurRadius: 6, offset: Offset(0, 3)),
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
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18 * 1.3 / 2,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Nitin",
                                style: TextStyle(color: Colors.white, fontSize: 18 * 1.3 / 2),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Total Channels",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18 * 1.3 / 2,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "4",
                              style: TextStyle(color: Colors.white, fontSize: 18 * 1.3 / 2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Icon(Icons.nightlight_round, color: Color(0xFF070B72), size: 24),
                      const SizedBox(width: 6),
                      const Text(
                        "My Scenes",
                        style: TextStyle(
                          color: Color(0xFF070B72),
                          fontWeight: FontWeight.w700,
                          fontSize: 28 / 1.3,
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF7480F0), width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Add More Scenes",
                              style: TextStyle(color: Color(0xFF7480F0), fontSize: 16),
                            ),
                            Icon(Icons.add, color: Color(0xFF7480F0), size: 22),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "List of all scenes in my home",
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontStyle: FontStyle.italic,
                      fontSize: 14 * 1.2 / 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    itemCount: _scenes.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) => _sceneCard(_scenes[index]),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: Row(
                children: [
                  _dockFab(Icons.home, const Color(0xFF070B72), () {
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  }),
                  const Spacer(),
                  _dockIcon(Icons.nightlight_round),
                  const SizedBox(width: 8),
                  _dockIcon(Icons.square_rounded),
                  const SizedBox(width: 8),
                  _dockIcon(Icons.power),
                  const SizedBox(width: 8),
                  _dockIcon(Icons.meeting_room),
                  const SizedBox(width: 8),
                  _dockFab(Icons.close, const Color(0xFFFF4F57), () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sceneCard(Map<String, dynamic> scene) {
    final bool? isOn = scene["isOn"] as bool?;
    final Color powerColor = isOn == null
        ? const Color(0xFFA2A2A2)
        : isOn
            ? const Color(0xFF6AD16A)
            : const Color(0xFFE57070);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x22000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.nightlight_round, color: Color(0xFF4B4FA3), size: 20),
              const Spacer(),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: powerColor, width: 2),
                ),
                child: Icon(Icons.power_settings_new, color: powerColor, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            scene["name"] as String,
            style: const TextStyle(
              color: Color(0xFF4B4FA3),
              fontSize: 18 * 1.2 / 2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            scene["devices"] as String,
            style: const TextStyle(
              color: Color(0xFFFF8C2D),
              fontSize: 14,
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/manage-scene'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF7480F0), width: 1.8),
              visualDensity: VisualDensity.compact,
              minimumSize: const Size.fromHeight(36),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Manage", style: TextStyle(color: Color(0xFF7480F0))),
                SizedBox(width: 3),
                Icon(Icons.settings, color: Color(0xFF7480F0), size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dockFab(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _dockIcon(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(color: Color(0xFF070B72), shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
