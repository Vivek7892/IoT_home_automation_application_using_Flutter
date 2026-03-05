import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/app_store.dart';

// ─── Channel Home Screen ──────────────────────────────────────────────────────
class ChannelHomeScreen extends StatefulWidget {
  const ChannelHomeScreen({super.key});
  @override
  State<ChannelHomeScreen> createState() => _ChannelHomeScreenState();
}

class _ChannelHomeScreenState extends State<ChannelHomeScreen> {
  final _store = AppStore.instance;
  final String _channelName = 'Migro_CH1';

  ChannelItem? get _channel {
    final list = _store.channels.value;
    try {
      return list.firstWhere((c) => c.name == _channelName);
    } catch (_) {
      return list.isNotEmpty ? list.first : null;
    }
  }

  void _showAddDeviceDialog() {
    final ctrl = TextEditingController(text: 'Light Bulb');
    String selectedPlug = 'Plug 1';
    showDialog<void>(
      context: context,
      builder: (dCtx) => StatefulBuilder(
        builder: (ctx, setDState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(clipBehavior: Clip.none, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Add Device to Channel', style: TextStyle(color: AppColors.primaryMid, fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                Container(width: 70, height: 70, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primaryMid, width: 2)), child: const Icon(Icons.lightbulb_outline, color: AppColors.primaryMid, size: 36)),
                const SizedBox(height: 16),
                TextField(controller: ctrl, style: const TextStyle(color: AppColors.primaryMid, fontSize: 16), decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.only(bottom: 6), enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)))),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedPlug,
                  style: const TextStyle(color: AppColors.primaryMid, fontSize: 16),
                  decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.only(bottom: 6), enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary))),
                  items: const [
                    DropdownMenuItem(value: 'Plug 1', child: Text('Plug 1')),
                    DropdownMenuItem(value: 'Plug 2', child: Text('Plug 2')),
                    DropdownMenuItem(value: 'Plug 3', child: Text('Plug 3')),
                    DropdownMenuItem(value: 'Plug 4', child: Text('Plug 4')),
                  ],
                  onChanged: (v) { if (v != null) setDState(() => selectedPlug = v); },
                ),
                const SizedBox(height: 24),
                GradientButton(
                  text: 'Save',
                  onPressed: () {
                    final name = ctrl.text.trim();
                    if (name.isEmpty) return;
                    _store.addDeviceToChannel(_channelName, DeviceItem(name: name, channelName: _channelName, plug: selectedPlug, icon: Icons.lightbulb_outline, isOn: false));
                    setState(() {});
                    Navigator.pop(dCtx);
                  },
                  height: 52,
                ),
              ]),
            ),
            Positioned(right: -10, top: -10, child: GestureDetector(
              onTap: () => Navigator.pop(dCtx),
              child: Container(width: 36, height: 36, decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle), child: const Icon(Icons.close, color: Colors.white, size: 20)),
            )),
          ]),
        ),
      ),
    );
  }

  void _showManageSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            _act(ctx, 'Add electronic device to this channel'),
            const SizedBox(height: 18),
            _act(ctx, 'Remove all electronic devices from channel'),
            const SizedBox(height: 18),
            _act(ctx, 'Delete the channel'),
            const SizedBox(height: 18),
            _act(ctx, 'Edit channel name'),
            const SizedBox(height: 18),
            GestureDetector(onTap: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: AppColors.textPurple, fontSize: 16))),
          ]),
        ),
      ),
    );
  }

  Widget _act(BuildContext ctx, String label) => GestureDetector(
    onTap: () { Navigator.pop(ctx); },
    child: Text(label, style: const TextStyle(color: AppColors.textPurple, fontSize: 15, fontWeight: FontWeight.w500)),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ChannelItem>>(
      valueListenable: _store.channels,
      builder: (context, channels, _) {
        final ch = _channel;
        final devices = ch?.devices ?? [];

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Stack(children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 110),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.primaryMid), onPressed: () => Navigator.pop(context)),
                    const Icon(Icons.grid_view_rounded, color: AppColors.primaryMid, size: 22),
                    const SizedBox(width: 6),
                    Expanded(child: Text(_channelName, style: const TextStyle(color: AppColors.primaryMid, fontSize: 18, fontWeight: FontWeight.w700))),
                    const Icon(Icons.notifications_none, color: AppColors.primaryMid, size: 24),
                  ]),
                  const SizedBox(height: 14),
                  SummaryCard(rightLabel: 'Total Devices', rightValue: '${devices.length}/${ch?.totalPlugs ?? 4}'),
                  const SizedBox(height: 20),
                  Row(children: [
                    const Icon(Icons.power, color: AppColors.primaryDark, size: 18),
                    const SizedBox(width: 6),
                    const Expanded(child: Text('Devices in Migro_CH 1', style: TextStyle(color: AppColors.primaryDark, fontSize: 16, fontWeight: FontWeight.w700))),
                    OutlinedButton.icon(
                      onPressed: _showAddDeviceDialog,
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.textPurple, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), visualDensity: VisualDensity.compact, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
                      icon: const Icon(Icons.add, color: AppColors.textPurple, size: 16),
                      label: const Text('Add Device', style: TextStyle(color: AppColors.textPurple, fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                  ]),
                  const SizedBox(height: 6),
                  const Text('List of all devices in this channel.\nSlide left to remove device, slide right to edit.', style: TextStyle(color: AppColors.textLight, fontSize: 12, fontStyle: FontStyle.italic, height: 1.4)),
                  if (ch != null && devices.length < ch.totalPlugs) ...[
                    const SizedBox(height: 6),
                    Text('You can add ${ch.totalPlugs - devices.length} more electronic devices in this Channel.', style: const TextStyle(color: AppColors.orange, fontSize: 12)),
                  ],
                  if (ch != null) Text('This channel is setup in: ${ch.room}', style: const TextStyle(color: AppColors.orange, fontSize: 12)),
                  const SizedBox(height: 16),
                  if (devices.isEmpty)
                    Column(children: [
                      const SizedBox(height: 20),
                      const Text('There are no devices in this channel yet, you can add upto 4 devices in this channel.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textLight, fontSize: 14, height: 1.4)),
                      const SizedBox(height: 20),
                      OutlinedButton.icon(
                        onPressed: _showAddDeviceDialog,
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), minimumSize: const Size(180, 46)),
                        icon: const Icon(Icons.add, color: AppColors.primary, size: 18),
                        label: const Text('Add Devices', style: TextStyle(color: AppColors.primary, fontSize: 14)),
                      ),
                    ])
                  else
                    ...devices.asMap().entries.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _DeviceRow(device: e.value, onToggle: () { _store.toggleDevice(_channelName, e.key); setState(() {}); }),
                    )),
                ]),
              ),
              // Bottom nav
              Positioned(left: 16, right: 16, bottom: 14, child: Row(children: [
                _nb(Icons.home, AppColors.primaryDark, () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false)),
                const Spacer(),
                _nb(Icons.add, AppColors.red, _showAddDeviceDialog),
              ])),
              // Manage FAB
              Positioned(top: 12, right: 70, child: TextButton(onPressed: _showManageSheet, child: const Text('Manage', style: TextStyle(color: AppColors.textPurple)))),
            ]),
          ),
        );
      },
    );
  }

  Widget _nb(IconData icon, Color color, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(width: 52, height: 52, decoration: BoxDecoration(color: color, shape: BoxShape.circle), child: Icon(icon, color: Colors.white, size: 26)),
  );
}

