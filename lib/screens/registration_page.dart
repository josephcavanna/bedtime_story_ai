import 'package:bedtime_story_ai/screens/prompt_page.dart';
import 'package:bedtime_story_ai/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:bedtime_story_ai/services/auth.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = Auth();
  final formFieldWidget = FormFieldWidget();

  _signUp() {
    final email = _emailController.text;
    final password = _passwordController.text;
    _auth.signUp(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter email and password'),
                    ),
                  );
                } else if (_passwordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Password must be at least 6 characters'),
                    ),
                  );
                } else {
                  _signUp();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PromptPage(
                        pushedEmail: _emailController.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
