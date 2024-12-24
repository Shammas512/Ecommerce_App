import 'package:ecom/constants/myimages.dart';
import 'package:ecom/pages/HomeScreen/homeview.dart';
import 'package:ecom/pages/login%20screen/signup.dart';
import 'package:ecom/pages/splashscreen.dart';
import 'package:ecom/widgets/elevatedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loader = false;
  bool _isobscure = true;
  String errorMessage = '';
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  userlogin() async {
    if (emailcontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in both email and password fields.';
      });
      return;
    }

    try {
      setState(() {
        loader = true;
        errorMessage = '';
      });

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(SplashscreenState.ISLOGIN, true);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homeview()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        loader = false;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided.';
        } else {
          errorMessage = 'An unknown error occurred.';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Colors.green[400],
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(Myimages.logoimg),
              ),
              Container(
                height: 65,
                decoration: BoxDecoration(
                  color: const Color(0xffB4B4B4).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: "Email",
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 65,
                decoration: BoxDecoration(
                  color: const Color(0xffB4B4B4).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: passwordcontroller,
                  obscureText: _isobscure,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isobscure = !_isobscure;
                        });
                      },
                      icon: Icon(
                        _isobscure ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    border: InputBorder.none,
                    labelText: "Password",
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MYElevatedButton(
                buttonText: "    Login     ",
                onPressed: () async {
                  userlogin();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    },
                    child: const Text("Don't Have An Account??"),
                  ),
                ],
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              if (loader)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
