import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/home_screen/home_screen.dart';
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFFFCFC),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                validator: (value) {
                  // if (value == null || value.trim().isEmpty) {
                  //   return "Please, Enter your full name";
                  // }
                  if (value?.trim().isEmpty ?? false) {
                    return "Please, Enter your full name";
                  }
                  return null;
                },
                controller: controller,
                // onChanged: (value) {},
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "e.g. Sarah Khalid",
                  filled: true,
                  fillColor: Color(0xff282828),
                  hintStyle: TextStyle(color: Color(0xff6D6D6D)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                cursorColor: Colors.white,
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
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF15B86C),
                foregroundColor: Color(0xFFFFFCFC),
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
