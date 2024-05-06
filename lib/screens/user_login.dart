import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_signup.dart';
import 'chat.dart';
import 'package:accident_report_app/components/spacing.dart';
import 'package:accident_report_app/constants.dart';
import 'package:accident_report_app/components/app_bar_title.dart';

class UserLogin extends StatefulWidget {
  static const String id = 'user_login';

  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(
          title: 'User Login',
        ),
        backgroundColor: darkBlueColour,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150.0,
                    ),
                    SizedBox(
                      width: 350.0,
                      child: TextField(
                        cursorColor: darkBlueColour,
                        style: const TextStyle(color: darkBlueColour),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Email',
                          filled: true,
                          fillColor: offWhiteColour,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    const Spacing(),
                    SizedBox(
                      width: 350.0,
                      child: TextField(
                        cursorColor: darkBlueColour,
                        obscureText: true,
                        obscuringCharacter: '*',
                        style: const TextStyle(color: darkBlueColour),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Password',
                          filled: true,
                          fillColor: offWhiteColour,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    const Spacing(),
                    SizedBox(
                      width: 230.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBlueColour,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                          side: const BorderSide(
                            width: 2.0,
                            color: darkOrangeColour,
                          ),
                        ),
                        child: const Text('Sign In'),
                        onPressed: () async {
                          try {
                             await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            Navigator.pushNamed(context, Chat.id);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        },
                      ),
                    ),
                    const Spacing(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, UserSignUp.id);
                          },
                          child: const Text(
                            'Sign up here',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkBlueColour,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
