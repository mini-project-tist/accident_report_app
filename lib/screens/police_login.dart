import 'edapally.dart';
import 'package:flutter/material.dart';
import 'package:accident_report_app/components/spacing.dart';
import 'package:accident_report_app/constants.dart';
import 'package:accident_report_app/components/app_bar_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PoliceLogin extends StatefulWidget {
  static const String id = 'police_login';

  const PoliceLogin({super.key});

  @override
  State<PoliceLogin> createState() => _PoliceLoginState();
}

class _PoliceLoginState extends State<PoliceLogin> {
  String policeID = '';
  String password = '';
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool loginSuccessful = false;
  String district = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: 'Police Login',),
        backgroundColor: darkBlueColour,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Center(
                child: Column(
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
                          hintText: 'Police ID',
                          filled: true,
                          fillColor: offWhiteColour,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
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
                        onPressed: () {
                          setState(() {
                            getDoc();
                            if(!loginSuccessful)
                            {
                              null;
                            }
                            else
                              {
                                if(district=='Edapally')
                                  {
                                    Navigator.pushNamed(context, EdapallyPolice.id);
                                  }
                              }
                          });
                        },
                      ),
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
  Future getDoc() async{
    var a = await db.collection("police").doc(policeID).get();
    if(a.exists){
      if(a["password"]==password)
        {
          setState(() {
            loginSuccessful = true;
            district = a["district"];
          });
        }
    }
  }
}

