import 'package:flutter/material.dart';
import 'package:tasky/screens/home_screen/home_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // TO DO : Dispose this controlers
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        backgroundColor: Color(0xFF181818),
        centerTitle: false,
        title: Text("New Task"),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFCFC),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Name",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: taskNameController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? false) {
                    return "Please, Enter your Task's name";
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText:
                      "Finish onboarding UI and hand off to devs by Thursday.",
                  filled: true,
                  fillColor: Color(0xff282828),
                  hintStyle: TextStyle(
                    color: Color(0xff6D6D6D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                cursorColor: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                "Task Description",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: taskDescriptionController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? false) {
                    return "Please, Enter your Task's description";
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:
                      "Finish onboarding UI and hand off to devs by Thursday.",
                  filled: true,
                  fillColor: Color(0xff282828),
                  hintStyle: TextStyle(
                    color: Color(0xff6D6D6D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                cursorColor: Colors.white,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "High Priority",
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Switch(
                    value: isHighPriority,
                    onChanged: (bool value) {
                      setState(() {
                        isHighPriority = value;
                      });
                    },
                    activeTrackColor: Color(0xFF15B86C),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF15B86C),
                  foregroundColor: Color(0xFFFFFCFC),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                icon: Icon(Icons.add),
                label: Text(
                  "Add Task",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
