import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function(String?)? validator;
  final String hintText;
  final int? maxLines;
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
    required this.hintText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFFFFFCFC),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator:
              validator != null ? (String? value) => validator!(value) : null,
          style: TextStyle(color: Colors.white),
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Color(0xff282828),
            hintStyle: TextStyle(
              color: Color(0xff6D6D6D),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          cursorColor: Colors.white,
        ),
      ],
    );
  }
}
