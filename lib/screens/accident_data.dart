import 'package:flutter/material.dart';

class AccidentData extends StatefulWidget {
  static const String id = 'accident_data';

  const AccidentData({super.key});

  @override
  State<AccidentData> createState() => _AccidentDataState();
}

class _AccidentDataState extends State<AccidentData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accident Data',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff393186),
      ),
    );
  }
}
