import 'package:flutter/material.dart';
import 'package:tasky/screens/widgets/custom_svg_picture.dart';

class AppbarSection extends StatelessWidget {
  const AppbarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSvgPicture.withoutColor(
          path: "assets/images/logo.svg",
          height: 42,
          width: 42,
        ),
        SizedBox(width: 16),
        Text("Tasky", style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}
