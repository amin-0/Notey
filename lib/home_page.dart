import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notey/add_note.dart';
import 'package:notey/appbar_section.dart';
import 'package:notey/edit_note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

// create an object to read data from your Cloud forestore
// your document is arranged by 'time' which is a timestamp or else the document will be scattered
  final ref = FirebaseFirestore.instance
      .collection("notes")
      .orderBy("time", descending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              // changes the screen to the add note page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddNote()));
            },
          ),
        ),
        body: NotesSection(ref: ref));
  }
}

class NotesSection extends StatelessWidget {
  const NotesSection({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final Query<Map<String, dynamic>> ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      color: const Color(0xff252525),
      child: Column(
        children: [
          const NoteAppBar(),
          Expanded(
            child: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return MasonryGridView.count(
                      crossAxisCount: 2,
                      itemCount:
                          snapshot.hasData ? snapshot.data?.docs.length : 0,
                      itemBuilder: (context, index) {
                        return NoteTile(
                          ref: ref,
                          noteColor: noteColors[index % 7],
                          docToEdit: snapshot.data!.docs[index],
                          title: snapshot.data?.docs[index]['title'],
                          date: snapshot.data?.docs[index]['date'],
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile(
      {required this.ref,
      required this.docToEdit,
      required this.title,
      required this.date,
      required this.noteColor,
      Key? key})
      : super(key: key);

  final DocumentSnapshot docToEdit;
  final String title;
  final String date;
  final Color noteColor;
  final Query ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditNote(
                      docToEdit:
                          docToEdit, //docToEdit is passed from the notetile to the edit note page
                      ref: ref,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
            color: noteColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Container(
          alignment: Alignment.bottomLeft,
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
