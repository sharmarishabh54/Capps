import 'package:capps/constants.dart';
import 'package:capps/models/models.dart';
import 'package:capps/services/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddIdeaScreen extends StatefulWidget {
  @override
  _AddIdeaScreenState createState() => _AddIdeaScreenState();
}

class _AddIdeaScreenState extends State<AddIdeaScreen> {
  // CollectionReference ideas = FirebaseFirestore.instance.collection('ideas');
  // Future<void> addUser(Idea idea) {
  //   // Call the user's CollectionReference to add a new user
  //   return ideas
  //       .add(idea.toJson())
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference ideasF = FirebaseFirestore.instance.collection('ideas');
  addFireIdea(Idea i) {
    // Call the user's CollectionReference to add a new user
    var x = ideasF.doc(i.id);
    print("Add Start");
    x
        .set(i.toJson())
        .then((value) => print("New Idea Added"))
        .catchError((error) => print("Failed to add Idea: $error"));
    print("Add End");
  }

  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  String _selectedCategory;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Title",
                      style: kHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a Title',
                        //labelText: "Title",
                        labelStyle: kHeadingTextStyle,
                      ),
                      controller: _titleController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Title cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description",
                      style: kHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 6,
                      maxLines: 10,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //labelText: "Description",
                        hintText: 'Enter Description',
                        labelStyle: TextStyle(fontSize: 15),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Description cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      width: 300,
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        validator: (value) {
                          if (value == null) {
                            return "Please Chose a Category";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(border: InputBorder.none),
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select Category'),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        items: [
                          for (var i in categories)
                            DropdownMenuItem(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    i['title'],
                                    style: kHeadingTextStyle,
                                  ),
                                  Container(
                                    height: 40,
                                    child: IconButton(
                                      icon: SvgPicture.asset(i['iconUrl']),
                                      onPressed: null,
                                    ),
                                  ),
                                ],
                              ),
                              value: i['title'],
                            )
                        ],
                      ),
                    ),
                  ],
                ),
                Consumer(builder: (context, watch, child) {
                  final authUser = watch(authStateChangedProvider).data?.value;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                          height: 45,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                var length = context.read(firebaseIdeaProvider);
                                int len = 0;
                                length.whenData((value) {
                                  len = value.length.toInt();
                                });
                                print(len);
                                Idea i = Idea(
                                    title: _titleController.text,
                                    thinker: authUser.displayName,
                                    rating: Rating(score: 0.0, count: 0),
                                    category: _selectedCategory,
                                    rank: len + 1,
                                    description: _descriptionController.text);
                                // context.read(ideasListProvider).add(i);
                                print(_selectedCategory);
                                addFireIdea(i);
                                Navigator.pop(context);
                              }

                              // addUser(Idea(
                              //     title: _titleController.text,
                              //     thinker: "Shahadat",
                              //     rating: Rating(score: 0, count: 0),
                              //     categories: [_selectedCategory],
                              //     rank: length + 1,
                              //     description: _descriptionController.text));
                              // Navigator.pop(context);
                            },
                            child: Text(
                              "Add Idea",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          )),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
