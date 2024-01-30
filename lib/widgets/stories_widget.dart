import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../screens/story_screen.dart';

class StoriesWidget extends StatefulWidget {
  const StoriesWidget({super.key});

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  final supabase = Supabase.instance.client;

  FutureBuilder

generateStories({
    bool showText = true,
    int? displayedStories,
    int? maxLines = 3,
    bool ascending = false,
  }) {
    return FutureBuilder(
      future: supabase
          .from('stories')
          .select()
          .order('created_at', ascending: ascending),
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
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Color color = Colors.transparent;
              Color textColor = Colors.white;
              final story = stories[index];
              final title = story['title'];
              final favoriteIcon = [Icons.favorite_border, Icons.favorite];
              bool favorite = story['favorite'];
              return Dismissible(
                  key: Key(title),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Icon(Icons.delete),
                    ),
                  ),
                  confirmDismiss: (direction) {
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text(
                            'Do you want to remove this story from your library?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (direction) async {
                    await supabase.from('stories').delete().eq('title', title);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: ListTile(
                        iconColor: color,
                        textColor: textColor,
                        tileColor: color,
                        title: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: showText
                            ? Text(
                                story['text'],
                                maxLines: maxLines,
                              )
                            : null,
                        trailing: IconButton(
                            icon: Icon(
                              favoriteIcon[favorite ? 1 : 0],
                              color: Colors.amber,
                            ),
                            onPressed: () async {
                              await supabase
                                  .from('stories')
                                  .update({'favorite': !favorite}).eq(
                                      'title', story['title']);
                              setState(() {
                                favorite = !favorite;
                              });
                            }),
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
            itemCount: displayedStories ?? stories.length,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return generateStories();
  }
}