import 'package:capps/services/auth.dart';
import 'package:capps/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:capps/services/providers.dart';

class SignInScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _auth = watch(firebaseAuthProvider);
    final _store = watch(firestoreProvider);
    final serv = AuthService(_auth, _store);
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: Colors.yellow[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "Welcome To",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontWeight: FontWeight.w900,
            //     fontSize: 50,
            //   ),
            // ),
            Text(
              "CAPPS",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w900,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text(
              "Where Ideas Get Real",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () async {
                  // Navigator.of(context).push(
                  //   PageTransition(
                  //     type: PageTransitionType.fade,
                  //     child: Home(),
                  //   ),
                  // );
                  final User user = await serv.googleSignIn();
                  print(user.displayName);
                  Navigator.pop(context);
                },
                child: Text("Login With Google"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
