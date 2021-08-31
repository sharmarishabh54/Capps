import 'package:capps/Screens/sponsor_page.dart';
import 'package:capps/components/components.dart';
import 'package:capps/services/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:capps/constants.dart';
import 'package:capps/models/models.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import '../size_config.dart';

class IdeaDetails extends ConsumerWidget {
  final Idea idea;
  final int index;
  const IdeaDetails({Key key, this.idea, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    double userRating = 0;
    bool isRated = false;
    bool isOwner = false;
    final _store = watch(firestoreProvider);
    final authUser = watch(authStateChangedProvider).data?.value;
    DocumentReference reference = _store.collection('ideas').doc(idea.id);
    DocumentReference usersReference =
        _store.collection('users').doc(authUser.uid);
    updateRating(double rating, List<String> oldRated) {
      int oldCount = idea.rating.count;
      double oldRating = idea.rating.score;
      var newRating = ((oldCount * oldRating) + rating) / (oldCount + 1);
      var n = num.parse(newRating.toStringAsFixed(2));
      List<String> newRated = [...oldRated, idea.id];
      reference.update({
        "rating": {
          "score": n,
          "count": oldCount + 1,
        },
      });
      usersReference.update({
        "rated": newRated,
      });
    }

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: kCardCOlors[index % 4],
      body: watch(firebaseIdeaProvider).when(
        loading: () =>
            const Center(child: SpinKitPouringHourglass(color: Colors.white)),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (ideas) {
          Idea currentIdea =
              ideas.where((element) => element.id == idea.id).toList()[0];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: watch(firebaseUserProvider).when(
                loading: () => const Center(
                    child: SpinKitPouringHourglass(color: Color(0xffe53935))),
                error: (err, stack) => Center(child: Text(err.toString())),
                data: (thinkers) {
                  final thinker = thinkers
                      .where((element) => element.uid == authUser.uid)
                      .toList()[0];
                  isRated = thinker.rated.contains(idea.id);
                  isOwner = idea.thinker == authUser.displayName;
                  // print("Owner:" +
                  //     idea.thinker +
                  //     " User:" +
                  //     authUser.displayName);
                  var oldRated = thinker.rated;
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "#" + currentIdea.rank.toString(),
                                    style: kRankTextStyle.copyWith(
                                        fontSize: SizeConfig.hBlock * 15.5),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        double.parse((idea.rating.score)
                                                .toStringAsFixed(1))
                                            .toString(),
                                        style: kHeadingTextStyle,
                                      ),
                                      Text("Rating"),
                                      Text(currentIdea.rating.count.toString() +
                                          " Ratings"),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                idea.title,
                                style: kHeadingTextStyle,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                idea.thinker,
                                style: kTitleTextStyle,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: SizeConfig.screenHeight * .2,
                                child: SingleChildScrollView(
                                  child: Text(idea.description),
                                  scrollDirection: Axis.vertical,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              watch(firebaseIdeaProvider).when(
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                                error: (err, stack) =>
                                    Center(child: Text(err.toString())),
                                data: (ideas) {
                                  return Container(
                                      padding: EdgeInsets.only(right: 10),
                                      height: 20,
                                      child: CategoryButton(
                                        category: idea.category,
                                        categories: ideas,
                                      ));
                                },
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            isOwner == true
                                ? Text("Can't rate your own Ideas")
                                : isRated == true
                                    ? Container(
                                        child: Text("Thanks for rating."))
                                    : Container(
                                        width: SizeConfig.screenWidth * .85,
                                        height: SizeConfig.screenHeight * .15,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                      "Like this Idea? Rate it!"),
                                                  Container(
                                                    //width: 180,
                                                    child: RatingBar(
                                                      glow: true,
                                                      onRatingUpdate: (n) {
                                                        userRating = n;
                                                        print(userRating);
                                                      },
                                                      //ignoreGestures: true,
                                                      initialRating: currentIdea
                                                          .rating.score,
                                                      itemSize: 40,
                                                      unratedColor: Colors.grey,
                                                      allowHalfRating: true,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              FlatButton(
                                                  onPressed: () {
                                                    if (isRated == false) {
                                                      updateRating(
                                                          userRating, oldRated);
                                                    }
                                                    isRated = true;
                                                  },
                                                  child: Text(
                                                    "Rate",
                                                    style: kTitleTextStyle,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                            SizedBox(
                              height: SizeConfig.screenHeight * .025,
                            ),
                            Center(
                              child: Container(
                                width: SizeConfig.screenWidth * .85,
                                height: SizeConfig.screenHeight * .08,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: SponosorPage(
                                              idea: idea,
                                            )));
                                  },
                                  color: Colors.black,
                                  child: Text(
                                    "Become a Sponsor",
                                    style: kSubHeadingTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * .025,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
