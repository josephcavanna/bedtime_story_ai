import 'package:bedtime_story_ai/screens/prompt_page.dart';
import '../screens/registration_page.dart';
import '../screens/signin_page.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';

class InitialPage extends StatefulWidget {
  static const String id = 'initial_page';
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _auth = Auth();

  final _tabs = const {
    'tabs': [
       Tab(
        text: 'Register',
      ),
      Tab(
        text: 'Sign In',
      ),
    ],
    'pages': [
       RegistrationPage(),
      SignInPage(),
    ]
  };

  void getCurrentUser() {
    final signedIn = _auth.signedIn();
    if (signedIn != false) {
      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => Navigator.pushNamed(context, PromptPage.id));
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.blue;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Colors.blue[300],
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/book_artwork7.png'),
                fit: BoxFit.cover),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.6),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabBar(
                    dividerColor: color[300],
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withOpacity(0.5),
                    indicatorColor: color[800],
                    tabs: _tabs['tabs']!,
                  ),
                  SizedBox(
                    height: 350,
                    child: TabBarView(
                      children: _tabs['pages']!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
