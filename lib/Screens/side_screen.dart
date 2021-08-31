// import 'package:capps/services/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:capps/size_config.dart';
import 'package:flutter/material.dart';
import 'package:capps/services/providers.dart';

class SideScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final _auth = watch(firebaseAuthProvider);
    // final _store = watch(firestoreProvider);
    // final serv = AuthService(_auth, _store);
    final authServ = watch(authServiceProvider);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: SizeConfig.screenWidth,
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                authServ.signOut();
              },
              child: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
