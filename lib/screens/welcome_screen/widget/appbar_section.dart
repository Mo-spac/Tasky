import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppbarSection extends StatelessWidget {
  const AppbarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/logo.svg", height: 42, width: 42),
        SizedBox(width: 16),
        Text("Tasky", style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}
