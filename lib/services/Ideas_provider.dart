import 'package:capps/models/idea_model.dart';
import 'package:state_notifier/state_notifier.dart';

class IdeaList extends StateNotifier<List<Idea>> {
  IdeaList([List<Idea> initialIdeas]) : super(initialIdeas ?? []);

  void add(Idea idea) {
    state = [
      ...state,
      idea,
    ];
  }
}
