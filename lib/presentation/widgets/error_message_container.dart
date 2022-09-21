import 'package:flutter/material.dart';

class ErrorMessageContainer extends StatelessWidget {
  final String message;

  const ErrorMessageContainer({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      key: Key('error_message'),
      child: Text(message, style: TextStyle(color: Colors.red.shade400)),
    );
  }
}
