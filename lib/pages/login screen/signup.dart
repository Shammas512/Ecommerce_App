import 'package:ecom/constants/myimages.dart';
import 'package:ecom/pages/login%20screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isloggedin = false;
  bool _isObscured = true;

  createuser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("SignUp"),
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
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "UserName",
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
                obscureText: _isObscured,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured; // Toggle visibility
                      });
                    },
                  ),
                  border: InputBorder.none,
                  labelText: "Password",
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createuser,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.green[400],
                foregroundColor: Colors.white,
              ),
              child: const Text("      SignUp      "),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
