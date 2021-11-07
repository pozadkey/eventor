import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
      child: Column(
        children: [
          Icon(
            Icons.list,
            color: Colors.grey[500],
          ),
          Text(
            'You have an empty list.',
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
