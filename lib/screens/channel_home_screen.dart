import 'package:flutter/material.dart';

class ChannelHomeScreen extends StatefulWidget {
  const ChannelHomeScreen({super.key});

  @override
  State<ChannelHomeScreen> createState() => _ChannelHomeScreenState();
}

class _ChannelHomeScreenState extends State<ChannelHomeScreen> {
  final List<Map<String, dynamic>> _channelDevices = [
    {
      "name": "Light Bulb",
      "plug": "Plug 1",
      "icon": Icons.lightbulb_outline,
      "isOn": true,
    },
    {
      "name": "Fan",
      "plug": "Plug 2",
      "icon": Icons.toys,
      "isOn": false,
    },
    {
      "name": "Desktop",
      "plug": "Plug 3",
      "icon": Icons.desktop_windows,
      "isOn": false,
    },
    {
      "name": "TV",
      "plug": "Plug 4",
      "icon": Icons.tv,
      "isOn": false,
    },
  ];

  int get _activeDevices =>
      _channelDevices.where((device) => device["isOn"] as bool).length;

  void _showAddDeviceDialog() {
    final TextEditingController nameController = TextEditingController(
      text: "Light Bulb",
    );
    String selectedPlug = "Plug 4";

    showDialog<void>(
      context: context,
      barrierColor: const Color(0x66000000),
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Add Device to Channel",
                            style: TextStyle(
                              color: Color(0xFF444B99),
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Center(
                          child: Container(
                            width: 82,
                            height: 82,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF4B4FA3),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.lightbulb_outline,
                              color: Color(0xFF4B4FA3),
                              size: 42,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: nameController,
                          style: const TextStyle(
                            color: Color(0xFF4B4FA3),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.only(bottom: 8),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF969696),
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF6C74F3),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: selectedPlug,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF4B4FA3),
                          ),
                          style: const TextStyle(
                            color: Color(0xFF4B4FA3),
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.only(bottom: 8),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF969696),
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF6C74F3),
                                width: 2,
                              ),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(value: "Plug 1", child: Text("Plug 1")),
                            DropdownMenuItem(value: "Plug 2", child: Text("Plug 2")),
                            DropdownMenuItem(value: "Plug 3", child: Text("Plug 3")),
                            DropdownMenuItem(value: "Plug 4", child: Text("Plug 4")),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setDialogState(() {
                              selectedPlug = value;
                            });
                          },
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8784EF), Color(0xFFE177D3)],
                              ),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                final name = nameController.text.trim();
                                if (name.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Please provide device name"),
                                    ),
                                  );
                                  return;
                                }
                                final exists = _channelDevices.any(
                                  (device) => device["plug"] == selectedPlug,
                                );
                                if (exists) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("$selectedPlug already in use"),
                                    ),
                                  );
                                  return;
                                }
                                setState(() {
                                  _channelDevices.add({
                                    "name": name,
                                    "plug": selectedPlug,
                                    "icon": Icons.lightbulb_outline,
                                    "isOn": true,
                                  });
                                });
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40 / 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -10,
                    top: -10,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(dialogContext),
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5353),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 38),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

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
                    child: Row(
                      children: [
                        const Expanded(
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
                            const Text(
                              "Total Devices",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "$_activeDevices/${_channelDevices.length}",
                              style: const TextStyle(
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
                        onPressed: () {
                          _showAddDeviceDialog();
                        },
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
                        icon: const Icon(Icons.add, color: Color(0xFF7480F0)),
                        label: const Text(
                          "Add Device",
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
                  ..._channelDevices.asMap().entries.map((entry) {
                    final index = entry.key;
                    final device = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == _channelDevices.length - 1 ? 0 : 16,
                      ),
                      child: _buildChannelDeviceCard(
                        name: device["name"] as String,
                        plug: device["plug"] as String,
                        icon: device["icon"] as IconData,
                        isOn: device["isOn"] as bool,
                        onToggle: () {
                          setState(() {
                            _channelDevices[index]["isOn"] =
                                !(_channelDevices[index]["isOn"] as bool);
                          });
                        },
                      ),
                    );
                  }),
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
                        _showAddDeviceDialog();
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
    required bool isOn,
    required VoidCallback onToggle,
  }) {
    final Color switchColor = isOn
        ? const Color(0xFF5ACB5A)
        : const Color(0xFFE86B6B);
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
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
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
          ),
        ],
      ),
    );
  }
}
