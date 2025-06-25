import 'dart:convert';
import 'package:flutter/material.dart';

class CardImg extends StatelessWidget {
  final String img;
  const CardImg({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    final bytes = base64Decode(img);

    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
