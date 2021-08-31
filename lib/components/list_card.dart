import 'package:capps/components/category_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:capps/Screens/idea_details_page.dart';
import 'package:capps/models/idea_model.dart';
import 'package:page_transition/page_transition.dart';

import '../constants.dart';
import '../size_config.dart';

class ListCard extends StatelessWidget {
  final int index;
  final Idea idea;
  final List<Idea> ideas;
  const ListCard({Key key, this.index, this.idea, this.ideas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.028),
      child: Container(
        height: SizeConfig.screenHeight * 0.16,
        //width: SizeConfig.screenWidth * .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [kBoxShadows[index % 4]],
          color: kCardCOlors[index % 4],
        ),
        child: FlatButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => IdeaDetails(
            //         index: index,
            //         idea: idea,
            //       ),
            //     ));
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: IdeaDetails(
                    index: index,
                    idea: idea,
                  ),
                ));
          },
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.screenHeight * 0.008),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("#" + idea.rank.toString(), style: kRankTextStyle),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            double.parse((idea.rating.score).toStringAsFixed(1))
                                .toString(),
                            style: kRankTextStyle,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              //width: 180,
                              child: RatingBar(
                                onRatingUpdate: (n) {},
                                ignoreGestures: true,
                                initialRating: idea.rating.score,
                                allowHalfRating: true,
                                itemSize: 18,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber[200],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Out of 5   ",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  idea.rating.count.toString() + " ratings",
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.03,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      idea.title,
                      style: kTitleTextStyle,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      idea.thinker,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 20,
                      child: CategoryButton(
                        category: idea.category,
                        categories: ideas,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
