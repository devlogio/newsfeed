import 'package:flutter/material.dart';

class NewsTopic extends StatelessWidget {
  final String topic;
  const NewsTopic({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(topic),
          ],
        ),
      ),
    );
  }
}
