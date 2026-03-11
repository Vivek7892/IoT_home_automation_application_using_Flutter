import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants/app_constants.dart';
import '../models/app_store.dart';
import 'qr_scanner_screen.dart';

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
class ChannelSetupData {
  final String channelName;
  final String ssid;
  final String password;
  final bool rememberWifi;
  final String moduleBaseUrl;
  final String? moduleId;
  final String? qrPayload;

  const ChannelSetupData({
    required this.channelName,
    required this.ssid,
    required this.password,
    required this.rememberWifi,
    required this.moduleBaseUrl,
    this.moduleId,
    this.qrPayload,
  });

  factory ChannelSetupData.initial() {
    return const ChannelSetupData(
      channelName: 'Migro_CH1',
      ssid: '',
      password: '',
      rememberWifi: true,
      moduleBaseUrl: 'http://192.168.4.1',
    );
  }

  ChannelSetupData copyWith({
    String? channelName,
    String? ssid,
    String? password,
    bool? rememberWifi,
    String? moduleBaseUrl,
    String? moduleId,
    String? qrPayload,
  }) {
    return ChannelSetupData(
      channelName: channelName ?? this.channelName,
      ssid: ssid ?? this.ssid,
      password: password ?? this.password,
      rememberWifi: rememberWifi ?? this.rememberWifi,
      moduleBaseUrl: moduleBaseUrl ?? this.moduleBaseUrl,
      moduleId: moduleId ?? this.moduleId,
      qrPayload: qrPayload ?? this.qrPayload,
    );
  }

  static ChannelSetupData fromRouteArgs(Object? args) {
    if (args is ChannelSetupData) return args;
    if (args is String && args.trim().isNotEmpty) {
      return ChannelSetupData.initial().copyWith(channelName: args.trim());
    }
    if (args is Map<String, dynamic>) {
      return ChannelSetupData.initial().copyWith(
        channelName: (args['channelName'] as String?)?.trim(),
        ssid: (args['ssid'] as String?)?.trim(),
        password: args['password'] as String?,
        rememberWifi: args['rememberWifi'] as bool?,
        moduleBaseUrl: (args['moduleBaseUrl'] as String?)?.trim(),
        moduleId: (args['moduleId'] as String?)?.trim(),
      );
    }
    return ChannelSetupData.initial();
  }

  static ChannelSetupData fromQrPayload(String payload, ChannelSetupData current) {
    final raw = payload.trim();
    if (raw.isEmpty) return current;
    final next = current.copyWith(qrPayload: raw);

    try {
      if (raw.startsWith('{') && raw.endsWith('}')) {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          final channelName = (decoded['channelName'] ?? decoded['channel']) as String?;
          final moduleId = (decoded['moduleId'] ?? decoded['id']) as String?;
          final baseUrl = (decoded['baseUrl'] ?? decoded['url'] ?? decoded['ip']) as String?;
          return next.copyWith(
            channelName: channelName?.trim().isNotEmpty == true ? channelName!.trim() : null,
            moduleId: moduleId?.trim(),
            moduleBaseUrl: _normalizeModuleUrl(baseUrl),
          );
        }
      }
    } catch (_) {
      // Continue with fallback parsing.
    }

    final uri = Uri.tryParse(raw);
    if (uri != null && uri.hasScheme && uri.host.isNotEmpty) {
      final qp = uri.queryParameters;
      return next.copyWith(
        channelName: (qp['channel'] ?? qp['channelName'])?.trim().isNotEmpty == true
            ? (qp['channel'] ?? qp['channelName'])!.trim()
            : null,
        moduleId: (qp['module'] ?? qp['moduleId'])?.trim(),
        moduleBaseUrl: _normalizeModuleUrl('${uri.scheme}://${uri.host}:${uri.port}'),
      );
    }

    if (RegExp(r'^\\d{1,3}(\\.\\d{1,3}){3}$').hasMatch(raw)) {
      return next.copyWith(moduleBaseUrl: _normalizeModuleUrl(raw));
    }

    if (raw.toLowerCase().startsWith('migro_')) {
      return next.copyWith(channelName: raw);
    }

