import 'package:capps/Screens/idea_category_screen.dart';
import 'package:capps/models/models.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:page_transition/page_transition.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  final List<Idea> categories;

  const CategoryButton({Key key, this.category, this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 5),
        color: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: IdeaCategory(
                  category: category,
                  categories: categories,
                ),
              ));

          // Navigator.push(
          //     context,
          //     PageTransition(
          //       type: PageTransitionType.leftToRight,
          //       child: IdeaCategory(
          //         category: category,
          //       ),
          //     ));
        },
        child: Text(
          category,
        ));
  }
}