class _DeviceRow extends StatelessWidget {
  final DeviceItem device;
  final VoidCallback onToggle;
  const _DeviceRow({required this.device, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 2))]),
      child: Row(children: [
        Icon(device.icon, color: AppColors.primaryMid, size: 26),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(device.name, style: const TextStyle(color: AppColors.primaryMid, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            PlugTag(device.plug),
          ]),
          const SizedBox(height: 4),
          const Text('Tap the button to on/off the device', style: TextStyle(color: AppColors.textLight, fontSize: 11, fontStyle: FontStyle.italic)),
        ])),
        PowerButton(isOn: device.isOn, onTap: onToggle, size: 44),
      ]),
    );
  }
}

// ─── Add Channel QR Screen ────────────────────────────────────────────────────
class AddChannelQRScreen extends StatefulWidget {
  const AddChannelQRScreen({super.key});
  @override
  State<AddChannelQRScreen> createState() => _AddChannelQRScreenState();
}

class _AddChannelQRScreenState extends State<AddChannelQRScreen> {
  bool _rememberWifi = true;
  final _nameCtrl = TextEditingController(text: 'Migro_CH1');

  @override
  void dispose() { _nameCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.primary), onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: const Text('Add Channel', style: TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.w700)),
        actions: [TextButton(onPressed: () => Navigator.pushNamed(context, '/add-channel-wifi', arguments: {'name': _nameCtrl.text.trim(), 'remember': _rememberWifi}), child: const Text('Next', style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w600)))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          const SizedBox(height: 20),
          // Device plug image placeholder
          Container(height: 180, width: 180, decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.electrical_services, size: 80, color: Color(0xFF888888))),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary, width: 1.8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)), minimumSize: const Size(200, 48)),
            child: const Text('Scan QR Code', style: TextStyle(color: AppColors.primary, fontSize: 16)),
          ),
          const SizedBox(height: 20),
          Row(children: const [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('OR', style: TextStyle(color: Color(0xFF888888), fontWeight: FontWeight.w700))), Expanded(child: Divider())]),
          const SizedBox(height: 20),
          const Align(alignment: Alignment.centerLeft, child: Text('Set Channel Name', style: TextStyle(fontSize: 16, color: Color(0xFF888888)))),
          const SizedBox(height: 6),
          TextField(controller: _nameCtrl, decoration: const InputDecoration(hintText: 'Migro_CH1', hintStyle: TextStyle(color: Color(0xFFAAAAAA)), enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)))),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Remember WiFi Settings', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              Text('(Saving WiFi settings will make future device setup much easier)', style: TextStyle(fontSize: 12, color: Color(0xFF888888))),
            ])),
            Switch(value: _rememberWifi, onChanged: (v) => setState(() => _rememberWifi = v), activeColor: AppColors.primary),
          ]),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}

