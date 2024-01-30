import 'package:flutter/material.dart';

class LanguageSelection {

    final languages = [
      'English',
      'Swedish',
      'Dutch',
      'Spanish',
      'Italian',
      'Portuguese',
      'Romanian',
    ];

    dropDownMenuEntries() {
      final List<DropdownMenuEntry<String>> items = [];
      for (final language in languages) {
        items.add(
          DropdownMenuEntry(
              value: language,
              label: language,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )),
        );
      }
      return items;
    }
}