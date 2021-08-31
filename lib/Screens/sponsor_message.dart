import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SponsorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Message Sent !!!",
              style: GoogleFonts.poppins(
                  color: Colors.red[400],
                  fontSize: 30,
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: 20),
            Text(
              "Thanks for your interest in the Idea.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  decoration: TextDecoration.none,
                  color: Colors.black87,
                  fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "The developer will reach out to you as soon as possible so that you can  move forward with further details.",
              style: GoogleFonts.poppins(
                color: Colors.black87,
                decoration: TextDecoration.none,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
