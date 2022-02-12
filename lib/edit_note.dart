import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final DocumentSnapshot docToEdit;
  final Query ref;
  const EditNote({Key? key, required this.docToEdit, required this.ref})
      : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool edit = true;

  @override
  void initState() {
    //initialize the content of the textfield before building the page
    title = TextEditingController(text: widget.docToEdit['title']);
    content = TextEditingController(text: widget.docToEdit['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            color: const Color(0xff252525),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  EditNoteBar(
                    // used a callback to pass false (value) when the edit button is clicked in the edit note bar
                    edit: (value) {
                      setState(() {
                        edit = value;
                      });
                    },
                    saveEdit: () {
                      // save to edited text Cloud firestore
                      widget.docToEdit.reference.update({
                        'title': title.text,
                        'content': content.text,
                      }).whenComplete(() => Navigator.pop(context));
                    },
                    delete: () {
                      // remove note from cloud forestore
                      widget.docToEdit.reference
                          .delete()
                          .whenComplete(() => Navigator.pop(context));
                    },
                    title: title,
                    content: content,
                  ),
                  TextField(
                    controller: title,
                    decoration: const InputDecoration(
                        hintText: 'Title',
                        hintStyle:
                            TextStyle(color: Color(0xff929292), fontSize: 45),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff929292)))),
                    maxLines: null,
                    readOnly: edit,
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: content,
                      maxLines: null,
                      expands: true,
                      readOnly: edit,
                      decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle:
                            TextStyle(color: Color(0xff929292), fontSize: 25),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class EditNoteBar extends StatelessWidget {
  const EditNoteBar(
      {Key? key,
      required this.title,
      required this.content,
      required this.saveEdit,
      required this.delete,
      required this.edit})
      : super(key: key);

  final TextEditingController title;
  final TextEditingController content;
  final VoidCallback saveEdit;
  final VoidCallback delete;
//call back function edit to toggle readonly in the textfields
  final Function(bool edit) edit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: saveEdit,
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                  color: Color(0xff3B3B3B),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  edit(false);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      color: Color(0xff3B3B3B),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Icon(Icons.mode_edit_outline_outlined,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: delete,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Color(0xff3B3B3B),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
