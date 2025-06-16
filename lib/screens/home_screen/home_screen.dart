import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/add_task/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("username");
    });
    print("Usernameee = $username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      floatingActionButton: SizedBox(
        width: 167,
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => AddTask()),
            );
          },
          backgroundColor: Color(0xFF15B86C),
          foregroundColor: Color(0xFFFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          label: Text(
            "Add New Task",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          icon: Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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

              //   Spacer(),
              //   Align(
              //     alignment: Alignment.bottomRight,
              //     child: ElevatedButton.icon(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (BuildContext context) => AddTask(),
              //           ),
              //         );
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Color(0xFF15B86C),
              //         foregroundColor: Color(0xFFFFFCFC),
              //         fixedSize: Size(167, 40),
              //       ),
              //       icon: Icon(Icons.add),
              //       label: Text(
              //         "Add New Task",
              //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
