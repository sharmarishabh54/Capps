import 'package:capps/Screens/update_profile.dart';
import 'package:capps/components/components.dart';
import 'package:capps/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:capps/services/providers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class UserProfile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authUser = watch(authStateChangedProvider).data?.value;
    String getInitials(String string, int limitTo) {
      var buffer = StringBuffer();
      var split = string.split(' ');
      for (var i = 0; i < (limitTo ?? split.length); i++) {
        buffer.write(split[i][0]);
      }

      return buffer.toString();
    }

    return Scaffold(
      body: watch(firebaseUserProvider).when(
        loading: () => const Center(
            child: SpinKitPouringHourglass(color: Color(0xffe53935))),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (thinkers) {
          final thinker = thinkers
              .where((element) => element.uid == authUser.uid)
              .toList()[0];

          return SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: new BoxDecoration(
                          color: Colors.orange[200],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(
                          getInitials(thinker.name, 2),
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w800),
                        )),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          thinker.name,
                          style: kTitleTextStyle,
                        ),
                        Text(thinker.email),
                        thinker.status != 'none'
                            ? Text(thinker.status)
                            : Container(),
                        thinker.age != 0
                            ? Text("Age: " + thinker.age.toString())
                            : Container(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: UpdateProfile()));
                  },
                  child: Text(
                    "Update Profile",
                    style: TextStyle(fontSize: 15, color: Colors.blue[900]),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "My Ideas",
                  style: kHeadingTextStyle,
                ),
                SizedBox(height: 20),
                watch(firebaseIdeaProvider).when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text(err.toString())),
                  data: (ideas) {
                    final filteredIdeas = ideas
                        .where((idea) => (idea.thinker
                            .toLowerCase()
                            .contains(authUser.displayName.toLowerCase())))
                        .toList();
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredIdeas.length,
                      itemBuilder: (context, index) {
                        // print(filteredIdeas[index].title +
                        //     filteredIdeas.length.toString());
                        print(filteredIdeas.length);
                        return ListCard(
                          idea: filteredIdeas[index],
                          index: index,
                          ideas: filteredIdeas,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
