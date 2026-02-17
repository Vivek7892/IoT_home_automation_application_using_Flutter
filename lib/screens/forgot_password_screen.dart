import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        resizeToAvoidBottomInset: true,

        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              24,
              20,
              24,
              MediaQuery.of(context).viewInsets.bottom + 20,
            ),

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// BACK BUTTON
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),

                  const SizedBox(height: 10),

                  /// TITLE
                  const Center(
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B4FA3),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// DESCRIPTION
                  const Text(
                    "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  /// EMAIL LABEL
                  const Text("Email", style: TextStyle(color: Colors.grey)),

                  const SizedBox(height: 8),

                  /// EMAIL FIELD (WITH VALIDATION)
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }

                      // simple email validation
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },

                    decoration: const InputDecoration(
                      hintText: "example@gmail.com",
                      border: UnderlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// CONTINUE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B6EE6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        // validate email first
                        if (_formKey.currentState!.validate()) {
                          // go to Check Email Screen
                          Navigator.pushReplacementNamed(
                            context,
                            '/check-email',
                          );
                        }
                      },

                      child: const Text(
                        "Continue",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  /// BOTTOM IMAGE
                  Center(child: Image.asset("assets/bulb.png", height: 180)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
