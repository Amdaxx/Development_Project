import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow[700],
          ),
        ),
        Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.outline,
        ),
      ],
    );
  }
}