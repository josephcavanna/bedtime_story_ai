import 'package:bedtime_story_ai/screens/data_page.dart';
import 'package:bedtime_story_ai/screens/initial_page.dart';
import 'package:bedtime_story_ai/widgets/settings_menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bedtime_story_ai/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/language_selection.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatefulWidget {
  static const String id = 'account_page';
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final languageSelection = LanguageSelection();
  final version = 'v1.0.0';
  final url = 'https://www.privacypolicies.com/live/f0bc7c1e-176e-453b-b250-7d62bf808a3b';
  String? language;
  bool isReset = false;

  Future<void> launchPrivacyPolicy() async {
    final urlParsed = Uri.parse(url);
    if (!await launchUrl(urlParsed)) {
      throw Exception('Could not launch $url');
    }
  }

  getStoredLanguage() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      if (prefs.getString('language') == null) {
        language = 'English';
      } else {
        language = prefs.getString('language');
      }
    });
    return language;
  }

  @override
  void initState() {
    getStoredLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Auth();
    String? initialLanguage = language;
    final fontSize = MediaQuery.of(context).size.width / 26;
    const iconSize = 24.0;

    final resetIcons = [
      Icons.send,
      Icons.mark_email_read
    ]; // 0 = to send, 1 = sent
    final resetIcon = isReset ? resetIcons[1] : resetIcons[0];

    signOut() {
      auth.signOut();
      Navigator.of(context).popAndPushNamed(InitialPage.id);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Settings',
                  style:
                      TextStyle(color: Colors.white, fontSize: fontSize * 1.3),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: 4.0),
            child: Text(
              'ACCOUNT',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[800],
            ),
            width: double.infinity,
            child: Column(children: [
              SettingsMenuItem(
                title: 'Email',
                icon: Icons.email,
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: Text(
                    auth.userEmail(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
              SettingsMenuItem(
                title: 'Change Password',
                icon: Icons.lock_outline_sharp,
                trailing: TextButton(
                  onPressed: () {
                    auth.resetPassword(auth.userEmail());
                    setState(() {
                      isReset = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1500),
                        content: Text('Reset password email sent'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  child: Icon(resetIcon, color: Colors.grey),
                ),
              ),
              SettingsMenuItem(
                title: 'Data Management',
                icon: Icons.library_books_outlined,
                trailing: IconButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        child: const Material(
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                            child: DataPage(),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: 4.0),
            child: Text('APP SETTINGS',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[800],
            ),
            width: double.infinity,
            child: SettingsMenuItem(
              icon: Icons.language,
              title: 'Story Language',
              trailing: SizedBox(
                height: 50,
                child: FittedBox(
                  child: DropdownMenu(
                    menuStyle: MenuStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[600]!),
                    ),
                    trailingIcon:
                        const Icon(Icons.expand_sharp, color: Colors.grey),
                    textStyle:
                        const TextStyle(color: Colors.grey, fontSize: 20),
                    dropdownMenuEntries:
                        languageSelection.dropDownMenuEntries(),
                    initialSelection: initialLanguage,
                    onSelected: (value) => setState(() {
                      _prefs.then((SharedPreferences prefs) {
                        prefs.setString('language', value.toString());
                      });
                    }),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: 4.0),
            child: Text('ABOUT',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[800],
            ),
            width: double.infinity,
            child: Column(
              children: [
                SettingsMenuItem(
                  icon: Icons.lock_outline_sharp,
                  title: 'Privacy Policy',
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      launchPrivacyPolicy();
                    },
                  ),
                ),
                SettingsMenuItem(
                  icon: Icons.menu_book_rounded,
                  title: 'Bedtime Story AI',
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Text(
                      version,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[800],
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.logout_sharp,
                        color: Colors.red,
                        size: iconSize,
                      ),
                      TextButton(
                        onPressed: () {
                          signOut();
                        },
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
