import 'package:bedtime_story_ai/animations/staggered_fade_transition.dart';
import 'package:bedtime_story_ai/screens/stories_page.dart';
import 'package:bedtime_story_ai/services/auth.dart';
import 'package:flutter/material.dart';
import '../screens/story_screen.dart';

class StoriesAppbarWidget extends StatefulWidget {
  const StoriesAppbarWidget({super.key});

  @override
  State<StoriesAppbarWidget> createState() => _StoriesAppbarWidgetState();
}

class _StoriesAppbarWidgetState extends State<StoriesAppbarWidget> {
  favoriteStories() {
    return FutureBuilder(
      future: supabase.from('stories').select().eq('favorite', true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final stories = snapshot.data!;
          return stories.length == 0
              ? const ListTile(
                  title: Text(
                    'Go to your stories to add a favorite!',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Color color = Colors.transparent;
                    Color textColor = Colors.white;
                    final story = stories[index];
                    final title = story['title'];
                    return StaggeredFadeTransition(
                      index: index,
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                            minVerticalPadding: 0.0,
                            iconColor: color,
                            textColor: textColor,
                            tileColor: color,
                            title: Text(
                              title,
                              style: const TextStyle(fontSize: 14),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => StoryScreen(
                                    storyTitle: story['title'],
                                    storyText: story['text'],
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  },
                  itemCount: stories.length,
                );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Favorite Stories',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: favoriteStories(),
              ),
              const Divider(
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.book,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'All Stories',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () =>
                          Navigator.of(context).popAndPushNamed(StoriesPage.id),
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
