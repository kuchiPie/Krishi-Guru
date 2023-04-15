import 'package:farmer_app/Components/logout_button.dart';
import 'package:farmer_app/screens/Drawer/Components/AppDrawerElement.dart';
import 'package:farmer_app/screens/GPT_screen/gpt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Color(0xa6FAEBEB)),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppDrawerElement(
                    routeName: GPTScreen.routeName,
                    icon: Icons.question_answer,
                    label: 'Ask to GPT'),
                LogoutButton(Buttontext: 'Logout'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
