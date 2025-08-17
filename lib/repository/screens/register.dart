import 'package:dash/repository/screens/bottomnavigation.dart';
import 'package:dash/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UiHelper.CustomImage(img: "app_image.png"),
            const SizedBox(height: 30),

            // Email Field
            Row(
              children: [
                UiHelper.CustomText(
                  text: "Email",
                  color: Colors.black,
                  fontweight: FontWeight.bold,
                  fontsize: 15,
                ),
              ],
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Enter Email ID",
              ),
            ),
            const SizedBox(height: 20),

            // Password Field
            Row(
              children: [
                UiHelper.CustomText(
                  text: "Password",
                  color: Colors.black,
                  fontweight: FontWeight.bold,
                  fontsize: 15,
                ),
              ],
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter Password",
              ),
            ),

            const SizedBox(height: 70),

            // Register Button
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Enter valid details")),
                  );
                } else {
                  try {
                    setState(() {
                      isLoading = true;
                    });

                    // ✅ CREATE NEW USER
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Registration Successful")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(e.message ?? "Registration failed")),
                    );
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                elevation: 15,
              ),
              child: const Text("Register"),
            ),

            const SizedBox(height: 20),

            // Redirect to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Go back to LoginPage
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
