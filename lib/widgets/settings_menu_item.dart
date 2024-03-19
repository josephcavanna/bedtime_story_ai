import 'package:flutter/material.dart';

class SettingsMenuItem extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget? trailing;
  const SettingsMenuItem({super.key, this.icon, this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;
    const fontSize = 16.0;

    return SizedBox(
      height: 55,
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: iconSize,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
            trailing!,
          ],
        ),
      ),
    );
  }
}
