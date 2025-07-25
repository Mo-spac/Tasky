import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/wedgits/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController motivationController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? username;
  String? motivationQuote;

  void _loadUserInfo() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("username");
      motivationQuote = pref.getString("motivationQuote");
      // userNameController.text = username ?? "";
      // motivationController.text = motivationQuote ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

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
              hintText: username ?? "User Name",
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
              hintText:
                  motivationQuote ?? "One task at a time. One step closer.",
              maxLines: 5,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  final pref = await SharedPreferences.getInstance();
                  await pref.setString(
                    "username",
                    userNameController.value.text,
                  );

                  // save new key -> motivation_quote -- > string
                  await pref.setString(
                    "motivationQuote",
                    motivationController.value.text,
                  );
                  Navigator.of(context).pop(true);
                }
              },
              style: ElevatedButton.styleFrom(
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
