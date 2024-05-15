import 'package:flutter/material.dart';

List icons = [
  Icons.visibility_sharp,
  Icons.visibility_off_sharp,
];

class FormFieldWidget {
  formField(
      {required String label,
      required TextEditingController controller,
      required bool obscure,
      required bool showToggle,
      void Function()? toggle,
      required BuildContext context,
      Widget? prefixIcon}) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        prefix: prefixIcon,
        suffixIcon: showToggle
            ? IconButton(
                onPressed: toggle,
                icon: Icon(obscure ? icons[1] : icons[0]),
                color: Colors.white,
                visualDensity: VisualDensity.compact,
              )
            : const SizedBox(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[700]!),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
      ),
      obscureText: obscure,
    );
  }
}
