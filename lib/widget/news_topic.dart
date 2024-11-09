import 'package:flutter/material.dart';

class NewsTopic extends StatelessWidget {
  final String topic;
  final Function selectTopic;
  final bool isSelected;
  const NewsTopic({super.key, required this.topic, required this.selectTopic, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectTopic(topic);
      },
      child: Card(
        color: isSelected ? const Color.fromRGBO(20, 119, 220, 1) : Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                topic,
                style: isSelected
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                    : const TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
