import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'models/story.dart';

// This file is for saving and loading stories locally. Currently not being used in the App

List<Story> stories = [];

class Librarian {
  final String? storyName;
  final String? storyText;

  Librarian({this.storyName, this.storyText});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/stories.json');
  }

  // Save a new story
  Future<void> saveStory() async {
    final file = await _localFile;
    Story newStory = Story(storyName, storyText);
    stories.where((element) => element.title == newStory.title).toList().isEmpty
        ? stories.add(newStory)
        : stories.add(Story(newStory.title! + stories.length.toString(), storyText));
    stories
        .map(
          (story) => story.toJson(),
        )
        .toList();
    file.writeAsStringSync(json.encode(stories));
  }

  // Delete a story
  Future<void> deleteStory() async {
    final file = await _localFile;
    stories.removeWhere((element) => element.title == storyName);
    stories
        .map(
          (story) => story.toJson(),
        )
        .toList();
    file.writeAsStringSync(json.encode(stories));
  }

  // Delete all stories
  Future<void> deleteAllStories() async {
    final file = await _localFile;
    stories.clear();
    file.writeAsStringSync(json.encode(stories));
  }

// Load stories
  Future<void> loadStories() async {
    try {
      final file = await _localFile;

      Future<void> readStoriesData(File file) async {
        final contents = await file.readAsString();
        var jsonResponse = jsonDecode(contents);

        for (var s in jsonResponse) {
          Story story = Story(s['title'], s['body']);
          stories
                  .where((element) => element.title == story.title)
                  .toList()
                  .isEmpty
              ? stories.add(story)
              : print('Story already exists');
        }
      }

      await readStoriesData(file);
    } catch (e) {
      print(e);
    }
  }
}
