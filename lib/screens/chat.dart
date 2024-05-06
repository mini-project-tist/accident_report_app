import 'package:accident_report_app/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:accident_report_app/components/spacing.dart';
import 'package:accident_report_app/components/chatbot.dart';
import 'package:intl/intl.dart';
import 'package:accident_report_app/components/messageFromChatbot.dart';
import 'package:accident_report_app/components/messageFromUser.dart';
import 'package:accident_report_app/constants.dart';
import 'package:accident_report_app/components/app_bar_title.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Chat extends StatefulWidget {
  static const String id = 'chat';

  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Widget> dynamicContainers = [];
  late Map<String, dynamic> userData;
  var controller = TextEditingController();
  String dropdownValue1 = districts.first;
  String dropdownValue2 = typeOfRoadAccidents.first;
  String message = '';
  bool lastQuestionAsked = false;
  bool endTestimony = false;
  List<String> userMessages = [];
  List<List<String>> chatBotQuestions = [
    ["enter date:"],
    ["enter place:"],
    ["enter type of road accident:"],
    ["testimony:"]
  ];
  List<String> userDate = [];
  List<String> userPlace = [];
  List<String> userTypeAccident = [];
  List<List<String>> userAnswers = [];
  String summarisedTestimony = '';
  bool isSummarised = false;
  bool startTestimony = true;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        final docRef = db.collection("users").doc(user.uid);
        docRef.get().then(
          (DocumentSnapshot doc) {
            userData = doc.data() as Map<String, dynamic>;
            print(userData);
          },
          onError: (e) => print("Error getting document: $e"),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: 'Chat'),
        backgroundColor: darkBlueColour,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, HomePage.id);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 250,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const ChatBot(),
                      const ChatbotMessage(
                          chatbotMessage:
                              "Hello, I  will be assisting you with your testimony! If you have recently witnessed  a road accident or been involved in one,  please answer the following questions."),
                      const Spacing(),
                      const ChatBot(),
                      const ChatbotMessage(
                          chatbotMessage: "Please enter your testimony ID "),
                      // const Spacing(),
                      // const ChatBot(),
                      // const ChatbotMessage(
                      //     chatbotMessage: "What's the date of the accident?"),
                      // const Spacing(),
                      // const ChatBot(),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: darkBlueColour,
                      //     foregroundColor: Colors.white,
                      //     textStyle: const TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   child: const Text("Select Date"),
                      //   onPressed: () {
                      //     _showDatePicker();
                      //   },
                      // ),
                      // Dynamic containers
                      ...dynamicContainers,
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
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
                    child: const Text('Stop testimony'),
                    onPressed: () {
                      if (endTestimony) {
                        setState(() {
                          userAnswers.add(userMessages);
                          Map<String, List> history = {
                            "chatbot": chatBotQuestions,
                            "user": userAnswers,
                          };
                          fetchData(history).then((data) {
                            summarisedTestimony = data;
                            print(data);
                            Map<String, dynamic> testimony = {
                              "summary": summarisedTestimony,
                              "witness_name": userData["full_name"],
                              "witness_email": userData["email_address"],
                              "witness_phone_no": userData["phone_no"],
                              "place_of_accident": dropdownValue1,
                            };
                            db.collection("testimonies").doc().set(testimony);
                          }).catchError((error) {
                            print(error);
                          });
                        });
                      } else {
                        null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 150.0,
                          child: TextField(
                            controller: controller,
                            cursorColor: darkBlueColour,
                            style: const TextStyle(color: darkBlueColour),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              hintText: 'Type here',
                              filled: true,
                              fillColor: offWhiteColour,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            onChanged: (value) {
                              message = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 90.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkBlueColour,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                            side: const BorderSide(
                              width: 2.0,
                              color: darkOrangeColour,
                            ),
                          ),
                          child: const Text('Enter'),
                          onPressed: () {
                            if (lastQuestionAsked) {
                              setState(() {
                                controller.text = '';
                                messageBubble(message);
                                endTestimony = true;
                              });
                            } else if (startTestimony) {
                              setState(() {
                                controller.text = '';
                                messageBubble(message);
                                if (message == userData["testimony_id"]) {
                                  startTestimony = false;
                                  dynamicContainers.add(
                                    Column(
                                      children: [
                                        const Spacing(),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ChatBot(),
                                          ],
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ChatbotMessage(
                                                chatbotMessage:
                                                    "What's the date of the accident?"),
                                          ],
                                        ),
                                        const Spacing(),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ChatBot(),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: darkBlueColour,
                                                foregroundColor: Colors.white,
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              child: const Text("Select Date"),
                                              onPressed: () {
                                                _showDatePicker();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }
                                else{
                                  dynamicContainers.add(const Column(
                                    children: [
                                      Spacing(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ChatBot(),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ChatbotMessage(chatbotMessage: "You entered the wrong testimony ID. Please try again."),
                                        ],
                                      ),
                                    ],
                                  ));
                                }
                              });
                            } else {
                              null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2060),
    ).then((value) {
      setState(() {
        print(MediaQuery.of(context).size.height);
        dynamicContainers.add(
          Column(
            children: [
              const Spacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    userData["full_name"],
                    style: const TextStyle(color: Color(0xff57636c)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      color: darkOrangeColour,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat("MMMM d, yyyy").format(value!),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        userDate.add(DateFormat("MMMM d, yyyy").format(value));
        userAnswers.add(userDate);
        print(userAnswers);
        question2();
      });
    });
  }

  void question2() {
    dynamicContainers.add(
      Column(
        children: [
          const Spacing(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatBot(),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatbotMessage(chatbotMessage: "Where did the accident happen?"),
            ],
          ),
          const Spacing(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatBot(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownMenu(
                trailingIcon: const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.white,
                ),
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
                inputDecorationTheme: kInputDecorationTheme,
                initialSelection: dropdownValue1,
                helperText: "Please select..",
                dropdownMenuEntries: districts.map((String value) {
                  return DropdownMenuEntry(
                    value: value,
                    label: value,
                    style: kButtonStyle,
                  );
                }).toList(),
                onSelected: (value) {
                  setState(() {
                    dropdownValue1 = value!;
                    dynamicContainers.add(const Spacing());
                    dynamicContainers.add(
                      UserMessage(data: userData, value: value),
                    );
                    userPlace.add(dropdownValue1);
                    userAnswers.add(userPlace);
                    print(userAnswers);
                    question3();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void question3() {
    dynamicContainers.add(
      Column(
        children: [
          const Spacing(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatBot(),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatbotMessage(chatbotMessage: "What type of road accident?"),
            ],
          ),
          const Spacing(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatBot(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownMenu(
                trailingIcon: const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.white,
                ),
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
                inputDecorationTheme: kInputDecorationTheme,
                initialSelection: dropdownValue2,
                helperText: "Please select..",
                dropdownMenuEntries: typeOfRoadAccidents.map((String value) {
                  return DropdownMenuEntry(
                    value: value,
                    label: value,
                    style: kButtonStyle,
                  );
                }).toList(),
                onSelected: (value) {
                  setState(() {
                    dropdownValue2 = value!;
                    dynamicContainers.add(
                      UserMessage(data: userData, value: value),
                    );
                    userTypeAccident.add(dropdownValue2);
                    userAnswers.add(userTypeAccident);
                    print(userAnswers);
                    question4();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void question4() {
    dynamicContainers.add(
      const Column(
        children: [
          Spacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatBot(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatbotMessage(
                  chatbotMessage:
                      "Please type out relevant details regarding the accident, including time, specific area of the accident, number of people/vehicles involved etc that could help with our investigation.")
            ],
          ),
        ],
      ),
    );
    lastQuestionAsked = true;
  }

  void messageBubble(String message) {
    dynamicContainers.add(const Spacing());
    dynamicContainers.add(
      UserMessage(data: userData, value: message),
    );
    userMessages.add(message);
  }

  Future<String> fetchData(Map<String, List> history) async {
    final response = await http.get(Uri.parse(
        'https://hellopyt.pythonanywhere.com/?input=${history.toString()}'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, return the response body
      return response.body;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data');
    }
  }
}
