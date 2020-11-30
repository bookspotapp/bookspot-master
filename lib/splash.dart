import 'package:flutter/material.dart';

class BgImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
          "ASSETS/logo.jpg",
          fit: BoxFit.cover,
    );
  }
}
