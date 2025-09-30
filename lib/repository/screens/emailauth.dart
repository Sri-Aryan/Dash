import 'package:dash/repository/screens/bottomnavigation.dart';
import 'package:dash/repository/screens/register.dart';
import 'package:dash/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth extends StatefulWidget {
  const EmailAuth({super.key});

  @override
  State<EmailAuth> createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  TextEditingController emailid = TextEditingController();
  TextEditingController pass = TextEditingController();

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
            SizedBox(height: 30),
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
              controller: emailid,
              autofillHints: Characters("Enter Email ID "),
            ),
            SizedBox(height: 20),
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
              controller: pass,
              autofillHints: Characters("Enter Password"),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              onPressed: () async {
                String email = emailid.text.trim();
                String password = pass.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter valid details")),
                  );
                } else {
                  try {
                    // ✅ LOGIN USER
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Login Successful")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? "Login failed")),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                elevation: 15,
              ),
              child: Text("Login"),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()),
                );
              },
              child: Text("Not Registered!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            )],
        ),
      ),
    );
  }
}
