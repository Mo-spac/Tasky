import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/services/preference_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/main.dart';
import 'package:tasky/screens/user_details_screen/user_details_screen.dart';
import 'package:tasky/screens/welcome_screen/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? motivationQuote;
  bool isLoading = true;
  // bool isDark = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    // isLoading = true;
    setState(() {
      username = PreferenceManager().getString("username") ?? "";
      motivationQuote =
          PreferenceManager().getString("motivationQuote") ??
          "One task at a time. One step closer.";
      // isDark = PreferenceManager().getBool("theme") ?? true;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(color: Color(0xffFFFCFC)))
        : Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                "My Profile",
                style: TextStyle(
                  color: Color(0xffFFFCFC),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/Thumbnail.png",
                        ),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color(0xff282828),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 26,
                            color: Color(0xffFFFCFC),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // if (username != null)
                  Text(
                    username ?? "",
                    style: TextStyle(
                      color: Color(0xffFFFCFC),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    motivationQuote ?? "One task at a time. One step closer.",
                    style: TextStyle(
                      color: Color(0xffC6C6C6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile Info",
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => UserDetailsScreen(),
                      ),
                    );
                    if (result != null && result == true) {
                      _loadUserInfo();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset("assets/icons/user.svg"),
                  title: Text(
                    "User Details",
                    style: TextStyle(
                      color: Color(0xffFFFCFC),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Color(0xffC6C6C6)),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  shape: Border.symmetric(
                    horizontal: BorderSide(
                      width: 0.75,
                      color: Color(0xffC6C6C6),
                      style: BorderStyle.solid,
                    ),
                  ),
                  leading: SvgPicture.asset("assets/icons/moon.svg"),
                  title: Text(
                    "Dark Mode",
                    style: TextStyle(
                      color: Color(0xffFFFCFC),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (BuildContext context, value, Widget? child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (bool value) async {
                          // setState(() {
                          //   isDark = value;
                          //   if (!isDark) {
                          //     themeNotifire.value = ThemeMode.light;
                          //   } else {
                          //     themeNotifire.value = ThemeMode.dark;
                          //   }
                          // });
                          // await PreferenceManager().setBool("theme", value);

                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                ListTile(
                  onTap: () async {
                    PreferenceManager().remove("username");
                    PreferenceManager().remove("motivationQuote");
                    PreferenceManager().remove("tasks");

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WelcomeScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset("assets/icons/log_out.svg"),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Color(0xffFFFCFC),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Color(0xffC6C6C6)),
                ),
              ],
            ),
          ],
        );
  }
}
