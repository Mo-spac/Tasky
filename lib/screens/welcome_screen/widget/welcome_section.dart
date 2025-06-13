import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome To Tasky ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFFFCFC),
                ),
              ),
              SvgPicture.asset(
                "assets/images/waving-hand-medium-light-skin-tone.svg",
                height: 28,
                width: 28,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Your productivity journey starts here.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFFFFCFC),
            ),
          ),
          SizedBox(height: 24),
          SvgPicture.asset("assets/images/pana.svg", width: 215, height: 215),
        ],
      ),
    );
  }
}
