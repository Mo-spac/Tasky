import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(
              "assets/images/Thumbnail.png",
              width: 42,
              height: 42,
            ),
          ),
          title: Text(
            "Good Evening , $username",
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
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Yuhuu ,Your work Is ",
            style: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 32,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "almost done ! ",
              style: TextStyle(
                color: Color(0xFFFFFCFC),
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/waving-hand-medium-light-skin-tone.svg",
            ),
          ],
        ),
      ],
    );
  }
}
