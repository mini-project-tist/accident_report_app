import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:accident_report_app/spacing.dart';

class UserSignUp extends StatefulWidget {
  static const String id = 'user_signup';

  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final _auth = FirebaseAuth.instance;
  String fullName = '';
  String emailAddress = '';
  String phoneNo = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Registration',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff393186),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 35.0,
                  ),
                  SizedBox(
                    width: 350.0,
                    child: TextField(
                      cursorColor: const Color(0xff393186),
                      style: const TextStyle(color: Color(0xff393186)),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Full name',
                        filled: true,
                        fillColor: Color(0xfff1f4f8),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                      onChanged: (value) {
                        fullName = value;
                      },
                    ),
                  ),
                  const Spacing(),
                  SizedBox(
                    width: 350.0,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: const Color(0xff393186),
                      style: const TextStyle(color: Color(0xff393186)),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Email address',
                        filled: true,
                        fillColor: Color(0xfff1f4f8),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                      onChanged: (value) {
                        emailAddress = value;
                      },
                    ),
                  ),
                  const Spacing(),
                  SizedBox(
                    width: 350.0,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      cursorColor: const Color(0xff393186),
                      style: const TextStyle(color: Color(0xff393186)),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Phone number',
                        filled: true,
                        fillColor: Color(0xfff1f4f8),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                      onChanged: (value) {
                        phoneNo = value;
                      },
                    ),
                  ),
                  const Spacing(),
                  SizedBox(
                    width: 350.0,
                    child: TextField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      cursorColor: const Color(0xff393186),
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
                    width: 350.0,
                    child: TextField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      cursorColor: const Color(0xff393186),
                      style: const TextStyle(color: Color(0xff393186)),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Confirm Password',
                        filled: true,
                        fillColor: Color(0xfff1f4f8),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
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
                      child: const Text('Register'),
                      onPressed: () async {
                        try {
                          final credential = await _auth.createUserWithEmailAndPassword(
                            email: emailAddress,
                            password: password,
                          );
                          Map<String, dynamic> data = {
                            'full_name': fullName,
                            'email_address': emailAddress,
                            'phone_no': phoneNo,
                            'password': password,
                          };
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(credential.user!.uid)
                              .set(data);
                          if(credential!=null)
                            {
                              Navigator.pop(context);
                            }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
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
