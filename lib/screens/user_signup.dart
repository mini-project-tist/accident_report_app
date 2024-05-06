import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:accident_report_app/components/spacing.dart';
import 'package:accident_report_app/constants.dart';
import 'package:accident_report_app/components/app_bar_title.dart';
import 'package:random_string/random_string.dart';

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
  String id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: 'User Registration'),
        backgroundColor: darkBlueColour,
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
                      cursorColor: darkBlueColour,
                      style: const TextStyle(color: darkBlueColour),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Full name',
                        filled: true,
                        fillColor: offWhiteColour,
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
                      cursorColor: darkBlueColour,
                      style: const TextStyle(color: darkBlueColour),
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
                      cursorColor: darkBlueColour,
                      style: const TextStyle(color: darkBlueColour),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Phone number',
                        filled: true,
                        fillColor: offWhiteColour,
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
                      cursorColor: darkBlueColour,
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
                    width: 350.0,
                    child: TextField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      cursorColor: darkBlueColour,
                      style: const TextStyle(color: darkBlueColour),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Confirm Password',
                        filled: true,
                        fillColor: offWhiteColour,
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
                        backgroundColor: darkBlueColour,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                        side: const BorderSide(
                          width: 2.0,
                          color: darkOrangeColour,
                        ),
                      ),
                      child: const Text('Register'),
                      onPressed: () async {
                        try {
                          final credential = await _auth.createUserWithEmailAndPassword(
                            email: emailAddress,
                            password: password,
                          );
                          id = randomAlphaNumeric(5);
                          Map<String, dynamic> data = {
                            'full_name': fullName,
                            'email_address': emailAddress,
                            'phone_no': phoneNo,
                            'password': password,
                            'testimony_id': id,
                          };
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(credential.user!.uid)
                              .set(data)
                              .then((_) {
                            // After saving user data, show the dialog
                            openDialog(id);
                          });
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
  Future<void> openDialog(String id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5.0,
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('YOUR TESTIMONY ID IS: $id'),
                const Text('This ID is unique to this account,'),
                const Text('Please do not forget it.'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.pop(context); // Close the screen
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      // This code will execute after the dialog is closed
      Navigator.pop(context); // Close the screen
    });
  }

}
