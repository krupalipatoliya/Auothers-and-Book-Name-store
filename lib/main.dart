import 'package:firebase_core/firebase_core.dart';
import 'package:firebasse_miner_one/helper/firebase_authenticate_helper.dart';
import 'package:firebasse_miner_one/screen/home_page.dart';
import 'package:firebasse_miner_one/screen/singUPPage.dart';
import 'package:firebasse_miner_one/screen/splash_screen.dart';
import 'package:firebasse_miner_one/utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication',
      routes: routes,
    );
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Sing In"),
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
                    MaterialPageRoute(builder: (context) => const SignUPPage()),
                  );
                },
                child: const Text("Sing Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
