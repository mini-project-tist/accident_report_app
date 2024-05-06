// import 'package:flutter/material.dart';
//
// class AccidentData extends StatefulWidget {
//   static const String id = 'accident_data';
//
//   const AccidentData({super.key});
//
//   @override
//   State<AccidentData> createState() => _AccidentDataState();
// }
//
// class _AccidentDataState extends State<AccidentData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Accident Data',
//           style: TextStyle(
//               color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xff393186),
//       ),
//     );
//   }
// }
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:accident_report_app/constants.dart';
import 'package:accident_report_app/components/app_bar_title.dart';

class AccidentData extends StatefulWidget {
  static const String id = 'accident_data';

  const AccidentData({super.key});
  @override
  _AccidentDataState createState() => _AccidentDataState();
}

class _AccidentDataState extends State<AccidentData> {
  Future<Uint8List> fetchPieChart() async {
    // Make HTTP GET request to your Flask API
    final response = await http.get(Uri.parse('https://e0c4-2409-4073-4dca-17a8-5440-2557-4a8e-1a6f.ngrok-free.app'
        '/api/get-district-counts'));

    if (response.statusCode == 200) {
      // Return image data if request is successful
      return response.bodyBytes;
    } else {
      // Handle errors if any
      throw Exception('Failed to load pie chart: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: 'Accident Data'),
        backgroundColor: darkBlueColour,
      ),
      body: Center(
        child: FutureBuilder<Uint8List>(
          future: fetchPieChart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Display the image using Image.memory widget
              return Image.memory(snapshot.data!);
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}