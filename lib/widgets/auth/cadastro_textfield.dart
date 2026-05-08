import 'package:flutter/material.dart';

class CadastroTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;

  final String? Function(String?)? validator;

  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const CadastroTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,

      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,

      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
      ),
    );
  }
}