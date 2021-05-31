import 'package:flutter/material.dart';

class ImageModel {
  ImageModel({
    required this.imageRef,
  });

  final imageRef;
}

class SafetyInstructionScreen extends StatelessWidget {
  static const String route = '/safetycard';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ImageModel;

    return Image.network(args.imageRef);
  }
}
