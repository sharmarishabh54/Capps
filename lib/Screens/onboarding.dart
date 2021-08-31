import 'package:capps/Screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

class Onboarding extends StatelessWidget {
  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/img/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.fade,
        child: SignInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Post Your Ideas",
          image: _buildImage('idea_img'),
          decoration: PageDecoration(pageColor: Color(0xff9DF1AF)),
          body:
              "Got an idea you want to share with everyone? Post it here and others will rate your Idea and even sponsor them. ",
        ),
        PageViewModel(
          title: "Collaborate With Others!!",
          image: _buildImage('collab_img'),
          decoration: PageDecoration(pageColor: Color(0xffAECFFF)),
          body:
              "Looking for some people to work with on your project? Or are you looking for a project to work on? You will find it both here.",
        ),
        PageViewModel(
          title: "Sponsor An Idea!!",
          image: _buildImage('sponsor_img'),
          decoration: PageDecoration(pageColor: Color(0xffFFB2B2)),
          // footer: RaisedButton(
          //   onPressed: () {},
          //   child: Text("Get Started"),
          // ),
          body:
              "Saw an Idea you liked? Help them out by sponsoring it so that it becomes a reality.",
        ),
      ],
      onDone: () => _onIntroEnd(context),
      done: const Text("Done"),
      next: const Text("Next"),
      dotsDecorator: DotsDecorator(
        color: Colors.white, // Inactive color
        activeColor: Colors.redAccent,
        activeSize: const Size(18.0, 9.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
