import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fooddeliveryapp/pages/home.dart';
import 'package:flutter_fooddeliveryapp/pages/login.dart';
import 'package:flutter_fooddeliveryapp/services/database.dart';
import 'package:flutter_fooddeliveryapp/widgets/bottomnavi.dart';
import 'package:flutter_fooddeliveryapp/widgets/widget_support.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = "", email = "", password = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  signupUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Map<String, dynamic> userdetails = {
        "Name": name,
        "Email": email,
      };

      await DatabaseMethods()
          .addUserDetails(userdetails, userCredential.user!.uid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You have literally registered successful!"),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Bottomnavi()));
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your password is as weak as hell"),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your email is already in use"),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xFFff5c30),
                      Color(0xFFe74b1a),
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: const Text(""),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      "images/logo.png",
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                    )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "Sign up",
                                style: AppWidgets.headlineTextFieldStyle(),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: namecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Your Username";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: AppWidgets
                                        .smallboldlineTextFieldStyle(),
                                    prefixIcon:
                                        const Icon(Icons.person_outlined)),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter E-mail';
                                  }
                                  return null;
                                },
                                controller: emailcontroller,
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: AppWidgets
                                        .smallboldlineTextFieldStyle(),
                                    prefixIcon:
                                        const Icon(Icons.email_outlined)),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: passwordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: AppWidgets
                                        .smallboldlineTextFieldStyle(),
                                    prefixIcon:
                                        const Icon(Icons.password_outlined)),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      email = emailcontroller.text;
                                      password = passwordcontroller.text;
                                      name = namecontroller.text;
                                    });
                                    signupUser();
                                  }
                                },
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: const Color(0Xffff5722),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Center(
                                        child: Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontFamily: 'Poppins1',
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: Text(
                          "Already have an account? Login",
                          style: AppWidgets.smallboldlineTextFieldStyle(),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