    return next.copyWith(moduleId: raw);
  }

  static String _normalizeModuleUrl(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'http://192.168.4.1';
    if (v.startsWith('http://') || v.startsWith('https://')) {
      return v.endsWith('/') ? v.substring(0, v.length - 1) : v;
    }
    return 'http://${v.endsWith('/') ? v.substring(0, v.length - 1) : v}';
  }
}

class AddChannelQRScreen extends StatefulWidget {
  const AddChannelQRScreen({super.key});
  @override
  State<AddChannelQRScreen> createState() => _AddChannelQRScreenState();
}

class _AddChannelQRScreenState extends State<AddChannelQRScreen> {
  bool _rememberWifi = true;
  final _nameCtrl = TextEditingController(text: 'Migro_CH1');
  ChannelSetupData _setup = ChannelSetupData.initial();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _setup = ChannelSetupData.fromRouteArgs(ModalRoute.of(context)?.settings.arguments);
    _rememberWifi = _setup.rememberWifi;
    _nameCtrl.text = _setup.channelName;
    _initialized = true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _scanQrCode() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is required to scan QR code.')),
      );
      if (status.isPermanentlyDenied) {
        await openAppSettings();
      }
      return;
    }

    if (!mounted) return;
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QRScannerScreen()),
    );
    if (!mounted || result == null || result.trim().isEmpty) return;
    setState(() {
      _setup = ChannelSetupData.fromQrPayload(result, _setup);
      _nameCtrl.text = _setup.channelName;
    });
  }

  void _onNext() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter channel name.')),
      );
      return;
    }
    Navigator.pushNamed(
      context,
      '/connecting',
      arguments: _setup.copyWith(
        channelName: name,
        rememberWifi: _rememberWifi,
      ),
    );
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
        actions: [TextButton(onPressed: _onNext, child: const Text('Next', style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w600)))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          const SizedBox(height: 20),
          // Device plug image placeholder
          Container(height: 180, width: 180, decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.electrical_services, size: 80, color: Color(0xFF888888))),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: _scanQrCode,
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
  final _ssidCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  ChannelSetupData _setup = ChannelSetupData.initial();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _setup = ChannelSetupData.fromRouteArgs(ModalRoute.of(context)?.settings.arguments);
    _ssidCtrl.text = _setup.ssid;
    _passCtrl.text = _setup.password;
    _initialized = true;
  }

  @override
  void dispose() { _ssidCtrl.dispose(); _passCtrl.dispose(); super.dispose(); }

  void _next() {
    final ssid = _ssidCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (ssid.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter WiFi SSID and Password')));
      return;
    }
    Navigator.pushNamed(
      context,
      '/scan-channel-qr',
      arguments: _setup.copyWith(
        ssid: ssid,
        password: pass,
      ),
    );
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
          TextField(controller: _ssidCtrl, decoration: const InputDecoration(hintText: 'MY_Home_WiFi', enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))))),
          const SizedBox(height: 20),
          const Text('Enter Password', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF666666))),
          TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(hintText: 'MY_Home_WiFi_Password', enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCCCCC))))),
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
  Timer? _progressTimer;
  double _progress = 0.1;
  String _statusText = 'Attempting to connect, please wait.';
  ChannelSetupData _setup = ChannelSetupData.initial();
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _started) return;
      _started = true;
      _setup = ChannelSetupData.fromRouteArgs(ModalRoute.of(context)?.settings.arguments);
      _startProvisioning();
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _startProvisioning() async {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 320), (_) {
      if (!mounted) return;
      setState(() {
        _progress = (_progress + 0.05).clamp(0.1, 0.9);
      });
    });

    setState(() {
      _statusText = 'Sending WiFi credentials to module...';
    });

    final result = await _Esp32ProvisioningService().provision(_setup);
    if (!mounted) return;

    _progressTimer?.cancel();
    setState(() {
      _progress = 1;
      _statusText = result.message;
    });

    await Future.delayed(const Duration(milliseconds: 450));
    if (!mounted) return;

    if (result.success) {
      AppStore.instance.addChannel(_setup.channelName);
      Navigator.pushReplacementNamed(context, '/connection-success', arguments: _setup.channelName);
    } else {
      Navigator.pushReplacementNamed(context, '/connection-failed', arguments: _setup.channelName);
    }
  }

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
          Text(_statusText, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textLight, fontSize: 15)),
          const SizedBox(height: 18),
          SizedBox(
            width: 220,
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 6,
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primary,
              backgroundColor: AppColors.lightGrey,
            ),
          ),
        ]),
      ),
    );
  }
}

