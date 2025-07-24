import 'package:flutter/material.dart';
import 'package:tasky/core/wedgits/custom_text_form_field.dart';

class UserDetailsScreen extends StatelessWidget {
  UserDetailsScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController motivationController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Form(
        key: _key,
        child: Column(
          children: [
            CustomTextFormField(
              title: "User Name",
              controller: userNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter User Name";
                }
                return null;
              },
              hintText: "Moo",
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              title: "Motivation Quote",
              controller: motivationController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Motivation Quote";
                }
                return null;
              },
              hintText: "One task at a time. One step closer.",
              maxLines: 5,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF15B86C),
                foregroundColor: Color(0xFFFFFCFC),
                fixedSize: Size(MediaQuery.of(context).size.width, 40),
              ),
              child: Text(
                "Save Changes",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
