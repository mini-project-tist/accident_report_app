import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:accident_report_app/screens/home_page.dart';
import 'package:accident_report_app/screens/contacts.dart';
import 'package:accident_report_app/screens/accident_data.dart';
import 'package:accident_report_app/screens/user_login.dart';
import 'package:accident_report_app/screens/police_login.dart';
import 'package:accident_report_app/screens/user_signup.dart';
import 'package:accident_report_app/screens/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AccidentReportApp());
}

class AccidentReportApp extends StatelessWidget {
  const AccidentReportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        Contacts.id: (context) => const Contacts(),
        AccidentData.id: (context) => const AccidentData(),
        UserLogin.id: (context) => const UserLogin(),
        PoliceLogin.id: (context) => const PoliceLogin(),
        UserSignUp.id: (context) => const UserSignUp(),
        Chat.id: (context) => const Chat(),
      },
    );
  }
}
