import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:product_listing_app_test/view/home_screen/home_screen.dart'; // Update with the actual import of your Home Screen

class PopUpWidget extends StatelessWidget {
  const PopUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return CupertinoAlertDialog(
      title: Text("Please Enter Your Name", style: MytextStyle.headingText),
      content: Column(
        children: [
          CupertinoTextField(
            controller: nameController,
            placeholder: "Enter your name",
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.inactiveGray),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            if (nameController.text.isNotEmpty) {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => const HomeScreen()),
              );
            } else {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text("Error"),
                  content: const Text("Name cannot be empty"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            }
          },
          child: const Text('Submit'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
