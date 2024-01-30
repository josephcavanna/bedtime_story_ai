import 'package:bedtime_story_ai/widgets/stories_widget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoriesPage extends StatefulWidget {
  static const String id = 'stories_page';
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesState();
}

class _StoriesState extends State<StoriesPage> {
  final supabase = Supabase.instance.client;
  final storiesWidget = const StoriesWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Stories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/forest_library.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: storiesWidget,
      ),
    );
  }
}
