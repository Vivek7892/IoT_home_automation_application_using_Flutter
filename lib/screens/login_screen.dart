import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool rememberMe = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ---------------- LOGIN FUNCTION ----------------
  void loginUser() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  // ---------------- EMAIL VALIDATOR ----------------
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  // ---------------- PASSWORD VALIDATOR ----------------
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Minimum 6 characters required";
    }
    return null;
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                // TITLE
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF5E60CE),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5E60CE),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // EMAIL FIELD
                const Text("Email", style: TextStyle(color: Colors.grey)),
                TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "email@email.com",
                    enabledBorder: UnderlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 25),

                // PASSWORD FIELD
                const Text("Password", style: TextStyle(color: Colors.grey)),
                TextFormField(
                  controller: passwordController,
                  validator: validatePassword,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    hintText: "******",
                    enabledBorder: const UnderlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => isObscure = !isObscure);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // REMEMBER + FORGOT
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Switch(
                          value: rememberMe,
                          activeColor: const Color(0xFF5E60CE),
                          onChanged: (value) =>
                              setState(() => rememberMe = value),
                        ),
                        const Text("Remember Me"),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6A75F2), Color(0xFFE46BBE)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // SIGNUP
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: "Sign Up here",
                            style: TextStyle(color: Color(0xFF5E60CE)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // BOTTOM IMAGE
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 180,
                    child: Image.asset("assets/bulb.png", fit: BoxFit.contain),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
