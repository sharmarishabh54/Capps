import 'package:capps/components/components.dart';
import 'package:capps/models/models.dart';
// import 'package:capps/size_config.dart';
import 'package:capps/services/providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class IdeaListView extends StatefulWidget {
  const IdeaListView({
    Key key,
  }) : super(key: key);
  @override
  _IdeaListViewState createState() => _IdeaListViewState();
}

class _IdeaListViewState extends State<IdeaListView> {
  List<Idea> filteredIdeas = [];
  int initial = 0;
  List<Idea> ideasList;
  List<Idea> initialIdeasList;
  String currentFilter = 'all';
  @override
  // void initState() {
  //   setState(() {
  //     filteredIdeas = widget.ideasList;
  //   });
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer(builder: (context, watch, child) {
        return watch(firebaseIdeaProvider).when(
          loading: () => const Center(
              child: SpinKitPouringHourglass(color: Color(0xffe53935))),
          error: (err, stack) => Center(child: Text(err.toString())),
          data: (ideas) {
            ideasList = ideas;

            if (initial == 0) {
              // print("Filtered is: " + filteredIdeas.length.toString());
              filteredIdeas = initialIdeasList = ideas;
              initial = 1;
            }
            if (ideas.length != initialIdeasList.length) {
              print("Filtered is: " +
                  filteredIdeas.length.toString() +
                  "List is: " +
                  ideasList.length.toString());
              filteredIdeas = initialIdeasList = ideasList;
              print("Filtered is: " +
                  filteredIdeas.length.toString() +
                  "List is: " +
                  ideasList.length.toString());
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(builder: (context, watch, child) {
                    final authUser =
                        watch(authStateChangedProvider).data?.value;
                    final name = authUser.displayName.split(" ");
                    return RichText(
                      text: TextSpan(
                        text: "Hi,\n",
                        style: kSubHeadingTextStyle,
                        children: [
                          TextSpan(
                            text: name[0],
                            style: kHeadingTextStyle,
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 10),
                  Container(
                    color: Color(0xffD7E8F8),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset('assets/icons/search.svg'),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        hintText: "Search",
                      ),
                      onChanged: (string) {
                        var searchedIdeas = ideasList
                            .where((idea) => (idea.title
                                    .toLowerCase()
                                    .contains(string.toLowerCase()) ||
                                idea.thinker
                                    .toLowerCase()
                                    .contains(string.toLowerCase())))
                            .toList();
                        setState(() {
                          filteredIdeas = searchedIdeas;
                          print(filteredIdeas.length.toString());
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Ideas",
                    style: kHeadingTextStyle,
                  ),
                  buildToolbar(),
                  filteredIdeas.length != 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filteredIdeas.length,
                          itemBuilder: (context, index) {
                            // print(filteredIdeas[index].title +
                            //     filteredIdeas.length.toString());
                            return ListCard(
                              idea: filteredIdeas[index],
                              index: index,
                              ideas: filteredIdeas,
                            );
                          },
                        )
                      : Container(
                          height: 200,
                          child: Center(child: Text("No Ideas Found"))),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Column buildToolbar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Top",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            currentFilter == 'top' ? Colors.black : Colors.grey,
                        fontSize: currentFilter == 'top' ? 17 : 13,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      currentFilter = 'top';
                      filteredIdeas.sort((a, b) => a.rank.compareTo(b.rank));
                    });
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Latest",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: currentFilter == 'latest'
                            ? Colors.black
                            : Colors.grey,
                        fontSize: currentFilter == 'latest' ? 17 : 13,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      currentFilter = 'latest';
                      filteredIdeas.sort((b, a) => a.rank.compareTo(b.rank));
                    });
                  }),
            ),
            // Container(
            //   padding: const EdgeInsets.all(8.0),
            //   child: InkWell(
            //       child: Text(
            //         "Loved",
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: filter.state == IdeasListFilter.mostLoved
            //               ? Colors.black
            //               : Colors.grey,
            //           fontSize:
            //               filter.state == IdeasListFilter.mostLoved ? 17 : 13,
            //         ),
            //       ),
            //       onTap: () {
            //         filter.state = IdeasListFilter.mostLoved;
            //       }),
            // ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "All",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            currentFilter == 'all' ? Colors.black : Colors.grey,
                        fontSize: currentFilter == 'all' ? 17 : 13,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      currentFilter = 'all';
                      filteredIdeas.sort((a, b) => a.title.compareTo(b.title));
                    });
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
