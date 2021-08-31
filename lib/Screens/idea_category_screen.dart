import 'package:capps/components/components.dart';
// import 'package:capps/components/list_card.dart';
import 'package:capps/constants.dart';
// import 'package:capps/services/providers.dart';
import 'package:capps/models/models.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class IdeaCategory extends StatelessWidget {
  final String category;
  final List<Idea> categories;
  const IdeaCategory({this.categories, this.category});
  @override
  Widget build(BuildContext context) {
    List<Idea> ideaCategories =
        categories.where((item) => item.category.contains(category)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: kBackgroundColour,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: double.infinity,
          height: double.infinity,
          color: kBackgroundColour,
          child: ideaCategories.length == 0
              ? Center(
                  child: Text("No Ideas in the $category category yet"),
                )
              : CategoryListView(
                  category: category,
                )),
    );
  }
}
