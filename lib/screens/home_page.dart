import 'accident_data.dart';
import 'police_login.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';
import 'user_login.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                children: [
                  SizedBox(
                    height: 120.0,
                    width: 120.0,
                    child: Image(
                      image: AssetImage('assets/images/kerala.png'),
                    ),
                  ),
                  Text(
                    'Accident Report App',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff393186),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                        side: const BorderSide(width: 2.0, color: Color(0xffe4301f)),
                        minimumSize: const Size(230, 50)
                      ),
                      child: const Text('User login'),
                      onPressed: () {
                        Navigator.pushNamed(context, UserLogin.id);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff393186),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          side: const BorderSide(width: 2.0, color: Color(0xffe4301f)),
                          minimumSize: const Size(230, 50)
                      ),
                      child: const Text('Police login'),
                      onPressed: () {
                        Navigator.pushNamed(context, PoliceLogin.id);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff393186),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          side: const BorderSide(width: 2.0, color: Color(0xffe4301f)),
                          minimumSize: const Size(230, 50)
                      ),
                      child: const Text('Accident statistics'),
                      onPressed: () {
                        Navigator.pushNamed(context, AccidentData.id);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff393186),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          side: const BorderSide(width: 2.0, color: Color(0xffe4301f),),
                          minimumSize: const Size(230, 50),
                      ),
                      child: const Text('Police contacts'),
                      onPressed: () {
                        Navigator.pushNamed(context, Contacts.id);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
