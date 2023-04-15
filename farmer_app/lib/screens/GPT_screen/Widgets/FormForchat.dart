import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FormForStartingChat extends StatefulWidget {
  const FormForStartingChat({super.key});
  static const routeName = '/createChatForm';
  @override
  State<FormForStartingChat> createState() => _FormForStartingChatState();
}

class _FormForStartingChatState extends State<FormForStartingChat> {
  String _crop = "";
  String _soil = "";
  bool _isLoading = false;
  List<String> cropSrc = ['Maize', 'Wheat', 'Barley'];
  List<String> soilSrc = ['Red', 'Black', 'Brown'];
  final uid = FirebaseAuth.instance.currentUser!.uid;

  _trySave() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_crop != "" && _soil != "") {
        await FirebaseFirestore.instance.collection('chats').add({
          'soil': _soil,
          'crop': _crop,
          'uid': uid,
          'createdAt':DateTime.now(),
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("All Fields are required"),
          ),
        );
      }
      _isLoading = false;
      Navigator.of(context).pop();
    } on PlatformException catch (err) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Stack(
                children: [
                  Image.asset(
                    'Assets/Images/background3.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: Color(0xa6FAEBEB),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton(
                        items: cropSrc.map((String item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(
                            () {
                              _crop = newVal!;
                            },
                          );
                        },
                      ),
                      DropdownButton(
                        items: soilSrc.map((String item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(
                            () {
                              _soil = newVal!;
                            },
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: _trySave,
                        child: Text('Create Chat'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
