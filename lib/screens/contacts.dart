import 'package:flutter/material.dart';
import 'package:accident_report_app/constants.dart';
import 'package:accident_report_app/components/contact_details.dart';
import 'package:accident_report_app/components/app_bar_title.dart';

class Contacts extends StatelessWidget {
  static const String id = 'contacts';

  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(
          title: 'Contacts',
        ),
        backgroundColor: darkBlueColour,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: ContactDetails(),
          ),
        ),
      ),
    );
  }
}
