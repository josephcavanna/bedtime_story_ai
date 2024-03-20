import 'package:bedtime_story_ai/screens/prompt_page.dart';
import 'package:flutter/material.dart';
import 'package:bedtime_story_ai/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/form_field_widget.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'signin_page';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = Auth();
  final formFieldWidget = FormFieldWidget();
  bool _isLoading = false;

  Future<void> sendtoUrl(String url) async {
    final urlParsed = Uri.parse(url);
    if (!await launchUrl(urlParsed, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Form(
            child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                formFieldWidget.formField('Email', _emailController),
                const SizedBox(
                  height: 20,
                ),
                formFieldWidget.formField('Password', _passwordController),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _auth.signIn(
                        _emailController.text, _passwordController.text);
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      if (_auth.signedIn() == true) {
                        Navigator.of(context).pushNamed(PromptPage.id);
                        setState(() {
                          _isLoading = false;
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    const Text('Incorrect email or password'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Try Again'))
                                ],
                              );
                            });
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  },
                  child: const Text('Sign In',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                    onPressed: () {
                      sendtoUrl('https://jcavanna.dev/forgot_password');
                    }, child: const Text('Forgot Password?'))
              ],
            ),
          ))
        : const Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()),
          );
  }
}
