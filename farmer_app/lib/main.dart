import 'package:farmer_app/screens/Auth/auth_screen.dart';
import 'package:farmer_app/screens/GPT_screen/Widgets/FormForchat.dart';
import 'package:farmer_app/screens/GPT_screen/gpt_screen.dart';
import 'package:farmer_app/screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Krishi Guru",
          theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data == null) {
                  return AuthScreen();
                } else {
                  return HomeScreen();
                }
              }
              return Text('Some Error Occured');
            },
          ),
          routes: {
            GPTScreen.routeName:(ctx)=>GPTScreen(),
            FormForStartingChat.routeName:(ctx)=>FormForStartingChat(),
          },
        );
      },
      designSize: Size(1080, 2408),
    );
  }
}