// ─── Add Channel WiFi Screen ──────────────────────────────────────────────────
class AddChannelWifiScreen extends StatefulWidget {
  const AddChannelWifiScreen({super.key});
  @override
  State<AddChannelWifiScreen> createState() => _AddChannelWifiScreenState();
}

class _AddChannelWifiScreenState extends State<AddChannelWifiScreen> {
  final _ssidCtrl = TextEditingController(text: 'MY_Home_WiFI');
  final _passCtrl = TextEditingController(text: 'MY_Home_WiFI_Password');
  late String _channelName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _channelName = args?['name'] as String? ?? 'Migro_CH1';
  }

  @override
  void dispose() { _ssidCtrl.dispose(); _passCtrl.dispose(); super.dispose(); }

  void _next() {
    if (_ssidCtrl.text.trim().isEmpty || _passCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter WiFi SSID and Password')));
      return;
    }
    AppStore.instance.addChannel(_channelName);
    Navigator.pushNamed(context, '/connecting');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.primary), onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: const Text('Add Channel', style: TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.w700)),
        actions: [TextButton(onPressed: _next, child: const Text('Next', style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w600)))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Follow our simple steps to configure the channel', style: TextStyle(color: AppColors.primary, fontSize: 14, fontStyle: FontStyle.italic)),
          const SizedBox(height: 20),
          ...[
            'Step 1: Turn Off your smartphone internet data.',
            'Step 2: Go to WiFi settings of your smart phone.',
            'Step 3: Start scanning for available WiFi networks.',
            'Step 4: Find Migro Switch in the WiFi networks list.',
            'Step 5: Connect to Migro Switch.',
            'Step 6: Once connected, come back to the app.',
            'Step 7: Provide SSID and Password of your home WiFi.',
          ].map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text.rich(TextSpan(children: [
              TextSpan(text: s.substring(0, s.indexOf(':') + 1), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              TextSpan(text: s.substring(s.indexOf(':') + 1), style: const TextStyle(fontSize: 14)),
            ])),
          )),
          const SizedBox(height: 24),
          const Text('Enter SSID', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF666666))),
          TextField(controller: _ssidCtrl, decoration: const InputDecoration(hintText: 'MY_Home_WiFI', enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))))),
          const SizedBox(height: 20),
          const Text('Enter Password', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF666666))),
          TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(hintText: 'MY_Home_WiFI_Password', enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))))),
          const SizedBox(height: 36),
          GradientButton(text: 'Next', onPressed: _next, height: 52),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}

