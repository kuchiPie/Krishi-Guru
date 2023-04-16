import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/gpt.dart';

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
  List<String> cropSrc = ['rice', 'wheat', 'cotton', 'mango'];
  List<String> soilSrc = ['Red', 'Black', 'Brown'];
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String? name = FirebaseAuth.instance.currentUser!.displayName;

  _trySave() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_crop != "" && _soil != "") {
        final chatId =
            await FirebaseFirestore.instance.collection('chats').add({
          'soil': _soil,
          'crop': _crop,
          'uid': uid,
          'createdAt': DateTime.now(),
        });

        final res = await newQuery(_crop);
        print(res[0]['content']);
        await FirebaseFirestore.instance.collection(chatId.id).add({
          'createdAt': DateTime.now(),
          'name': 'system',
          'text': res[0]['content'],
          'userId': 12345
        });
        await FirebaseFirestore.instance.collection(chatId.id).add({
          'createdAt': DateTime.now(),
          'name': name,
          'text': res[1]['content'],
          'userId': uid
        });

        print(res);
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
                  Center(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 150.h, bottom: 50.h),
                          decoration: BoxDecoration(
                            color: Color(0xffFAEBEB),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          width: 600.w,
                          child: Center(
                            child: DropdownButton(
                              icon: Image.asset(
                                'Assets/Images/crop.png',
                                height: 70.h,
                                width: 70.w,
                              ),
                              hint: Text(_crop == ""
                                  ? "Please Select Your Crop"
                                  : _crop),
                              style: TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Color(0xffFAEBEB)),
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
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 50.h),
                          decoration: BoxDecoration(
                            color: Color(0xffFAEBEB),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          width: 600.w,
                          child: Center(
                            child: DropdownButton(
                              icon: Image.asset(
                                'Assets/Images/soil.png',
                                height: 70.h,
                                width: 70.w,
                              ),
                              hint: Text(_soil == ""
                                  ? "Please Select Your Soil"
                                  : _soil),
                              style: TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Color(0xffFAEBEB)),
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
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _trySave,
                          child: Text('Create Chat'),
                        ),
                      ],
                    ),
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
