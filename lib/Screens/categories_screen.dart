import 'package:capps/Screens/screens.dart';
import 'package:capps/constants.dart';
import 'package:capps/models/models.dart';
import 'package:capps/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../size_config.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<Category> cats = [
      for (var i in categories) Category.fromJson(i)
    ];
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
        child: watch(firebaseIdeaProvider).when(
          loading: () => const Center(
              child: Center(
                  child: SpinKitPouringHourglass(color: Color(0xffe53935)))),
          error: (err, stack) => Center(child: Text(err.toString())),
          data: (ideas) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "Categories",
                      style: kLogoTextStyle.copyWith(color: Colors.red[400]),
                    ),
                  ),
                ),
                SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 20,
                  children: [
                    for (var category in cats)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: IdeaCategory(
                                  category: category.title,
                                  categories: ideas,
                                ),
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red[400],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red[200],
                                    blurRadius: 25.0, // soften the shadow
                                    spreadRadius: -2.0, //extend the shadow
                                    offset: Offset(
                                      0.0, // Move to right 10  horizontally
                                      10.0, // Move to bottom 10 Vertically
                                    ),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                iconSize: 45,
                                icon: SvgPicture.asset(
                                  category.iconUrl,
                                  color: Colors.white,
                                ),
                                onPressed: null,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              category.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Colors.red[400],
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
