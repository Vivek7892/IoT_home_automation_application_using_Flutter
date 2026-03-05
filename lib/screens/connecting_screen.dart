import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/app_store.dart';

class ConnectingScreen extends StatefulWidget {
  const ConnectingScreen({super.key});
  @override
  State<ConnectingScreen> createState() => _ConnectingScreenState();
}

class _ConnectingScreenState extends State<ConnectingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _prog;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..addListener(() => setState(() {}))
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed && mounted) {
          final channelName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Migro_CH1';
          // Add the channel to store
          AppStore.instance.addChannel(channelName);
          // Randomly succeed or fail (always succeed here for better UX)
          Navigator.pushReplacementNamed(context, '/connection-success', arguments: channelName);
        }
      });
    _prog = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final channelName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Migro_CH1';
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.electrical_services, color: AppColors.primaryMid, size: 90),
              const SizedBox(height: 36),
              Text(channelName,
                  style: const TextStyle(color: AppColors.primaryDark, fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              const Text('Connecting to Device.',
                  style: TextStyle(color: AppColors.primaryDark, fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text('Attempting to connect, please wait.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textLight, fontSize: 14)),
              const SizedBox(height: 32),
              LinearProgressIndicator(
                value: _prog.value,
                backgroundColor: AppColors.lightGrey,
                color: AppColors.primary,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 12),
              Text('${(_prog.value * 100).toInt()}%',
                  style: const TextStyle(color: AppColors.primaryMid, fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
