import 'package:flutter/material.dart';

class AddDeviceToChannelScreen extends StatefulWidget {
  const AddDeviceToChannelScreen({super.key});

  @override
  State<AddDeviceToChannelScreen> createState() =>
      _AddDeviceToChannelScreenState();
}

class _AddDeviceToChannelScreenState extends State<AddDeviceToChannelScreen> {
  final TextEditingController _deviceNameController = TextEditingController(
    text: "Fan",
  );

  String _selectedChannel = "Migro_CH1";
  String _selectedPlug = "1";
  final List<Map<String, dynamic>> _devices = [
    {"name": "Fan", "plug": "Plug 1", "icon": Icons.toys},
    {"name": "Desktop", "plug": "Plug 2", "icon": Icons.desktop_windows},
    {"name": "TV", "plug": "Plug 3", "icon": Icons.tv},
  ];

  @override
  void dispose() {
    _deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ---------- APP BAR ----------
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF4B4FA3),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Add device to Channel",
                        style: TextStyle(
                          color: Color(0xFF2C2F84),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/channel-home',
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          color: Color(0xFF4B4FA3),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                const Text(
                  "You can add more than one device at a time, just choose the\n"
                  "channel, provide device name, choose device icon and save it.",
                  style: TextStyle(
                    color: Color(0xFF787878),
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 26),

                /// ---------- DEVICE NAME ----------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Provide Device Name",
                            style: TextStyle(
                              color: Color(0xFF5F5F5F),
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _deviceNameController,
                            style: const TextStyle(
                              color: Color(0xFF4B4FA3),
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(bottom: 8),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF9A9A9A),
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
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF4B4FA3),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.toys,
                        size: 40,
                        color: Color(0xFF4B4FA3),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// ---------- DROPDOWNS ----------
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownBlock(
                        title: "Choose Channel",
                        value: _selectedChannel,
                        items: const ["Migro_CH1"],
                        onChanged: (value) =>
                            setState(() => _selectedChannel = value!),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildDropdownBlock(
                        title: "Choose Plug",
                        value: _selectedPlug,
                        items: const ["1", "2", "3", "4"],
                        onChanged: (value) =>
                            setState(() => _selectedPlug = value!),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// ---------- SAVE BUTTON ----------
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7B84F7), Color(0xFFE46BBE)],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        final name = _deviceNameController.text.trim();
                        if (name.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please provide device name"),
                            ),
                          );
                          return;
                        }

                        final plugLabel = "Plug $_selectedPlug";
                        final alreadyExists = _devices.any(
                          (device) => device["plug"] == plugLabel,
                        );
                        if (alreadyExists) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "$plugLabel is already assigned in $_selectedChannel",
                              ),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          _devices.add({
                            "name": name,
                            "plug": plugLabel,
                            "icon": Icons.memory,
                          });
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Device saved")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// ---------- DEVICES HEADER ----------
                const Row(
                  children: [
                    Icon(Icons.power, color: Color(0xFF0B0F79), size: 22),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Devices in Migro_CH1",
                        style: TextStyle(
                          color: Color(0xFF0B0F79),
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                const Text(
                  "List of all devices in this channel. Slide left to remove device.",
                  style: TextStyle(
                    color: Color(0xFF8C8C8C),
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 16),

                ..._devices.asMap().entries.map((entry) {
                  final device = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: entry.key == _devices.length - 1 ? 0 : 12,
                    ),
                    child: _buildDeviceCard(
                      device["name"] as String,
                      device["plug"] as String,
                      device["icon"] as IconData,
                    ),
                  );
                }),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---------- DROPDOWN ----------
  Widget _buildDropdownBlock({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Color(0xFF5F5F5F), fontSize: 20),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF4B4FA3)),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
        Container(height: 2, color: const Color(0xFF9A9A9A)),
      ],
    );
  }

  /// ---------- DEVICE CARD ----------
  Widget _buildDeviceCard(String name, String plug, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: const Color(0xFF4B4FA3)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Color(0xFF4B4FA3),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF08A2A), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              plug,
              style: const TextStyle(color: Color(0xFFF08A2A), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
