import 'package:flutter/material.dart';

class ListNote extends StatelessWidget {
  const ListNote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'List Notes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Text(
                'All Notes',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Stack(alignment: Alignment.center, children: const [
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 35,
                  ),
                )
              ])
            ],
          )
        ],
      ),
    );
  }
}
