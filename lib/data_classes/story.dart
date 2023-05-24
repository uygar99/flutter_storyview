class Story {
  String title;
  String content;
  String? caption;
  bool isWatched;

  Story(
      {required this.title,
      required this.content,
      this.caption,
      required this.isWatched});

  factory Story.fromJson(Map<String, dynamic> json) => Story(
      title: json["title"],
      content: json["content"],
      caption: json["caption"],
      isWatched: json["isWatched"]);

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "caption": caption,
        "isWatched": isWatched
      };
}
