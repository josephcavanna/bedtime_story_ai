import 'package:bedtime_story_ai/screens/prompt_page.dart';
import 'package:bedtime_story_ai/screens/stories_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _pages = const [PromptPage(), StoriesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) => setState(() {
                _selectedIndex = value;
              }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'New Story',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Stories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ]),
    );
  }
}
