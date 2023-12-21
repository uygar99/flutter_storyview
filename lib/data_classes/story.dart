class Story {
  String title;
  String content;
  String? caption;
  bool isWatched;
  bool? isVideo;
  int? duration;

  Story(
      {required this.title,
      required this.content,
      this.caption,
      required this.isWatched,
      this.isVideo,
      this.duration});

  factory Story.fromJson(Map<String, dynamic> json) => Story(
      title: json["title"],
      content: json["content"],
      caption: json["caption"],
      isWatched: json["isWatched"],
      isVideo: json.containsKey("isVideo") ? true : false,
      duration: json.containsKey("duration") ? json["duration"] : 0);

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "caption": caption,
        "isWatched": isWatched,
        "isVideo": isVideo,
        "duration": duration
      };
}
