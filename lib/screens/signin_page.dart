import 'package:bedtime_story_ai/screens/prompt_page.dart';
import 'package:flutter/material.dart';
import 'package:bedtime_story_ai/services/auth.dart';

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
  bool _isLoading = false;

  formField(String labelText, TextEditingController controller) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[700]!),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
      obscureText: labelText == 'Password' ? true : false,
    );
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
                formField('Email', _emailController),
                const SizedBox(
                  height: 20,
                ),
                formField('Password', _passwordController),
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
                      final email = _emailController.text;
                      email.isEmpty
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Please enter your email'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'))
                                ],
                              ),
                            )
                          :
                          _auth.resetPassword(email);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                              content: Text('Password reset email sent'),
                              duration: Duration(milliseconds: 2000),
                              backgroundColor: Colors.red,
                            ));
                    },
                    child: const Text('Forgot Password?')),
              ],
            ),
          ))
        : const Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()),
          );
  }
}
