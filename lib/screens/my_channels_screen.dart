import 'package:flutter/material.dart';
import '../constants/channel_store.dart';

class MyChannelsScreen extends StatefulWidget {
  const MyChannelsScreen({super.key});

  @override
  State<MyChannelsScreen> createState() => _MyChannelsScreenState();
}

class _MyChannelsScreenState extends State<MyChannelsScreen> {
  void _showChannelActions() {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bottomAction("Delete the channel"),
              const SizedBox(height: 24),
              _bottomAction("Edit channel name"),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color(0xFF636EEA),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAction(String label) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("$label clicked")));
      },
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF636EEA),
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final channelStore = ChannelStore.instance;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: ValueListenableBuilder<List<ChannelItem>>(
          valueListenable: channelStore.channels,
          builder: (context, channels, _) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF7C7FB0),
                      size: 36,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "My Channels",
                    style: TextStyle(
                      color: Color(0xFF7478AB),
                      fontWeight: FontWeight.w700,
                      fontSize: 52 / 2,
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        color: Color(0xFF7478AB),
                        size: 34,
                      ),
                      Positioned(
                        right: -6,
                        top: -6,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: const Color(0xFFE2AD73),
                          child: Text(
                            channels.length.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFF888BB8),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x30000000),
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
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Nitin",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Total Channels",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          channels.length.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  const Icon(Icons.square_rounded, color: Color(0xFF5A5F9B), size: 26),
                  const SizedBox(width: 8),
                  const Text(
                    "My Channels",
                    style: TextStyle(
                      color: Color(0xFF5A5F9B),
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: OutlinedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/add-channel-qr'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF9AA0F2),
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                "Add More Channels",
                                style: TextStyle(
                                  color: Color(0xFF9AA0F2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.add,
                                color: Color(0xFF9AA0F2),
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "List of all channels in my home",
                style: TextStyle(
                  color: Color(0xFF9A9A9A),
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 18),
              GridView.builder(
                itemCount: channels.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  final channel = channels[index];
                  return _buildChannelCard(
                    index: index,
                    name: channel.name,
                    room: channel.room,
                    devices: channel.devicesLabel,
                    isOn: channel.isOn,
                    onToggle: () => channelStore.toggleChannelPower(index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildChannelCard({
    required int index,
    required String name,
    required String room,
    required String devices,
    required bool isOn,
    required VoidCallback onToggle,
  }) {
    return GestureDetector(
      onLongPress: _showChannelActions,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.square_rounded, color: Color(0xFF8385B2), size: 24),
                const Spacer(),
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: isOn ? const Color(0xFF8ED48F) : const Color(0xFFA8A8A8),
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      Icons.power_settings_new,
                      color: isOn ? const Color(0xFF8ED48F) : const Color(0xFFA8A8A8),
                      size: 38,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF6E73AF),
                fontSize: 24 / 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              room,
              style: const TextStyle(color: Color(0xFF9B9B9B), fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              devices,
              style: const TextStyle(color: Color(0xFFE39C5A), fontSize: 16),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                if (index == 0) {
                  Navigator.pushNamed(context, '/channel-home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$name details coming soon")),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF9AA0F2), width: 2),
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Manage",
                    style: TextStyle(
                      color: Color(0xFF8C92E9),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.settings, color: Color(0xFF8C92E9), size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