// ─── Connecting Screen ────────────────────────────────────────────────────────
class ConnectingScreen extends StatefulWidget {
  const ConnectingScreen({super.key});
  @override
  State<ConnectingScreen> createState() => _ConnectingScreenState();
}

class _ConnectingScreenState extends State<ConnectingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/connection-success');
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(height: 180, width: 180, decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.electrical_services, size: 80, color: Color(0xFF888888))),
          const SizedBox(height: 40),
          RotationTransition(turns: _ctrl, child: const Icon(Icons.sync, color: AppColors.primary, size: 48)),
          const SizedBox(height: 20),
          const Text('Connecting to Device.', style: TextStyle(color: AppColors.primaryMid, fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          const Text('Attempting to connect, please wait.', style: TextStyle(color: AppColors.textLight, fontSize: 15)),
        ]),
      ),
    );
  }
}

// ─── Connection Success Screen ────────────────────────────────────────────────
class ConnectionSuccessScreen extends StatelessWidget {
  const ConnectionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
            const Spacer(),
            const Text('Migro_CH1', style: TextStyle(color: AppColors.primaryMid, fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 24),
            Container(height: 180, width: 180, decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.electrical_services, size: 80, color: Color(0xFF888888))),
            const SizedBox(height: 32),
            const Icon(Icons.check_circle_outline, color: Color(0xFF5ACB5A), size: 60),
            const SizedBox(height: 16),
            const Text('Channel Connected!', style: TextStyle(color: AppColors.primaryDark, fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Remote Access Enabled', style: TextStyle(color: AppColors.textLight, fontSize: 15)),
            const SizedBox(height: 30),
            OutlinedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary, width: 1.8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)), minimumSize: const Size(240, 50)),
              child: const Text('Done, take me Home', style: TextStyle(color: AppColors.primary, fontSize: 16)),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(onTap: () => Navigator.pushNamed(context, '/add-channel-qr'), child: const Text('+ Add more channels', style: TextStyle(color: AppColors.textPurple, fontSize: 14))),
              const SizedBox(width: 30),
              GestureDetector(onTap: () => Navigator.pushNamed(context, '/add-device'), child: const Text('+ Add devices', style: TextStyle(color: AppColors.textPurple, fontSize: 14))),
            ]),
            const Spacer(),
          ]),
        ]),
      ),
    );
  }
}

// ─── Connection Failed Screen ─────────────────────────────────────────────────
class ConnectionFailedScreen extends StatelessWidget {
  const ConnectionFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Migro_CH1', style: TextStyle(color: AppColors.primaryMid, fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          Container(height: 180, width: 180, decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.electrical_services, size: 80, color: Color(0xFF888888))),
          const SizedBox(height: 32),
          const Icon(Icons.cancel_outlined, color: AppColors.red, size: 60),
          const SizedBox(height: 16),
          const Text('Channel Not Connected!', style: TextStyle(color: AppColors.primaryDark, fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Not Enabled, Please Try Again.', style: TextStyle(color: AppColors.textLight, fontSize: 15)),
          const SizedBox(height: 30),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary, width: 1.8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)), minimumSize: const Size(200, 48)),
            child: const Text('Try Again', style: TextStyle(color: AppColors.primary, fontSize: 16)),
          ),
        ]),
      ),
    );
  }
}
