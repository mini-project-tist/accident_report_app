import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_signup.dart';
import 'chat.dart';
import 'package:accident_report_app/spacing.dart';

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
        title: const Text(
          'User Login',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff393186),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150.0,
                  ),
                  SizedBox(
                    width: 350.0,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: const Color(0xff393186),
                      style: const TextStyle(color: Color(0xff393186)),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Email',
                        filled: true,
                        fillColor: Color(0xfff1f4f8),
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
                      cursorColor: const Color(0xff393186),
                      obscureText: true,
                      obscuringCharacter: '*',
                      style: const TextStyle(color: Color(0xff393186)),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Color(0xfff1f4f8),
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
                        backgroundColor: const Color(0xff393186),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                        side: const BorderSide(
                          width: 2.0,
                          color: Color(0xffe4301f),
                        ),
                      ),
                      child: const Text('Sign In'),
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          if(credential!=null)
                            {
                              Navigator.pushNamed(context, Chat.id);
                            }
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
                            color: Color(0xff393186),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


