import 'package:flutter/material.dart';

const kInputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.only(top: 15.0, left: 10.0),
  constraints: BoxConstraints(
    maxHeight: 60.0,
  ),
  filled: true,
  fillColor: Color(0xff393186),
);

 ButtonStyle kButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(
    const Color(0xff393186),
  ),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  textStyle: MaterialStateProperty.all(
    const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
);

 const darkBlueColour = Color(0xff393186);
 const darkOrangeColour = Color(0xffe4301f);
 const offWhiteColour = Color(0xfff1f4f8);
 const greyColour = Color(0xff57636c);

List<String> districts = [
  "Kakkand",
  "Vytila",
  "Fort Kochi",
  "Kaloor",
  "Thammanam",
  "Pallurity",
  "Mulunthurity",
  "Aluva",
  "Kalamassery",
  "Pulinchodu",
  "Edapally",
  "Townhall",
  "Ayappankavu",
  "MG Road",
  "Highcourt",
  "Petta",
  "Thrippunithura",
  "Thrikkakara"
];

List<String> typeOfRoadAccidents = [
  "Car",
  "Motorcycle",
  "Truck",
  "Bus",
  "Bicycle",
  "Pedestrian"
];