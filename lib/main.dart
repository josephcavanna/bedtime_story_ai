import 'package:bedtime_story_ai/api/api_key.dart';
import 'package:bedtime_story_ai/screens/data_page.dart';
import 'package:bedtime_story_ai/screens/initial_page.dart';
import 'package:bedtime_story_ai/screens/prompt_page.dart';
import 'package:bedtime_story_ai/screens/signin_page.dart';
import 'package:bedtime_story_ai/screens/stories_page.dart';
import 'home_page.dart';
import '/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  const url = 'https://fgnapsdwhjqqfoafbvzn.supabase.co';
  await Supabase.initialize(url: url, anonKey: supabaseApiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      title: 'Goodnight Story AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      initialRoute: InitialPage.id,
      routes: {
        InitialPage.id: (context) => const InitialPage(),
        PromptPage.id: (context) => const PromptPage(),
        HomePage.id: (context) => const HomePage(),
        RegistrationPage.id: (context) => const RegistrationPage(),
        SignInPage.id: (context) => const SignInPage(),
        DataPage.id: (context) => const DataPage(),
        StoriesPage.id: (context) => const StoriesPage(),
      },
    );
  }
}
