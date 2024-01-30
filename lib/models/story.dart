// This file is for saving and loading stories locally. Currently not being used in the App

class Story {
  String? title;
  String? body;

  Story(this.title, this.body);

  Story.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;

    return data;
  }
}