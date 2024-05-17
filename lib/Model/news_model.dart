
class News {
  String? id;
  String? subject;
  String? description;
  String? image;
  String? link;

  News({
    this.id,
    this.subject,
    this.description,
    this.image,
    this.link,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    subject: json["Subject"],
    description: json["Description"],
    image: json["Image"],
    link: json["Link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Subject": subject,
    "Description": description,
    "Image": image,
    "Link": link,
  };
}
