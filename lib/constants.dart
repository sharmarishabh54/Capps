import 'package:flutter/material.dart';

const kBackgroundColour = Color(0xffEDF6FD);

const kHeadingTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kSubHeadingTextStyle = TextStyle(
  fontSize: 20,
  // fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kLogoTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kRankTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

const kCardCOlors = [
  Color(0xff3ECCF4),
  Color(0xff60EFB1),
  Color(0xffFEC4D8),
  Color(0xff9DA7FF),
];
const kBoxShadows = [
  BoxShadow(
    color: Color(0xff119BC2),
    blurRadius: 60.0, // soften the shadow
    spreadRadius: -30.0, //extend the shadow
    offset: Offset(
      6.0, // Move to right 10  horizontally
      40.0, // Move to bottom 10 Vertically
    ),
  ),
  BoxShadow(
    color: Color(0xff15BD74),
    blurRadius: 60.0, // soften the shadow
    spreadRadius: -30.0, //extend the shadow
    offset: Offset(
      6.0, // Move to right 10  horizontally
      40.0, // Move to bottom 10 Vertically
    ),
  ),
  BoxShadow(
    color: Color(0xffB9486E),
    blurRadius: 60.0, // soften the shadow
    spreadRadius: -30.0, //extend the shadow
    offset: Offset(
      6.0, // Move to right 10  horizontally
      40.0, // Move to bottom 10 Vertically
    ),
  ),
  BoxShadow(
    color: Color(0xff3A48C5),
    blurRadius: 60.0, // soften the shadow
    spreadRadius: -30.0, //extend the shadow
    offset: Offset(
      6.0, // Move to right 10  horizontally
      40.0, // Move to bottom 10 Vertically
    ),
  ),
];

const kIconPath = 'assets/icons/';

const l = {
  "title": "Smart ToDo App with Voice Assistant",
  "thinker": "Rishabh Sharma",
  "description":
      "This app you will let you create multiple ToDos to with the touch of a button using your voice. Or Not.",
  "rank": "5",
  "rating": {"score": 4.4, "count": 24},
  "categories": [
    {"title": "Productivity", "tag": "productivity"},
    {"title": "Automation", "tag": "automation"}
  ]
};
