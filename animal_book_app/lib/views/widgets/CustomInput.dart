import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class  CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  final int maxLines;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) validator;
  final Function(String) onSaved;

  // Construtor
  CustomInput({
    @required this.controller,
    @required this.hint,
    this.obscure = false,
    this.autofocus = false,
    this.type = TextInputType.text,
    this.inputFormatters,
    this.maxLines,
    this.validator,
    this.onSaved, bool obscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: this.obscure,
      autofocus: this.autofocus,
      keyboardType: this.type,
      inputFormatters: this.inputFormatters,
      style: TextStyle(fontSize: 18),
      validator: this.validator,
      maxLines: this.maxLines,
      onSaved: this.onSaved,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
          hintText: this.hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6)
        )
      ),
    );
  }
}