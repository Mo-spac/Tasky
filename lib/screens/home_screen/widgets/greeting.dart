import 'package:flutter/material.dart';
import 'package:tasky/screens/widgets/custom_svg_picture.dart';

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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            "One task at a time.One step closer.",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: CustomSvgPicture.withoutColor(
            path: "assets/icons/Light.svg",
          ),
        ),
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Yuhuu ,Your work Is ",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Row(
          children: [
            Text(
              "almost done ! ",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            CustomSvgPicture.withoutColor(
              path: "assets/icons/waving-hand-medium-light-skin-tone.svg",
            ),
          ],
        ),
      ],
    );
  }
}
