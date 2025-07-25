import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/wedgits/custom_text_form_field.dart';
import 'package:tasky/screens/main_screen/main_screen.dart';

class StartSection extends StatelessWidget {
  StartSection({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _key,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomTextFormField(
                title: "Full Name",
                controller: controller,
                validator: (value) {
                  // if (value == null || value.trim().isEmpty) {
                  //   return "Please, Enter your full name";
                  // }
                  if (value?.trim().isEmpty ?? false) {
                    return "Please, Enter your full name";
                  }
                  return null;
                },
                hintText: "e.g. Sarah Khalid",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // print(controller.value.text);
                if (_key.currentState?.validate() ?? false) {
                  final pref = await SharedPreferences.getInstance();
                  await pref.setString("username", controller.value.text);
                  // String? username = pref.getString("username");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MainScreen(),
                    ),
                  );
                  // controller.clear();
                } else {
                  //  snackBar TO DO
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please, Enter your full name"),
                      elevation: 10,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 40),
              ),

              child: Text(
                "Let’s Get Started",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
