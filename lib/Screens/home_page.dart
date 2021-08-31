import 'package:capps/Screens/screens.dart';
// import 'package:capps/models/ideas.dart';
// import 'package:capps/models/models.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:capps/constants.dart';
import 'package:capps/size_config.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:capps/services/providers.dart';

// import 'list_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // CollectionReference ideasF = FirebaseFirestore.instance.collection('ideas');
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  double xAxis = 0;
  double yAxis = 0;
  double scale = 1;
  bool sideEnabled = false;
  int currentIndex = 0;
  // addUser() {
  //   // Call the user's CollectionReference to add a new user
  //   print("Add Start");
  //   var ideasList = ideas;
  //   for (var i in ideasList)
  //     ideasF
  //         .add(i)
  //         .then((value) => print("User Added"))
  //         .catchError((error) => print("Failed to add user: $error"));
  //   print("Add End");
  // }
  _scaleDown() {
    setState(() {
      xAxis = 230;
      yAxis = 150;
      scale = 0.6;
      sideEnabled = true;
    });
  }

  _scaleUp() {
    setState(() {
      xAxis = 0;
      yAxis = 0;
      scale = 1;
      sideEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnimatedContainer(
      transform: Matrix4.translationValues(xAxis, yAxis, 0)..scale(scale),
      duration: Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: sideEnabled
              ? BorderRadius.circular(40)
              : BorderRadius.circular(0),
        ),
        child: Scaffold(
          backgroundColor: kBackgroundColour,
          appBar: buildAppBar(),
          bottomNavigationBar: buildBottomContainer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IndexedStack(
              index: currentIndex,
              children: [
                IdeasScreen(),
                CategoryScreen(),
                UserProfile(),
                Scaffold(),
              ],
            ),
          ),
          // MainScreen(),
        ),
      ),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: 25,
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              // width: 20,
              height: 26,
              color: currentIndex == 0 ? Colors.black : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                currentIndex = 0;
              });
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/category.svg',
              height: 26,
              color: currentIndex == 1 ? Colors.black : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                currentIndex = 1;
              });
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/user.svg',
              height: 26,
              color: currentIndex == 2 ? Colors.black : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                currentIndex = 2;
              });
            },
          ),
          Container(
            height: 60,
            child: InkWell(
              child: SvgPicture.asset(
                'assets/icons/add.svg',
              ),
              onDoubleTap: () {
                // int length = context.read(ideasListProvider.state).length;
                // context.read(ideasListProvider).add(
                //       Idea(
                //           title: "just a Random Idea",
                //           thinker: "Shahadat",
                //           rating: Rating(score: 4.9, count: 24),
                //           categories: ["Smart", "Entertainment"],
                //           rank: length + 1,
                //           description: "Lets just say that this has been fun"),
                //     );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Onboarding()));
              },
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: AddIdeaScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Center(
          child: Text(
        "Capps          ",
        style: kLogoTextStyle,
      )),
      actions: [
        // IconButton(
        //   icon: Icon(
        //     Icons.supervised_user_circle,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     // Call the user's CollectionReference to add a new user
        //     CollectionReference ideasF =
        //         FirebaseFirestore.instance.collection('ideas');
        //     print("Add Start");
        //     var ideasList = ideas;
        //     for (var i in ideasList) {
        //       Idea y = Idea();
        //       Idea z = Idea.fromJson(i);
        //       z.id = (y.id);
        //       print(z.id);
        //       var x = ideasF.doc(y.id);
        //       x
        //           .set(z.toJson())
        //           .then((value) => print("User Added"))
        //           .catchError((error) => print("Failed to add user: $error"));
        //       print("Add End");
        //     }
        //   },
        // ),
      ],
      leading: sideEnabled
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: _scaleUp,
            )
          : FlatButton(
              child: SvgPicture.asset('assets/icons/menu.svg'),
              onPressed: _scaleDown,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
    );
  }
}
