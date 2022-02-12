import 'package:flutter/material.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  Color kSelectedFillColor = Colors.black;
  Color kfillColor = Colors.grey.shade200;
  Color kTextColor = Colors.grey.shade500;
  Color kselectedTextColor = Colors.white;
  String checker = ' ';

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.grey[200]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  checker = 'notes';
                });
              },
              child: Text('Notes',
                  style: TextStyle(
                      color: checker == 'notes'
                          ? kselectedTextColor
                          : kTextColor)),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  minimumSize: const Size(100, 40),
                  primary: checker == 'notes' ? kSelectedFillColor : kfillColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  checker = 'Highlights';
                });
              },
              child: Text('Highlights',
                  style: TextStyle(
                      color: checker == 'Highlights'
                          ? kselectedTextColor
                          : kTextColor)),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  minimumSize: const Size(100, 40),
                  primary:
                      checker == 'Highlights' ? kSelectedFillColor : kfillColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  checker = 'Fav';
                });
              },
              child: Text('Favorite Notes',
                  style: TextStyle(
                      color:
                          checker == 'Fav' ? kselectedTextColor : kTextColor)),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  minimumSize: const Size(100, 40),
                  primary: checker == 'Fav' ? kSelectedFillColor : kfillColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            )
          ],
        ));
  }
}
