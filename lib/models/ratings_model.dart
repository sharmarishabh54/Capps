class Rating {
  double score;
  int count;

  Rating({this.score, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    score = json['score'] == null ? 0.0 : json['score'].toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['count'] = this.count;

    return data;
  }
}
