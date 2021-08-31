class Category {
  String title;
  String tag;
  String iconUrl;

  Category({this.title, this.tag});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    tag = json['tag'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['iconUrl'] = this.iconUrl;
    return data;
  }
}
