import 'package:capps/Screens/sponsor_message.dart';
import 'package:capps/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:capps/constants.dart';
import 'package:capps/models/models.dart';
import 'package:capps/size_config.dart';
import 'package:page_transition/page_transition.dart';

class SponosorPage extends ConsumerWidget {
  final Idea idea;
  const SponosorPage({
    Key key,
    this.idea,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final authUser = watch(authStateChangedProvider).data?.value;
    String firstName = idea.thinker.split(' ')[0];
    String message = 'Hey ' +
        firstName +
        ', wanted to let you know that we liked your idea "' +
        idea.title +
        '". We would also love to sponsor this so get back to us if you are interested as well.';
    String subject = "Regarding Sponsorship of your Idea - " + idea.title + ".";

    return watch(firebaseUserProvider).when(
        loading: () => const Center(
            child: SpinKitPouringHourglass(color: Color(0xffe53935))),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (thinkers) {
          final thinker = thinkers
              .where((element) => element.name == idea.thinker)
              .toList()[0];

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: kBackgroundColour,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              body: Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Send a Message to the Developer:",
                      style: kTitleTextStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Enter your Subject.",
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue: subject,
                        minLines: 1,
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter a Message",
                        ),
                        onChanged: (value) {
                          subject = value;
                          print(subject);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Enter your Message.",
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          color: Colors.black87,
                          fontSize: 15),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue: message,
                        minLines: 10,
                        maxLines: 15,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter a Message",
                        ),
                        onChanged: (value) {
                          message = value;
                          print(message);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.yellow[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Center(
                              child: Text(
                            "Send",
                            style: kTitleTextStyle,
                          )),
                          onTap: () async {
                            final Email email = Email(
                              body: message,
                              subject: subject,
                              recipients: [thinker.email],
                              cc: [],
                              bcc: [],
                              attachmentPaths: [],
                              isHTML: false,
                            );

                            await FlutterEmailSender.send(email);
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: SponsorPage()));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
