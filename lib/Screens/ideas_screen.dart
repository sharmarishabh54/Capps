import 'package:capps/components/components.dart';
import 'package:capps/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:capps/services/providers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IdeasScreen extends ConsumerWidget {
  const IdeasScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      resizeToAvoidBottomInset: false,
      body: watch(firebaseIdeaProvider).when(
        loading: () => const Center(
          child: const Center(
              child: SpinKitPouringHourglass(color: Color(0xffe53935))),
        ),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (ideas) {
          return IdeaListView();
        },
      ),
    );
  }
}

// body: CustomScrollView(
//         slivers: <Widget>[
//           SliverList(delegate: SliverChildBuilderDelegate((context, index) {
//             return Container();
//           }))
//         ],
//       ),
