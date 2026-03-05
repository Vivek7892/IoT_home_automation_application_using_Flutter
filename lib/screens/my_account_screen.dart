import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});
  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _oldPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _rePassCtrl = TextEditingController();
  bool _showOld = false;
  bool _showNew = false;
  bool _showRe = false;

  @override
  void dispose() {
    _oldPassCtrl.dispose();
    _newPassCtrl.dispose();
    _rePassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
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
                    child: Text('My Account', textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.primaryDark, fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Avatar
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: AppColors.primary.withOpacity(0.15),
                            child: const Text('A', style: TextStyle(color: AppColors.primary, fontSize: 38, fontWeight: FontWeight.w700)),
                          ),
                          Positioned(
                            bottom: 2, right: 2,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                              child: const Icon(Icons.edit, size: 16, color: AppColors.primaryMid),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text('Aditya Raniwala', style: TextStyle(color: AppColors.primaryDark, fontSize: 18, fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline)),
                        SizedBox(width: 6),
                        Icon(Icons.edit, size: 16, color: AppColors.primaryMid),
                      ]),
                    ),
                    const SizedBox(height: 28),

                    // ── Personal Info section
                    const Text('Personal Information',
                        style: TextStyle(color: AppColors.primaryDark, fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 4)],
                      ),
                      child: Column(children: [
                        _infoRow('Age', '18 Yrs.'),
                        const Divider(height: 1),
                        _infoRow('Email Id', 'adityasoni9727@gmail.com'),
                        const Divider(height: 1),
                        _infoRow('Gender', 'Male'),
                      ]),
                    ),
                    const SizedBox(height: 28),

                    // ── Password change
                    const Text('Change Password',
                        style: TextStyle(color: AppColors.primaryDark, fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 14),

                    _passField('Enter Old Password', _oldPassCtrl, _showOld, () => setState(() => _showOld = !_showOld)),
                    const SizedBox(height: 16),
                    _passField('Enter New Password', _newPassCtrl, _showNew, () => setState(() => _showNew = !_showNew)),
                    const SizedBox(height: 4),
                    const Text('Must be at least 8 characters.',
                        style: TextStyle(color: AppColors.textLight, fontSize: 11)),
                    const SizedBox(height: 16),
                    _passField('Re Enter New Password', _rePassCtrl, _showRe, () => setState(() => _showRe = !_showRe)),
                    const SizedBox(height: 28),

                    // ── Buttons
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text('Reset Password', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _showLogoutDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryDark,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text('Logout', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: AppColors.textLight, fontSize: 13)),
          const Spacer(),
          Text(value, style: const TextStyle(color: AppColors.primaryDark, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _passField(String label, TextEditingController ctrl, bool show, VoidCallback toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textLight, fontSize: 14)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          obscureText: !show,
          style: const TextStyle(color: AppColors.primary, fontSize: 14),
          decoration: InputDecoration(
            hintText: 'password@123',
            hintStyle: const TextStyle(color: AppColors.grey),
            suffixIcon: GestureDetector(
              onTap: toggle,
              child: Icon(show ? Icons.visibility_off : Icons.visibility_off_outlined, color: AppColors.grey, size: 20),
            ),
            border: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey)),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 30, height: 30,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.red),
                    child: const Icon(Icons.close, color: Colors.white, size: 16),
                  ),
                ),
              ]),
              const Text('This will log you out of the system',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.primaryDark, fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              GradientButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                },
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
