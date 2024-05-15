import 'package:bedtime_story_ai/screens/story_screen.dart';
import 'package:bedtime_story_ai/widgets/example_stories_widget.dart';
import 'package:bedtime_story_ai/widgets/profile_widget.dart';
import 'package:bedtime_story_ai/widgets/stories_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../api/api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PromptPage extends StatefulWidget {
  static const String id = 'prompt_page';
  final String? pushedEmail;
  const PromptPage({super.key, this.pushedEmail});
  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  final supabase = Supabase.instance.client;
  final controller = TextEditingController();
  final email = Supabase.instance.client.auth.currentUser?.email;
  final exampleStoriesWidget = ExampleStoriesWidget();
  late OpenAI openAI;
  String? storyText;
  bool _isLoading = false;
  final gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.indigo,
      Colors.purple,
    ],
  );
  String? language;

  _uploadStory(title) async {
    final id = supabase.auth.currentUser?.id;
    final capitalizedTitle =
        title.replaceFirst(title[0], title[0].toUpperCase());
    await supabase.from('stories').insert({
      'title': capitalizedTitle,
      'text': storyText,
      'id': id,
    });
  }

  Future<ChatCTResponse?>? _generateStory;
  void _generateStoryPrompt(String title) {
    _isLoading = true;
    final request = ChatCompleteText(
      messages: [
        Messages(
          role: Role.user,
          content:
              "Using the following sentence: $title, write me a children's bedtime story in the style of Roald Dahl in $language that rhymes.",
  ).toJson(),
      ],
      model: GptTurbo0301ChatModel(),
      maxToken: 350,
      temperature: 0.5,
    );
    setState(() {
      _generateStory = openAI.onChatCompletion(request: request);
    });
    if (_generateStory != null) {
      _generateStory!.then((value) {
        setState(() {
          storyText = value!.choices[0].message!.content;
        });
        _uploadStory(title);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryScreen(
              storyTitle: title,
              storyText: storyText,
            ),
          ),
        );
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(microseconds: 1500),
          content: Text('Please try again'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  _checkLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? updatedLanguage = prefs.getString('language');
    language = updatedLanguage ?? 'English';
  }

  @override
  void initState() {
    openAI = OpenAI.instance.build(
      token: openAIApiKey,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(
          seconds: 30,
        ),
        connectTimeout: const Duration(
          seconds: 30,
        ),
      ),
    );
    _checkLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const height = 50.0;
    const borderRadius = 25.0;
    const fontSize = 14.0;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Colors.black.withOpacity(0.8),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StoriesAppbarWidget(),
              ProfileWidget(
                email: email ?? widget.pushedEmail,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/book_tree.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _isLoading
            ? const Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      height: 75,
                      width: MediaQuery.of(context).size.width,
                      child: exampleStoriesWidget.generateExampleStories(),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            height: height,
                            child: TextField(
                              controller: controller,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                              ),
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                isDense: true,
                                // contentPadding: EdgeInsets.only(bottom: 20, left: 20, right: 20)
                                filled: false,
                                hintText: 'Enter a story title',
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: fontSize),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(borderRadius),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                height: height,
                                decoration: BoxDecoration(
                                  gradient: gradient,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.indigo,
                                        blurRadius: 24,
                                        offset: Offset(0, 0),
                                        blurStyle: BlurStyle.outer),
                                    BoxShadow(
                                        color: Colors.purple,
                                        blurRadius: 24,
                                        offset: Offset(0, 0),
                                        blurStyle: BlurStyle.outer)
                                  ],
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Go!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (controller.text.isNotEmpty) {
                                  setState(() {
                                 _checkLanguage().then((value) => _generateStoryPrompt(controller.text));
                                });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please enter a story title'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(milliseconds: 1500),
                                    ),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}