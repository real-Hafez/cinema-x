import 'package:flutter/material.dart';

class Password_widget extends StatelessWidget {
  const Password_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 0,
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock),
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
