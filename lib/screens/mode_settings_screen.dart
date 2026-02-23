import 'package:flutter/material.dart';

class ModeSettingsScreen extends StatefulWidget {
  const ModeSettingsScreen({super.key});

  @override
  State<ModeSettingsScreen> createState() => _ModeSettingsScreenState();
}

class _ModeSettingsScreenState extends State<ModeSettingsScreen> {
  String _selectedMode = "Auto";
  bool _adaptiveLights = true;
  bool _quietHours = false;
  bool _motionBoost = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4B4FA3)),
        ),
        centerTitle: true,
        title: const Text(
          "Mode Settings",
          style: TextStyle(
            color: Color(0xFF4B4FA3),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4B4FA3),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  "Choose how your home behaves during day/night and when you are away.",
                  style: TextStyle(color: Colors.white, fontSize: 15, height: 1.3),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Home Mode",
                style: TextStyle(
                  color: Color(0xFF2F3388),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _modeChip("Auto", Icons.settings_suggest),
                  _modeChip("Day", Icons.wb_sunny_outlined),
                  _modeChip("Night", Icons.nightlight_round),
                  _modeChip("Away", Icons.exit_to_app),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Automation",
                style: TextStyle(
                  color: Color(0xFF2F3388),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              _switchTile(
                "Adaptive Lights",
                "Auto adjust light intensity by time.",
                _adaptiveLights,
                (value) => setState(() => _adaptiveLights = value),
              ),
              _switchTile(
                "Quiet Hours",
                "Reduce notification and sound events at night.",
                _quietHours,
                (value) => setState(() => _quietHours = value),
              ),
              _switchTile(
                "Motion Boost",
                "Turn on hallway lights when movement is detected.",
                _motionBoost,
                (value) => setState(() => _motionBoost = value),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7B84F7), Color(0xFFE46BBE)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Mode settings saved")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeChip(String value, IconData icon) {
    final bool selected = _selectedMode == value;
    return ChoiceChip(
      selected: selected,
      onSelected: (_) => setState(() => _selectedMode = value),
      side: BorderSide(
        color: selected ? const Color(0xFF4B4FA3) : const Color(0xFFB3B6E8),
      ),
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFFDDE0F8),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF4B4FA3)),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF4B4FA3),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF2F3388),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF4B4FA3),
            activeThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
