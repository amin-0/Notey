import 'package:flutter/material.dart';

class NoteAppBar extends StatelessWidget {
  const NoteAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        alignment: Alignment.centerLeft,
        child: const Text(
          'Notes',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }
}
