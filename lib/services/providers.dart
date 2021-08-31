import 'package:capps/models/models.dart';
import 'package:capps/models/thinker_model.dart';
import 'package:capps/services/Ideas_provider.dart';
import 'package:capps/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listProvider = Provider<List<Idea>>((ref) {
  var x = ref.read(firebaseIdeaProvider);
  List<Idea> y;
  x.whenData((value) {
    for (var i in value) y.add(i);
  });
  return y;
});

final ideasListProvider = StateNotifierProvider<IdeaList>((ref) {
  // var x = ref.read(firebaseIdeaProvider);
  // List<Idea> y;
  // var z = x.whenData((value) {
  //   for (var i in value) y.add(i);
  //   return 0;
  // });
  // return IdeaList(y);
  return IdeaList([for (var i in ideas) Idea.fromJson(i)]);
});

enum IdeasListFilter {
  top,
  all,
  latest,
  mostLoved,
}

final ideasListFilter = StateProvider((_) => IdeasListFilter.top);

final filteredIdeas = Provider<List<Idea>>((ref) {
  final filter = ref.watch(ideasListFilter);
  final ideas = ref.watch(ideasListProvider.state);

  switch (filter.state) {
    case IdeasListFilter.top:
      {
        ideas.sort((a, b) => a.rank.compareTo(b.rank));
        return ideas.sublist(0, 20);
      }
      break;
    case IdeasListFilter.all:
      {
        ideas.sort((a, b) => a.title.compareTo(b.title));
        return ideas;
      }
      break;
    case IdeasListFilter.mostLoved:
      return ideas;
    case IdeasListFilter.latest:
      {
        ideas.sort((b, a) => a.rank.compareTo(b.rank));
        return ideas.sublist(0, 20);
      }
      break;
    default:
      return ideas;
  }
});

// FirebaseFirestore firestore = FirebaseFirestore.instance;

// final firbaseStateProvider = StreamProvider.autoDispose((ref) {
//   // List list;
//   // final l = FirebaseFirestore.instance
//   //     .collection('ideas')
//   //     .get()
//   //     .then((querySnapshot) {
//   //   querySnapshot.docs.forEach((result) {
//   //     list.add(result);
//   //   });
//   //   // final x=l.documents;
//   //   // firestoreInstance.collection("users").get().then((querySnapshot) {
//   //   //   querySnapshot.docs.forEach((result) {
//   //   //     print(result.data());
//   //   //   });
//   // });
//   // List list;
//   // final l = FirebaseFirestore.instance.collection('ideas').snapshots();
//   // l.forEach((element) {
//   //   list.add(element);
//   // });

//   return FirebaseFirestore.instance
//       .collection('ideas')
//       .snapshots()
//       .map((query) => query.docs.map((e) => Idea.fromJson(e.data())));
// });

final firebaseIdeaProvider = StreamProvider.autoDispose<List<Idea>>((ref) {
  final stream = FirebaseFirestore.instance.collection('ideas').snapshots();
  return stream.map((snapshot) =>
      snapshot.docs.map((doc) => Idea.fromJson(doc.data())).toList());
});

final firebaseUserProvider = StreamProvider.autoDispose<List<Thinker>>((ref) {
  final stream = FirebaseFirestore.instance.collection('users').snapshots();
  return stream.map((snapshot) =>
      snapshot.docs.map((doc) => Thinker.fromJson(doc.data())).toList());
});

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authStateChangedProvider = StreamProvider<User>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final authServiceProvider = Provider<AuthService>((ref) {
  final _auth = ref.watch(firebaseAuthProvider);
  final _store = ref.watch(firestoreProvider);
  return AuthService(_auth, _store);
});
