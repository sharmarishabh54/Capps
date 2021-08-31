class Thinker {
  String email;
  String name;
  String uid;
  String status;
  List<String> rated;
  int age;

  Thinker({this.email, this.name, this.uid, this.status, this.rated, this.age});

  Thinker.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    uid = json['uid'];
    status = json['status'];
    rated = json['rated'].cast<String>();
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['uid'] = this.uid;
    data['status'] = this.status;
    data['rated'] = this.rated;
    data['age'] = this.age;
    return data;
  }
}
