import 'package:firebasse_miner_one/helper/firebase_authenticate_helper.dart';
import 'package:firebasse_miner_one/main.dart';
import 'package:firebasse_miner_one/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({Key? key}) : super(key: key);

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String email = "";
  String password = "";
  final signInKey = GlobalKey<FormState>();
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
        centerTitle: true,
      ),
      body: Form(
        key: signInKey,
        child: Container(
          color: Colors.cyan.shade50,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val!;
                  },
                  cursorColor: Colors.blueAccent,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      labelText: "Email",
                      labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.grey))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: passController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Password First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    password = val!;
                  },
                  cursorColor: Colors.blueAccent,
                  obscureText: isSecure,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSecure = !isSecure;
                          });
                        },
                        child: const Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      labelText: "Password",
                      labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.grey))),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (signInKey.currentState!.validate()) {
                    signInKey.currentState!.save();
                    await FireBaseAuthenticationHelper
                        .fireBaseAuthenticationHelper
                        .SignIn(emailAddress: email, password: password);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                        (route) => false);
                  }
                },
                child: const Text("Sing UP"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInPage()),
                  );
                  FireBaseAuthenticationHelper.fireBaseAuthenticationHelper
                      .signInWithGoogle();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                      (route) => false);
                },
                child: const Text("Sing In with google"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInPage()),
                  );
                },
                child: const Text("Sing In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
