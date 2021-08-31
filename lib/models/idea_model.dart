import 'package:uuid/uuid.dart';

import 'models.dart';

var _uuid = Uuid();

class Idea {
  String title;
  String thinker;
  String id;
  String description;
  int rank;
  Rating rating;
  String category;
  String status;

  Idea(
      {this.title,
      this.thinker,
      this.description,
      this.rank,
      this.rating,
      this.category,
      String id,
      this.status = "approved"})
      : id = id ?? _uuid.v4();

  Idea.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thinker = json['thinker'];
    id = json['id'];
    status = json['status'];
    description = json['description'];
    rank = json['rank'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thinker'] = this.thinker;
    data['id'] = id;
    data['status'] = status;
    data['description'] = this.description;
    data['rank'] = this.rank;
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['category'] = this.category;
    return data;
  }
}
