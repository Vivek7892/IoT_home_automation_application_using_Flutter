import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AddChannelWifiScreen extends StatefulWidget {
  const AddChannelWifiScreen({super.key});
  @override
  State<AddChannelWifiScreen> createState() => _AddChannelWifiScreenState();
}

class _AddChannelWifiScreenState extends State<AddChannelWifiScreen> {
  final _ssidCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _ssidCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final channelName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Migro_CH1';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ── App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryDark, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text('Add Channel', textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.primaryDark, fontSize: 18, fontWeight: FontWeight.w700)),
                      ),
                      TextButton(
                        onPressed: _onNext,
                        child: const Text('Next', style: TextStyle(color: AppColors.primaryDark, fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 4, 22, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Follow our simple steps to configure the channel',
                          style: TextStyle(color: AppColors.primary, fontSize: 13, fontStyle: FontStyle.italic, height: 1.4),
                        ),
                        const SizedBox(height: 18),
                        _step('Step 1', 'Turn Off your smartphone internet data.'),
                        _step('Step 2', 'Go to WiFi settings of your smart phone.'),
                        _step('Step 3', 'Start scanning for available WiFi networks.'),
                        _step('Step 4', 'Find Migro Switch in the WiFi networks list.'),
                        _step('Step 5', 'Connect to Migro Switch.'),
                        _step('Step 6', 'Once connected, come back to the app.'),
                        _step('Step 7', 'Provide SSID and Password of your home WiFi.'),
                        const SizedBox(height: 24),

                        const Text('Enter SSID',
                            style: TextStyle(color: AppColors.textLight, fontSize: 15, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _ssidCtrl,
                          style: const TextStyle(color: AppColors.textLight, fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'MY_Home_WiFi',
                            hintStyle: TextStyle(color: AppColors.grey),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey)),
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                        const SizedBox(height: 20),

                        const Text('Enter Password',
                            style: TextStyle(color: AppColors.textLight, fontSize: 15, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _passCtrl,
                          obscureText: true,
                          style: const TextStyle(color: AppColors.textLight, fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'MY_Home_WiFi_Password',
                            hintStyle: TextStyle(color: AppColors.grey),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey)),
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 16, right: 16, bottom: 14,
              child: Row(children: [
                _navBtn(Icons.home, AppColors.primaryDark, () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false)),
                const SizedBox(width: 10),
                _navBtn(Icons.nightlight_round, AppColors.primaryDark, () {}),
                const SizedBox(width: 10),
                _navBtn(Icons.grid_view_rounded, AppColors.primaryDark, () {}),
                const SizedBox(width: 10),
                _navBtn(Icons.view_in_ar, AppColors.primaryDark, () {}),
                const SizedBox(width: 10),
                _navBtn(Icons.people_outline, AppColors.primaryDark, () {}),
                const Spacer(),
                _navBtn(Icons.close, AppColors.red, () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _step(String num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: AppColors.textLight, fontSize: 13, height: 1.4),
          children: [
            TextSpan(text: '$num: ', style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
            TextSpan(text: text),
          ],
        ),
      ),
    );
  }

  void _onNext() {
    final channelName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Migro_CH1';
    Navigator.pushNamed(context, '/connecting', arguments: channelName);
  }

  Widget _navBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
