import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  ValueNotifier<bool> obscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: obscure,
        builder: (context, bool value, child) => TextField(
          decoration: InputDecoration(
            suffix: InkWell(
              onTap: () => obscure.value = !obscure.value,
              child: const Icon(Icons.remove_red_eye),
            ),
          ),
          controller: widget.controller,
          obscureText: value,
        ),
      );
}
