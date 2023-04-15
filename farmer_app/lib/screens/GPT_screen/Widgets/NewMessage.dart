
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewMessage extends StatefulWidget {
  final chatId;
  NewMessage({required this.chatId});
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _formKey = GlobalKey<FormState>();
  String message = '';
  final _controller = new TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final isVaild = _formKey.currentState!.validate();
    final userData =
        await FirebaseFirestore.instance.doc('users/' + user!.uid).get();

    if (isVaild) {
      _formKey.currentState!.save();

      // FirebaseFirestore.instance.collection(widget.)

      FirebaseFirestore.instance.collection(widget.chatId).add({
        'text': message,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'name': userData['name'],
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                key: ValueKey('message'),
                // decoration: InputDecoration(labelText: 'Send A Message ...'),
                validator: (value) {
                  if (value!.trim().length == 0) {
                    return 'The message can\'t be empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  message = value!;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Send A Message ...',
                  filled: true,
                  fillColor: Color(0x99FFDFB0),
                  contentPadding: const EdgeInsets.only(
                    left: 14.0,
                    bottom: 6.0,
                    top: 8.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x99FFDFB0),
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
