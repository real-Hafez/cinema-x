import 'package:flutter/material.dart';

class Email_widget extends StatelessWidget {
  const Email_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          prefixIcon: const Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
