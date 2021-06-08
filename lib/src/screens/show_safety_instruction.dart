import 'package:flutter/material.dart';

/// A model to provide a safety instruction
/// as a image.
///
class ImageModel {
  /// Creates an image.
  const ImageModel({
    required this.imageRef,
  });

  /// The path to the image.
  final imageRef;
}

class ShowSafetyInstructionScreen extends StatelessWidget {
  /// The route name for this screen.
  static const String route = '/show_safetycard';

  @override
  Widget build(BuildContext context) {
    /// The arguments for this screen.
    ///
    /// [args] is initialized with a image reference.
    final args = ModalRoute.of(context)!.settings.arguments as ImageModel;

    return Image.network(args.imageRef);
  }
}
