import 'package:bedtime_story_ai/screens/account_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String? email;

  const ProfileWidget({this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final initial = email?[0].toUpperCase();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green[900],
              radius: 20,
              child: Text(
                initial ?? 'A',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              email ?? 'Profile',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => Scaffold(
                backgroundColor: Colors.transparent,
                bottomSheet: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: const Material(
                    color: Colors.transparent,
                    child: SingleChildScrollView(child: AccountPage()),
                  ),
                ),
              ),
            );
          },
          icon: const Icon(Icons.settings),
        ),
      ]),
    );
  }
}