// ─── Connection Success Screen ────────────────────────────────────────────────
class _Esp32ProvisioningService {
  Future<_ProvisionResult> provision(ChannelSetupData setup) async {
    final baseUrl = _normalizeBaseUrl(setup.moduleBaseUrl);
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 4);
    try {
      final reachable = await _isReachable(client, baseUrl);
      if (!reachable) {
        return const _ProvisionResult(
          false,
          'Module not reachable. Connect phone WiFi to ESP32 AP and retry.',
        );
      }

      final payload = <String, dynamic>{
        'channelName': setup.channelName,
        'ssid': setup.ssid,
        'password': setup.password,
        'rememberWifi': setup.rememberWifi,
        if (setup.moduleId != null && setup.moduleId!.trim().isNotEmpty) 'moduleId': setup.moduleId!.trim(),
      };

      const endpoints = ['/provision', '/configure', '/wifi', '/connect', '/setup'];
      for (final endpoint in endpoints) {
        final ok = await _postJson(client, '$baseUrl$endpoint', payload);
        if (ok) {
          return const _ProvisionResult(true, 'Channel connected successfully.');
        }
      }

      final queryOk = await _get(
        client,
        Uri.parse('$baseUrl/configure').replace(queryParameters: {
          'ssid': setup.ssid,
          'password': setup.password,
          'channelName': setup.channelName,
        }).toString(),
      );
      if (queryOk) {
        return const _ProvisionResult(true, 'Channel connected successfully.');
      }

      return const _ProvisionResult(
        false,
        'Module reachable but provisioning endpoint did not accept credentials.',
      );
    } catch (_) {
      return const _ProvisionResult(
        false,
        'Failed to send data to module. Check ESP32 firmware endpoint configuration.',
      );
    } finally {
      client.close(force: true);
    }
  }

  Future<bool> _isReachable(HttpClient client, String baseUrl) async {
    const endpoints = ['/ping', '/health', '/'];
    for (final endpoint in endpoints) {
      if (await _get(client, '$baseUrl$endpoint')) return true;
    }
    return false;
  }

  Future<bool> _get(HttpClient client, String url) async {
    try {
      final req = await client.getUrl(Uri.parse(url)).timeout(const Duration(seconds: 4));
      final resp = await req.close().timeout(const Duration(seconds: 4));
      await resp.drain();
      return resp.statusCode >= 200 && resp.statusCode < 300;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _postJson(HttpClient client, String url, Map<String, dynamic> payload) async {
    try {
      final req = await client.postUrl(Uri.parse(url)).timeout(const Duration(seconds: 5));
      req.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      req.add(utf8.encode(jsonEncode(payload)));
      final resp = await req.close().timeout(const Duration(seconds: 6));
      await resp.drain();
      return resp.statusCode >= 200 && resp.statusCode < 300;
    } catch (_) {
      return false;
    }
  }

  String _normalizeBaseUrl(String raw) {
    var normalized = raw.trim();
    if (normalized.isEmpty) normalized = 'http://192.168.4.1';
    if (!normalized.startsWith('http://') && !normalized.startsWith('https://')) {
      normalized = 'http://$normalized';
    }
    if (normalized.endsWith('/')) normalized = normalized.substring(0, normalized.length - 1);
    return normalized;
  }
}

class _ProvisionResult {
  final bool success;
  final String message;

  const _ProvisionResult(this.success, this.message);
}

class ConnectionSuccessScreen extends StatelessWidget {
  const ConnectionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final channelName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Migro_CH1';
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
            const Spacer(),
            Text(channelName, style: const TextStyle(color: AppColors.primaryMid, fontSize: 22, fontWeight: FontWeight.w700)),
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
    final channelName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Migro_CH1';
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(channelName, style: const TextStyle(color: AppColors.primaryMid, fontSize: 22, fontWeight: FontWeight.w700)),
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
