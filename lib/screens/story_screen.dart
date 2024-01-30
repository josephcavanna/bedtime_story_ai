import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bedtime_story_ai/models/artworks.dart';
import 'package:flutter/material.dart';
import 'prompt_page.dart';

class StoryScreen extends StatefulWidget {
  static const String id = 'story_screen';
  final String? storyTitle;
  final String? storyText;

  const StoryScreen({this.storyTitle, this.storyText, super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  String? storyText;
  final _artworks = Artworks();
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white;
    const color = Colors.blue;
    final image = AssetImage(
        'lib/images/${_artworks.artworks[_random.nextInt(_artworks.artworks.length)]}');
    final backButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: 250,
      child: FloatingActionButton(
        onPressed: () => Navigator.of(context).popAndPushNamed(PromptPage.id),
        backgroundColor: color.withOpacity(0.6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        mini: true,
        isExtended: true,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: textColor,
            ),
            Text(
              'Back to Your Stories',
              style: TextStyle(color: textColor),
            )
          ],
        ),
      ),
    );
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: image, fit: BoxFit.fitHeight),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 70.0, left: 20, right: 20, bottom: 30),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      widget.storyTitle!.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          widget.storyText!,
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          speed: const Duration(
                            milliseconds: 80,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: false,
                    ),
                    backButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
