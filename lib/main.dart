import 'package:accident_report_app/screens/edapally.dart';
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
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyAZewkSgTMpUWYSk6e0g_fvYhEprpSlutw",
      //     appId: "1:160253048879:android:0027f2a56fbaf512bbaeda",
      //     messagingSenderId: "160253048879",
      //     projectId: "accidentreportapp-780ef")
  );
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
        EdapallyPolice.id: (context) => const EdapallyPolice(),
      },
    );
  }
}
