import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isMultiline;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiline ? 4 : 1,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
