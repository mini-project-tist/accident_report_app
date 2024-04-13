import 'package:flutter/material.dart';
import 'package:accident_report_app/spacing.dart';

class PoliceLogin extends StatefulWidget {
  static const String id = 'police_login';

  const PoliceLogin({super.key});

  @override
  State<PoliceLogin> createState() => _PoliceLoginState();
}

class _PoliceLoginState extends State<PoliceLogin> {
  String policeID = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Police Login',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff393186),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 150.0,
              ),
              SizedBox(
                width: 350.0,
                child: TextField(
                  cursorColor: const Color(0xff393186),
                  style: const TextStyle(color: Color(0xff393186)),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    hintText: 'Police ID',
                    filled: true,
                    fillColor: Color(0xfff1f4f8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  onChanged: (value) {
                    policeID = value;
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Color(0xfff1f4f8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
