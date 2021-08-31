import 'package:capps/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final filter = watch(ideasListFilter);
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
                          color: filter.state == IdeasListFilter.top
                              ? Colors.black
                              : Colors.grey,
                          fontSize:
                              filter.state == IdeasListFilter.top ? 17 : 13,
                        ),
                      ),
                    ),
                    onTap: () {
                      filter.state = IdeasListFilter.top;
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
                          color: filter.state == IdeasListFilter.latest
                              ? Colors.black
                              : Colors.grey,
                          fontSize:
                              filter.state == IdeasListFilter.latest ? 17 : 13,
                        ),
                      ),
                    ),
                    onTap: () {
                      filter.state = IdeasListFilter.latest;
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
                          color: filter.state == IdeasListFilter.all
                              ? Colors.black
                              : Colors.grey,
                          fontSize:
                              filter.state == IdeasListFilter.all ? 17 : 13,
                        ),
                      ),
                    ),
                    onTap: () {
                      filter.state = IdeasListFilter.all;
                    }),
              ),
            ],
          ),
        ],
      );
    });
  }
}
