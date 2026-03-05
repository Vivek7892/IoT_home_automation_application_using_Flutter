import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/app_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _store = AppStore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ValueListenableBuilder<List<ChannelItem>>(
          valueListenable: _store.channels,
          builder: (context, channels, _) {
            final allDevices = _store.allDevices;
            final scenes = _store.scenes.value;

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 110),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // ── Top bar
                    Row(children: [
                      const Spacer(),
                      const Text('Home', style: TextStyle(color: AppColors.primaryMid, fontSize: 20, fontWeight: FontWeight.w700)),
                      const Spacer(),
                      const Icon(Icons.notifications_none, color: AppColors.primaryMid, size: 26),
                    ]),
                    const SizedBox(height: 16),
                    // ── Greeting card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(color: AppColors.primaryMid, borderRadius: BorderRadius.circular(18), boxShadow: const [BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 4))]),
                      child: const Row(children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Good Morning!', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                          SizedBox(height: 4),
                          Text('Nitin', style: TextStyle(color: Colors.white, fontSize: 14)),
                        ])),
                        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Text('May 30', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                          SizedBox(height: 4),
                          Text('10:30 PM', style: TextStyle(color: Colors.white, fontSize: 14)),
                        ]),
                      ]),
                    ),
                    const SizedBox(height: 24),

                    // ── My Channels section
                    _sectionHeader('My Channels', 'View All Channels', () => Navigator.pushNamed(context, '/my-channels'), icon: Icons.grid_view_rounded),
                    const Text('List of existing channels', style: TextStyle(color: AppColors.textLight, fontSize: 12, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 12),
                    if (channels.isEmpty)
                      _emptyState('There are no channels yet, please add a channel & configure it.', Icons.add_box_outlined,
                          'Add Channels', () => Navigator.pushNamed(context, '/add-channel-qr'))
                    else
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: channels.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (_, i) => _channelChip(channels[i], i),
                        ),
                      ),
                    const SizedBox(height: 24),

                    // ── My Devices section
                    _sectionHeader('My Devices', 'View All Devices', () => Navigator.pushNamed(context, '/my-devices'), icon: Icons.power_outlined),
                    const Text('List of my electronic devices', style: TextStyle(color: AppColors.textLight, fontSize: 12, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 12),
                    if (allDevices.isEmpty)
                      _emptyState('There are No devices added yet, please add a device to the channel.', Icons.devices_other,
                          'Add Devices', () => Navigator.pushNamed(context, '/add-device'))
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.3),
                        itemCount: allDevices.length > 4 ? 4 : allDevices.length,
                        itemBuilder: (_, i) => _deviceCard(allDevices[i], i),
                      ),
                    const SizedBox(height: 24),

                    // ── My Scenes section
                    _sectionHeader('My Scenes', null, null, icon: Icons.nightlight_round),
                    const SizedBox(height: 12),
                    if (scenes.isEmpty)
                      _emptyState('There are no scenes added yet, you can create your custom scene.', Icons.wb_twilight,
                          'Add Scene', () => Navigator.pushNamed(context, '/my-scenes'))
                    else
                      Column(children: [
                        SizedBox(
                          height: 88,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: scenes.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (_, i) => _sceneChip(scenes[i], i),
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => Navigator.pushNamed(context, '/my-scenes'),
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), minimumSize: const Size(double.infinity, 46)),
                          icon: const Icon(Icons.add, color: AppColors.primary, size: 20),
                          label: const Text('Add Scene', style: TextStyle(color: AppColors.primary, fontSize: 14)),
                        ),
                      ]),
                  ]),
                ),
                // ── Bottom nav
                Positioned(
                  left: 16, right: 16, bottom: 14,
                  child: Row(children: [
                    _navBtn(Icons.nightlight_round, AppColors.primaryDark, () => Navigator.pushNamed(context, '/my-scenes')),
                    const SizedBox(width: 10),
                    _navBtn(Icons.grid_view_rounded, AppColors.primaryDark, () => Navigator.pushNamed(context, '/my-channels')),
                    const SizedBox(width: 10),
                    _navBtn(Icons.power_outlined, AppColors.primaryDark, () => Navigator.pushNamed(context, '/my-devices')),
                    const SizedBox(width: 10),
                    _navBtn(Icons.people_outline, AppColors.primaryDark, () => Navigator.pushNamed(context, '/users')),
                    const Spacer(),
                    _navBtn(Icons.close, AppColors.red, () => Navigator.pushReplacementNamed(context, '/login')),
                  ]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String? btnLabel, VoidCallback? onBtnTap, {required IconData icon}) {
    return Row(children: [
      Icon(icon, color: AppColors.primaryDark, size: 18),
      const SizedBox(width: 6),
      Text(title, style: const TextStyle(color: AppColors.primaryDark, fontSize: 17, fontWeight: FontWeight.w700)),
      const Spacer(),
      if (btnLabel != null && onBtnTap != null)
        OutlinedButton.icon(
          onPressed: onBtnTap,
          style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.textPurple, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), visualDensity: VisualDensity.compact),
          icon: const Icon(Icons.arrow_forward, color: AppColors.textPurple, size: 14),
          label: Text(btnLabel, style: const TextStyle(color: AppColors.textPurple, fontSize: 11)),
          iconAlignment: IconAlignment.end,
        ),
    ]);
  }

  Widget _channelChip(ChannelItem ch, int idx) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/channel-home'),
      child: Container(
        width: 130,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFFECEBFF), borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.grid_view_rounded, color: AppColors.primaryMid, size: 18),
            const Spacer(),
            PowerButton(isOn: ch.isOn, onTap: () => _store.toggleChannel(idx), size: 32),
          ]),
          const SizedBox(height: 6),
          Text(ch.name, style: const TextStyle(color: AppColors.primaryMid, fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(ch.devicesLabel, style: const TextStyle(color: AppColors.orange, fontSize: 11, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }

  Widget _deviceCard(DeviceItem device, int i) {
    return GestureDetector(
      onTap: () {
        final ci = _store.channels.value.indexWhere((c) => c.name == device.channelName);
        if (ci != -1) {
          final di = _store.channels.value[ci].devices.indexWhere((d) => d.name == device.name && d.plug == device.plug);
          if (di != -1) _store.toggleDevice(device.channelName, di);
        }
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Icon(device.icon, color: AppColors.primaryMid, size: 20),
            const Spacer(),
            PowerButton(isOn: device.isOn, onTap: () {
              final ci = _store.channels.value.indexWhere((c) => c.name == device.channelName);
              if (ci != -1) {
                final di = _store.channels.value[ci].devices.indexWhere((d) => d.name == device.name && d.plug == device.plug);
                if (di != -1) _store.toggleDevice(device.channelName, di);
              }
              setState(() {});
            }, size: 34),
          ]),
          const SizedBox(height: 5),
          Text(device.name, style: const TextStyle(color: AppColors.primaryMid, fontSize: 12, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis, maxLines: 1),
          Text(device.channelName, style: const TextStyle(color: AppColors.textLight, fontSize: 10), overflow: TextOverflow.ellipsis, maxLines: 1),
          const SizedBox(height: 3),
          PlugTag(device.plug),
        ]),
      ),
    );
  }

  Widget _sceneChip(SceneItem scene, int idx) {
    final Color c = scene.isOn ? AppColors.green : AppColors.grey;
    return GestureDetector(
      onTap: () {
        _store.toggleScene(idx);
        setState(() {});
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: scene.isOn ? const Color(0xFFECEBFF) : const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(14)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: c, width: 2)),
              child: Icon(Icons.power_settings_new, color: c, size: 20)),
          const SizedBox(height: 4),
          Text(scene.name, style: const TextStyle(color: AppColors.primaryMid, fontSize: 10, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }

  Widget _emptyState(String text, IconData icon, String btnLabel, VoidCallback onTap) {
    return Column(children: [
      const SizedBox(height: 8),
      Text(text, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textLight, fontSize: 13, height: 1.4)),
      const SizedBox(height: 12),
      OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), minimumSize: const Size(180, 44)),
        icon: const Icon(Icons.add, color: AppColors.primary, size: 18),
        label: Text(btnLabel, style: const TextStyle(color: AppColors.primary, fontSize: 14)),
      ),
      const SizedBox(height: 8),
    ]);
  }

  Widget _navBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(width: 46, height: 46, decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 22)),
    );
  }
}
