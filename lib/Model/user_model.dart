
class User {
  String? id;
  String? name;
  String? email;
  String? mobile;

  User({
    this.id,
    this.name,
    this.email,
    this.mobile
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email:json["Email"],
    mobile:json["Phone"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "Email":email,
    "Phone":mobile
  };
}
