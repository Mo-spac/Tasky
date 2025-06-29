import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String username;
  bool isLoading = true;
  bool isDark = true;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    isLoading = true;
    final pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("username") ?? "";
    });
    isLoading = false;
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
                  if (username != null)
                    Text(
                      username,
                      style: TextStyle(
                        color: Color(0xffFFFCFC),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  Text(
                    "One task at a time. One step closer.",
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
                // Divider(thickness: 1, color: Color(0xffFFFCFC)),
                ListTile(
                  onTap: () {},
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
                  trailing: Switch(
                    value: isDark,
                    onChanged: (bool value) {
                      setState(() {
                        isDark = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  onTap: () {},
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
