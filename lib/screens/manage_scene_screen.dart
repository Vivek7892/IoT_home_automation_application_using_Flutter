import 'package:flutter/material.dart';

class ManageSceneScreen extends StatefulWidget {
  const ManageSceneScreen({super.key});

  @override
  State<ManageSceneScreen> createState() => _ManageSceneScreenState();
}

class _ManageSceneScreenState extends State<ManageSceneScreen> {
  String _mode = "Manual";
  String _timerValue = "15 Mins";
  bool _showTimerPicker = false;

  @override
  Widget build(BuildContext context) {
    final bool dimmed = _showTimerPicker;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: dimmed ? 0.52 : 1,
              child: IgnorePointer(
                ignoring: dimmed,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(context),
                      const SizedBox(height: 20),
                      _summaryCard(),
                      const SizedBox(height: 34),
                      const Row(
                        children: [
                          Icon(Icons.power, color: Color(0xFF070B72), size: 28),
                          SizedBox(width: 8),
                          Text(
                            "Party Scene",
                            style: TextStyle(
                              color: Color(0xFF070B72),
                              fontSize: 40 / 2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "You can start the scene manually, or by scheduling it at a\n"
                        "specific time or setting up a timer. Choose your options",
                        style: TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 19 / 1.2,
                          fontStyle: FontStyle.italic,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 26),
                      _modeTabs(),
                      const SizedBox(height: 42),
                      if (_mode == "Manual") ...[
                        const Center(
                          child: Text(
                            "This is a default setting of the scene, you can\n"
                            "anytime switch on/off your devices as per your\n"
                            "scene from the Dashboard or My Scenes page.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6E6E6E),
                              fontSize: 28 / 1.3,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        _viewDevicesLink(),
                      ],
                      if (_mode == "Timer") ...[
                        const Center(
                          child: Text(
                            "You can choose the time for the scene to be active\n"
                            "by setting the time below.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6E6E6E),
                              fontSize: 28 / 1.3,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        _viewDevicesLink(),
                        const SizedBox(height: 48),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showTimerPicker = true;
                              });
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Set Time: ",
                                style: const TextStyle(
                                  color: Color(0xFF787878),
                                  fontSize: 22 * 1.2 / 2,
                                ),
                                children: [
                                  TextSpan(
                                    text: _timerValue,
                                    style: const TextStyle(
                                      color: Color(0xFF444B99),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22 * 1.2 / 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _saveButton(),
                      ],
                      if (_mode == "Schedule") ...[
                        const Center(
                          child: Text(
                            "The devices would switch on/off when selected\n"
                            "from the Dashboard or My Scenes page for the time\n"
                            "set below.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6E6E6E),
                              fontSize: 28 / 1.3,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _viewDevicesLink(),
                        const SizedBox(height: 30),
                        _saveButton(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 22,
              child: Row(
                children: [
                  _fab(
                    color: const Color(0xFF070B72),
                    icon: Icons.home,
                    onTap: dimmed
                        ? null
                        : () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (route) => false,
                            );
                          },
                  ),
                  const Spacer(),
                  _fab(
                    color: const Color(0xFFFF4F57),
                    icon: Icons.add,
                    onTap: dimmed ? null : () {},
                  ),
                ],
              ),
            ),
            if (_showTimerPicker) _timerPickerOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4B4FA3), size: 42),
        ),
        const Spacer(),
        const Row(
          children: [
            Icon(Icons.nightlight_round, color: Color(0xFF4B4FA3), size: 30),
            SizedBox(width: 6),
            Text(
              "Manage Scene",
              style: TextStyle(
                color: Color(0xFF4B4FA3),
                fontSize: 52 / 2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.notifications_none, color: Color(0xFF4B4FA3), size: 36),
      ],
    );
  }

  Widget _summaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF4B4FA3),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 4)),
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
                    fontSize: 22 * 1.3 / 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Nitin",
                  style: TextStyle(color: Colors.white, fontSize: 20 * 1.4 / 2),
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
                  fontSize: 22 * 1.3 / 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "20",
                style: TextStyle(color: Colors.white, fontSize: 20 * 1.4 / 2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _modeTabs() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFDDE0F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _modeTab("Manual"),
          const SizedBox(width: 14),
          _modeTab("Timer"),
          const SizedBox(width: 14),
          const Text("|", style: TextStyle(color: Color(0xFF7E7E7E), fontSize: 30)),
          const SizedBox(width: 14),
          _modeTab("Schedule"),
        ],
      ),
    );
  }

  Widget _modeTab(String value) {
    final bool selected = _mode == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _mode = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF444B99),
                fontSize: 40 / 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _viewDevicesLink() {
    return Center(
      child: TextButton.icon(
        onPressed: () => Navigator.pushNamed(context, '/my-scenes'),
        iconAlignment: IconAlignment.end,
        icon: const Icon(Icons.arrow_forward, color: Color(0xFF6473ED), size: 34),
        label: const Text(
          "View devices & channel in this scene",
          style: TextStyle(
            color: Color(0xFF6473ED),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return Center(
      child: SizedBox(
        width: 300,
        height: 80,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF8784EF), Color(0xFFE177D3)],
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Scene saved")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            ),
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
                fontSize: 46 / 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fab({
    required Color color,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Opacity(
      opacity: onTap == null ? 0.45 : 1,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(icon, color: Colors.white, size: 42),
        ),
      ),
    );
  }

  Widget _timerPickerOverlay() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 385,
            padding: const EdgeInsets.fromLTRB(30, 26, 30, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose Time",
                  style: TextStyle(
                    color: Color(0xFF444B99),
                    fontSize: 46 / 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 26),
                ...["1 Min", "5 Min", "10 Min", "15 Min", "Manual"].map(
                  (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _timerValue = option == "Manual" ? "Manual" : option;
                          _showTimerPicker = false;
                        });
                      },
                      child: Text(
                        option,
                        style: const TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 48 / 2,
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
              onTap: () {
                setState(() {
                  _showTimerPicker = false;
                });
              },
              child: Container(
                width: 74,
                height: 74,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4F57),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 42),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
