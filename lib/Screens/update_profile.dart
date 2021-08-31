import 'package:capps/constants.dart';
import 'package:capps/services/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  String age, status;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final _store = watch(firestoreProvider);
      final authUser = watch(authStateChangedProvider).data?.value;
      DocumentReference reference =
          _store.collection('users').doc(authUser.uid);
      updateUser(age, status) {
        reference.update({
          'status': status,
          'age': age,
        });
      }

      return Scaffold(
        backgroundColor: kBackgroundColour,
        body: Container(
          padding: EdgeInsets.all(10),
          color: kBackgroundColour,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Enter Your Details",
                  style: kTitleTextStyle,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Age cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String val) {
                    age = val;
                  },
                  decoration: InputDecoration(
                    labelText: "Age",
                    hintText: "e.g 14",
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: InputDecoration(border: InputBorder.none),
                  iconSize: 30,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please Chose a Status";
                    } else {
                      return null;
                    }
                  },
                  hint: Text('Select Status'),
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'Student',
                        style: kHeadingTextStyle,
                      ),
                      value: 'Student',
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Professional',
                        style: kHeadingTextStyle,
                      ),
                      value: 'Professional',
                    )
                  ],
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      updateUser(int.parse(age), status);
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        print(int.parse(age));
                      });
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
