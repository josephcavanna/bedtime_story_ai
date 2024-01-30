import 'package:bedtime_story_ai/animations/staggered_slide_transition.dart';
import 'package:bedtime_story_ai/models/example_stories.dart';
import 'package:flutter/material.dart';

import '../screens/story_screen.dart';

class ExampleStoriesWidget  {
final exampleStories = ExampleStories().exampleStories;  

generateExampleStories() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: exampleStories.length,
      itemBuilder: (context, index) {
        final story = exampleStories[index];
        final title = story.title;
        final text = story.text;
        return StaggeredSlideTransition(
          index: index,
          width: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 250,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(25),
                ),
            
                child: ListTile(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                  ),
                  iconColor: Colors.transparent,
                  textColor: Colors.white,
                  tileColor: Colors.transparent,
                  title: Text(
                    title!,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => StoryScreen(
                          storyTitle: title,
                          storyText: text,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}