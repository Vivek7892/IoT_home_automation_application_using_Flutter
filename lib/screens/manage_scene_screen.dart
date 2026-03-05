import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/app_store.dart';

class ManageSceneScreen extends StatefulWidget {
  const ManageSceneScreen({super.key});
  @override
  State<ManageSceneScreen> createState() => _ManageSceneScreenState();
}

class _ManageSceneScreenState extends State<ManageSceneScreen> {
  final _store = AppStore.instance;
  int _tabIndex = 0; // 0=Manual, 1=Timer, 2=Schedule
  final _nameCtrl = TextEditingController();
  String? _selectedTime;
  int _selectedChannelIdx = 0;
  final Map<String, Map<String, Map<int, bool>>> _deviceSelections = {};
  bool _scheduleByTime = true;
  bool _sunriseToSunset = false;
  bool _sunsetToSunrise = false;
  final List<bool> _selectedDays = List.filled(7, false);
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 12, minute: 0);

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sceneName = ModalRoute.of(context)?.settings.arguments as String?;
    if (sceneName != null && _nameCtrl.text.isEmpty) {
      _nameCtrl.text = sceneName;
    }
    final channels = _store.channels.value;
    final allDevices = _store.allDevices;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ── AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryDark, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.nightlight_round, color: AppColors.primaryDark, size: 20),
                          SizedBox(width: 6),
                          Text('Manage Scene', style: TextStyle(color: AppColors.primaryDark, fontSize: 18, fontWeight: FontWeight.w700)),
                        ]),
                      ),
                      IconButton(
                        icon: const Icon(Icons.access_time, color: AppColors.primaryDark, size: 24),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Summary card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.primaryMid,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text('Good Morning!', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                                SizedBox(height: 4),
                                Text('Nitin', style: TextStyle(color: Colors.white, fontSize: 13)),
                              ])),
                              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                const Text('Total Devices', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text('${allDevices.length}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Scene title
                        Row(children: [
                          const Icon(Icons.power, color: AppColors.primaryDark, size: 18),
                          const SizedBox(width: 6),
                          Text(_nameCtrl.text.isEmpty ? 'New Scene' : '${_nameCtrl.text} Scene',
                              style: const TextStyle(color: AppColors.primaryDark, fontSize: 16, fontWeight: FontWeight.w700)),
                        ]),
                        const SizedBox(height: 4),
                        const Text('You can start the scene manually, or by scheduling it at a specific time or setting up a timer. Choose your options',
                            style: TextStyle(color: AppColors.textLight, fontSize: 12, fontStyle: FontStyle.italic, height: 1.4)),
                        const SizedBox(height: 16),

                        // ── Tab bar
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFECEBFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              _tabBtn('Manual', 0),
                              _tabBtn('Timer', 1),
                              _tabBtn('Schedule', 2),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── Tab content
                        if (_tabIndex == 0) _manualTab()
                        else if (_tabIndex == 1) _timerTab()
                        else _scheduleTab(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // ── Bottom nav
            Positioned(
              left: 16, right: 16, bottom: 14,
              child: Row(children: [
                _navBtn(Icons.home, AppColors.primaryDark, () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false)),
                const Spacer(),
                _navBtn(Icons.add, AppColors.red, () {}),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBtn(String label, int idx) {
    final isSelected = _tabIndex == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tabIndex = idx),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(label, textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? AppColors.primaryDark : AppColors.textLight,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              )),
        ),
      ),
    );
  }

  Widget _manualTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'This is a default setting of the scene, you can anytime switch on/off your devices as per your scene from the Dashboard or My Scenes page.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textLight, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('View devices & channel in this scene',
                  style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w500)),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: AppColors.primary, size: 16),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildDeviceSelector(),
        const SizedBox(height: 20),
        GradientButton(text: 'Save', onPressed: _saveScene),
      ],
    );
  }

  Widget _timerTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You can choose the time for the scene to be active by setting the time below.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textLight, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('View devices & channel in this scene', style: TextStyle(color: AppColors.primary, fontSize: 13)),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: AppColors.primary, size: 16),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text('Set Time: ${_selectedTime ?? 'Not set'}',
              style: const TextStyle(color: AppColors.primaryDark, fontSize: 15, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: _showTimePicker,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            minimumSize: const Size(double.infinity, 44),
          ),
          child: Text(_selectedTime == null ? 'Choose Time' : 'Change Time',
              style: const TextStyle(color: AppColors.primary, fontSize: 14)),
        ),
        const SizedBox(height: 24),
        GradientButton(text: 'Save', onPressed: _saveScene),
      ],
    );
  }

  Widget _scheduleTab() {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The devices would switch on/off when selected from the Dashboard or My Scenes page for the time set below.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textLight, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('View devices & channel in this scene', style: TextStyle(color: AppColors.primary, fontSize: 13)),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: AppColors.primary, size: 16),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('Schedule the scene based on:', style: TextStyle(color: AppColors.primaryDark, fontSize: 14, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),

        // ── Time option
        Row(children: [
          Radio<bool>(value: true, groupValue: _scheduleByTime, onChanged: (v) => setState(() => _scheduleByTime = true), activeColor: AppColors.primary),
          const Text('Time', style: TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w600)),
        ]),
        if (_scheduleByTime) ...[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  GestureDetector(
                    onTap: () async {
                      final t = await showTimePicker(context: context, initialTime: _startTime);
                      if (t != null) setState(() => _startTime = t);
                    },
                    child: Text('${_startTime.format(context)}', style: const TextStyle(color: AppColors.primaryDark, fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                  const Text(' to ', style: TextStyle(color: AppColors.textLight, fontSize: 13)),
                  GestureDetector(
                    onTap: () async {
                      final t = await showTimePicker(context: context, initialTime: _endTime);
                      if (t != null) setState(() => _endTime = t);
                    },
                    child: Text('${_endTime.format(context)}', style: const TextStyle(color: AppColors.primaryDark, fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                    child: const Text('Repeat daily', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(width: 8),
                  ...List.generate(7, (i) => GestureDetector(
                    onTap: () => setState(() => _selectedDays[i] = !_selectedDays[i]),
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 26, height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedDays[i] ? AppColors.primary : const Color(0xFFECEBFF),
                      ),
                      child: Center(child: Text(days[i], style: TextStyle(
                        color: _selectedDays[i] ? Colors.white : AppColors.primaryMid, fontSize: 11, fontWeight: FontWeight.w600))),
                    ),
                  )),
                ]),
              ],
            ),
          ),
        ],
        const SizedBox(height: 14),

        // ── Day/Night option
        Row(children: [
          Radio<bool>(value: false, groupValue: _scheduleByTime, onChanged: (v) => setState(() => _scheduleByTime = false), activeColor: AppColors.primary),
          const Text('Day/Night', style: TextStyle(color: AppColors.primaryDark, fontSize: 14, fontWeight: FontWeight.w600)),
        ]),
        if (!_scheduleByTime) ...[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              children: [
                RadioListTile<bool>(
                  value: true, groupValue: _sunriseToSunset,
                  onChanged: (v) => setState(() => _sunriseToSunset = true),
                  title: const Text('Sun Rise to Sun Set', style: TextStyle(color: AppColors.primary, fontSize: 13)),
                  activeColor: AppColors.primary, dense: true, contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<bool>(
                  value: false, groupValue: _sunriseToSunset,
                  onChanged: (v) => setState(() => _sunriseToSunset = false),
                  title: const Text('Sun Set to Sun Rise', style: TextStyle(color: AppColors.primary, fontSize: 13)),
                  activeColor: AppColors.primary, dense: true, contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(border: Border.all(color: AppColors.lightGrey), borderRadius: BorderRadius.circular(8)),
                    child: const Text('Repeat daily', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ),
                  const SizedBox(width: 8),
                  ...List.generate(7, (i) => Container(
                    margin: const EdgeInsets.only(right: 4),
                    width: 26, height: 26,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: i == 0 ? AppColors.primary : const Color(0xFFECEBFF)),
                    child: Center(child: Text(days[i], style: TextStyle(color: i == 0 ? Colors.white : AppColors.primaryMid, fontSize: 11))),
                  )),
                ]),
              ],
            ),
          ),
        ],
        const SizedBox(height: 24),
        GradientButton(text: 'Save', onPressed: _saveScene),
      ],
    );
  }

  Widget _buildDeviceSelector() {
    final channels = _store.channels.value;
    if (channels.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Provide Scene Name', style: TextStyle(color: AppColors.textLight, fontSize: 13)),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(
            child: TextField(
              controller: _nameCtrl,
              style: const TextStyle(color: AppColors.primary, fontSize: 15, fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                hintText: 'Party',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey)),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 1.5)),
            child: const Icon(Icons.celebration, color: AppColors.primary, size: 26),
          ),
        ]),
        const SizedBox(height: 16),

        const Text('Choose Channel', style: TextStyle(color: AppColors.textLight, fontSize: 13)),
        const SizedBox(height: 6),
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: _selectedChannelIdx.clamp(0, channels.length - 1),
            isExpanded: true,
            style: const TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w600),
            items: List.generate(channels.length, (i) => DropdownMenuItem(value: i, child: Text(channels[i].name))),
            onChanged: (v) => setState(() => _selectedChannelIdx = v!),
          ),
        ),
        const Divider(color: AppColors.lightGrey),
        const SizedBox(height: 12),

        const Text('Choose devices which you want to be part of this scene and select their on/off state.',
            style: TextStyle(color: AppColors.textLight, fontSize: 12, fontStyle: FontStyle.italic)),
        const SizedBox(height: 12),

        // ── Channel devices
        ...channels.asMap().entries.map((e) => _channelDevicesSection(e.value, e.key)),
      ],
    );
  }

  Widget _channelDevicesSection(ChannelItem ch, int chIdx) {
    final isExpanded = _selectedChannelIdx == chIdx;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFECEBFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isExpanded ? AppColors.primary : Colors.transparent, width: 1.5),
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: const Icon(Icons.grid_view_rounded, color: AppColors.primaryMid, size: 18),
            title: Text(ch.name, style: const TextStyle(color: AppColors.primaryMid, fontSize: 14, fontWeight: FontWeight.w600)),
            trailing: Icon(isExpanded ? Icons.keyboard_arrow_down : Icons.chevron_right, color: AppColors.primaryMid),
            onTap: () => setState(() => _selectedChannelIdx = isExpanded ? -1 : chIdx),
          ),
          if (isExpanded)
            ...ch.devices.asMap().entries.map((e) => _deviceToggleRow(e.value, chIdx, e.key)),
        ],
      ),
    );
  }

  Widget _deviceToggleRow(DeviceItem d, int chIdx, int dIdx) {
    final key = '${_store.channels.value[chIdx].name}_$dIdx';
    final isSelected = _deviceSelections[key]?['selected']?[0] ?? false;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            leading: Icon(d.icon, color: AppColors.primaryMid, size: 18),
            title: Row(children: [
              Text(d.name, style: const TextStyle(color: AppColors.primaryMid, fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              PlugTag(d.plug),
            ]),
            trailing: Switch(
              value: isSelected,
              onChanged: (v) => setState(() {
                _deviceSelections[key] = {'selected': {0: v}};
              }),
              activeColor: AppColors.primary,
            ),
          ),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Device selected, this device will play a role in this scene.',
                      style: TextStyle(color: AppColors.green, fontSize: 11, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          const Text('On during scene is running', style: TextStyle(color: AppColors.textLight, fontSize: 11)),
                          const SizedBox(height: 6),
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, border: Border.all(color: AppColors.green, width: 2),
                            ),
                            child: const Icon(Icons.power_settings_new, color: AppColors.green, size: 22),
                          ),
                        ]),
                      ),
                      Container(width: 1, height: 50, color: AppColors.lightGrey),
                      Expanded(
                        child: Column(children: [
                          const Text('Off after scene is completed', style: TextStyle(color: AppColors.textLight, fontSize: 11)),
                          const SizedBox(height: 6),
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, border: Border.all(color: AppColors.red, width: 2),
                            ),
                            child: const Icon(Icons.power_settings_new, color: AppColors.red, size: 22),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Text('Device not selected, this device will not play any role in this scene.',
                  style: TextStyle(color: AppColors.textLight, fontSize: 11, fontStyle: FontStyle.italic)),
            ),
        ],
      ),
    );
  }

  void _showTimePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
            child: Row(children: [
              const Text('Choose Time', style: TextStyle(color: AppColors.primaryDark, fontSize: 16, fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close, color: AppColors.red), onPressed: () => Navigator.pop(context)),
            ]),
          ),
          ...['1 Min', '5 Min', '10 Min', '15 Min', 'Manual'].map((t) => ListTile(
            title: Text(t, style: const TextStyle(color: AppColors.primaryDark, fontSize: 14)),
            onTap: () { setState(() => _selectedTime = t); Navigator.pop(context); },
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _saveScene() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide a scene name')));
      return;
    }
    final list = List<SceneItem>.from(_store.scenes.value);
    final existingIdx = list.indexWhere((s) => s.name.toLowerCase() == name.toLowerCase());
    if (existingIdx == -1) {
      list.add(SceneItem(name: name, deviceCount: _store.allDevices.length, isOn: false));
      _store.scenes.value = list;
    }
    Navigator.pop(context);
  }

  Widget _navBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48, height: 48,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}
