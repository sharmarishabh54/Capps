import 'package:capps/components/components.dart';
import 'package:capps/models/models.dart';
import 'package:capps/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:capps/size_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 10),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "Hi,\n",
              style: kSubHeadingTextStyle,
              children: [
                TextSpan(
                  text: "Mark",
                  style: kHeadingTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          buildSearch(),
          Text(
            "Ideas",
            style: kHeadingTextStyle,
          ),
          Toolbar(),
          Consumer(
            builder: (context, watch, child) {
              List<Idea> ideasList = watch(filteredIdeas);
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  //scrollDirection: Axis.vertical,
                  itemCount: ideasList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListCard(
                      index: index,
                      idea: ideasList[index],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Container buildSearch() {
  return Container(
    color: Color(0xffD7E8F8),
    width: SizeConfig.screenWidth,
    height: 44,
    child: Row(
      children: [
        IconButton(
            icon: SvgPicture.asset('assets/icons/search.svg'),
            onPressed: () {}),
        Center(
          child: Text(
            "Search  Ideas",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
      ],
    ),
  );
}
