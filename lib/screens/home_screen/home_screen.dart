import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  // backgroundColor: Colors.grey[200],
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    "assets/images/Thumbnail.png",
                    width: 42,
                    height: 42,
                  ),
                ),
                title: Text(
                  "Good Evening ,Usama",
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  "One task at a time.One step closer.",
                  style: TextStyle(
                    color: Color(0xffC6C6C6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: SvgPicture.asset("assets/icons/Light.svg"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
