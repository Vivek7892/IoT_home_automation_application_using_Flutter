import 'package:flutter/material.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),

        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F2F2),
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFF484B9A)),
          title: const Text(
            "Create New Password",
            style: TextStyle(
              color: Color(0xFF484B9A),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              MediaQuery.of(context).viewInsets.bottom + 20,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your new password must be different from previously used passwords.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                /// PASSWORD
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    hintText: "password@123",
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFF484B9A),
                      ),
                      onPressed: () {
                        setState(() => obscurePassword = !obscurePassword);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// CONFIRM PASSWORD
                const Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),

                TextField(
                  controller: confirmController,
                  obscureText: obscureConfirm,
                  decoration: InputDecoration(
                    hintText: "password@123",
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFF484B9A),
                      ),
                      onPressed: () {
                        setState(() => obscureConfirm = !obscureConfirm);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                /// RESET BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      if (passwordController.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password must be 8 characters"),
                          ),
                        );
                        return;
                      }

                      if (passwordController.text != confirmController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Passwords do not match"),
                          ),
                        );
                        return;
                      }

                      /// SUCCESS → GO BACK TO LOGIN
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6A75F2), Color(0xFFE46BBE)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset("assets/bulb.png", width: 200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
