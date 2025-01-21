import 'package:flutter/material.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Aishu';
  String phoneNumber = '1234567890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: MytextStyle.headingText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name:', style: MytextStyle.hintStyle),
            const SizedBox(height: 4),
            Text(userName, style: MytextStyle.headingText),
            const SizedBox(height: 16),
            Text('Phone:', style: MytextStyle.hintStyle),
            const SizedBox(height: 4),
            Text(phoneNumber, style: MytextStyle.headingText),
          ],
        ),
      ),
    );
  }
}
