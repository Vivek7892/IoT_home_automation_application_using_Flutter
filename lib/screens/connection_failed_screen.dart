import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ConnectionFailedScreen extends StatelessWidget {
  const ConnectionFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final channelName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Migro_CH1';
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
              child: Column(
                children: [
                  Text(channelName,
                      style: const TextStyle(color: AppColors.primaryDark, fontSize: 20, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  const Icon(Icons.electrical_services, color: AppColors.grey, size: 100),
                  const SizedBox(height: 28),
                  Container(
                    width: 64, height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.red, width: 2.5),
                    ),
                    child: const Icon(Icons.block, color: AppColors.red, size: 36),
                  ),
                  const SizedBox(height: 16),
                  const Text('Channel Not Connected!',
                      style: TextStyle(color: AppColors.primaryDark, fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  const Text('Not Enabled, Please Try Again.',
                      style: TextStyle(color: AppColors.textLight, fontSize: 14)),
                  const SizedBox(height: 32),
                  OutlinedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/add-channel-qr'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      minimumSize: const Size(180, 50),
                    ),
                    child: const Text('Try Again',
                        style: TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              left: 16, right: 16, bottom: 14,
              child: Row(children: [
                const Spacer(),
                _navBtn(Icons.nightlight_round, AppColors.primaryDark, () {}),
                const SizedBox(width: 10),
                _navBtn(Icons.grid_view_rounded, AppColors.primaryDark, () {}),
                const SizedBox(width: 10),
                _navBtn(Icons.view_in_ar, AppColors.primaryDark, () {}),
                const SizedBox(width: 10),
                _navBtn(Icons.people_outline, AppColors.primaryDark, () {}),
                const SizedBox(width: 10),
                _navBtn(Icons.close, AppColors.red, () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46, height: 46,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
