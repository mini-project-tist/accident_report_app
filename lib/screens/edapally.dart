import 'package:flutter/material.dart';
import 'package:accident_report_app/constants.dart';
import 'package:accident_report_app/components/app_bar_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:accident_report_app/components/spacing.dart';

import 'home_page.dart';

//
// class EdapallyPolice extends StatefulWidget {
//   static const String id = 'edapally';
//
//   const EdapallyPolice({super.key});
//
//   @override
//   State<EdapallyPolice> createState() => _EdapallyPoliceState();
// }
//
// class _EdapallyPoliceState extends State<EdapallyPolice> {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> testimonyList = [];
//   List<Widget> dynamicCards = [];
//
//   @override
//   void initState() {
//     super.initState();
//     checkForTestimony();
//   }
//
//   void checkForTestimony() {
//     db
//         .collection("testimonies")
//         .where("place_of_accident", isEqualTo: "Edapally")
//         .get()
//         .then(
//       (querySnapshot) {
//         print("Successfully completed");
//         for (var docSnapshot in querySnapshot.docs) {
//           testimonyList.add(docSnapshot.data() as Map<String, dynamic>);
//           print(testimonyList);
//         }
//       },
//       onError: (e) => print("Error completing: $e"),
//     );
//     for (int i = 0; i < testimonyList.length; i++) {
//       setState(() {
//         dynamicCards.add(
//           Card(
//             child: Column(
//               children: [
//                 Text("Witness name: ${testimonyList[i]["witness_name"]}")
//               ],
//             ),
//           ),
//         );
//         print("Witness name: ${testimonyList[i]["witness_name"]}");
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const AppBarTitle(
//           title: 'Edapally Police',
//         ),
//         backgroundColor: darkBlueColour,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Text("Testimonies"),
//                 ...dynamicCards,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class EdapallyPolice extends StatefulWidget {
//   static const String id = 'edapally';
//
//   const EdapallyPolice({Key? key}) : super(key: key);
//
//   @override
//   State<EdapallyPolice> createState() => _EdapallyPoliceState();
// }
//
// class _EdapallyPoliceState extends State<EdapallyPolice> {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> testimonyList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     checkForTestimony();
//   }
//
//   Future<void> checkForTestimony() async {
//     db
//         .collection("testimonies")
//         .where("place_of_accident", isEqualTo: "Edapally")
//         .get()
//         .then(
//       (querySnapshot) {
//         print("Successfully completed");
//         for (var docSnapshot in querySnapshot.docs) {
//           testimonyList.add(docSnapshot.data() as Map<String, dynamic>);
//           // print(testimonyList);
//         }
//       },
//       onError: (e) => print("Error completing: $e"),
//     );
//     print(testimonyList.length);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const AppBarTitle(
//           title: 'Edapally Police',
//         ),
//         backgroundColor: darkBlueColour,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Text("Testimonies"),
//                 FutureBuilder<void>(
//                   future: checkForTestimony(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       return Column(
//                         children: testimonyList.map((testimony) {
//                           return Card(
//                             child: Column(
//                               children: [
//                                 Text("Witness name: ${testimony["witness_name"]}"),
//                                 // Add other details as needed
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     }
//                   },
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class EdapallyPolice extends StatefulWidget {
  static const String id = 'edapally';

  const EdapallyPolice({super.key});

  @override
  State<EdapallyPolice> createState() => _EdapallyPoliceState();
}

// class _EdapallyPoliceState extends State<EdapallyPolice> {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> testimonyList = [];
//   int testimonyNumber = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     // Remove the call to checkForTestimony from here
//   }
//
//   Future<void> checkForTestimony() async {
//     try {
//       final querySnapshot = await db
//           .collection("testimonies")
//           .where("place_of_accident", isEqualTo: "Edapally")
//           .get();
//
//       print("Successfully completed");
//       for (var docSnapshot in querySnapshot.docs) {
//         testimonyList.add(docSnapshot.data() as Map<String, dynamic>);
//       }
//     } catch (e) {
//       print("Error completing: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const AppBarTitle(
//           title: 'Edapally Police',
//         ),
//         backgroundColor: darkBlueColour,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Testimonies",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30.0,
//                       color: darkBlueColour,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   FutureBuilder<void>(
//                     future: checkForTestimony(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else {
//                         return Column(
//                           children: testimonyList.map((testimony) {
//                             testimonyNumber+=1;
//                             return Card(
//                               elevation: 5,
//                               surfaceTintColor: darkBlueColour,
//                               shadowColor: darkBlueColour,
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     "Witness testimony ${testimonyNumber}",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                       color: darkBlueColour,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       "Witness name: ${testimony["witness_name"]}\n"
//                                       "Email: ${testimony["witness_email"]}\n"
//                                       "Phone number:${testimony["witness_phone_no"]}\n"
//                                       "\n"
//                                       "${testimony["summary"]}",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: darkBlueColour,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class _EdapallyPoliceState extends State<EdapallyPolice> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> testimonyList = [];
  int testimonyNumber = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> checkForTestimony() async {
    try {
      final querySnapshot = await db
          .collection("testimonies")
          .where("place_of_accident", isEqualTo: "Edapally")
          .get();

      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        testimonyList.add(docSnapshot.data());
      }
    } catch (e) {
      print("Error completing: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(
          title: 'Edapally Police',
        ),
        backgroundColor: darkBlueColour,        actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pushNamed(context, HomePage.id);
            },
          ),
        ),
      ],

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Testimonies",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: darkBlueColour,
                    ),
                  ),
                  const Spacing(),
                  FutureBuilder<void>(
                    future: checkForTestimony(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Column(
                          children: [
                            for (var i = 0; i < testimonyList.length; i++)
                              Column(
                                children: [
                                  Card(
                                    elevation: 5,
                                    surfaceTintColor: darkBlueColour,
                                    shadowColor: darkBlueColour,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Witness testimony ${i + 1}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: darkBlueColour,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Witness name: ${testimonyList[i]["witness_name"]}\n"
                                                "\n"
                                                "Email: ${testimonyList[i]["witness_email"]}\n"
                                                "\n"
                                                "Phone number:${testimonyList[i]["witness_phone_no"]}\n"
                                                "\n"
                                                "${testimonyList[i]["summary"]}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: darkBlueColour,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (i != testimonyList.length - 1) const Spacing(),
                                ],
                              ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

