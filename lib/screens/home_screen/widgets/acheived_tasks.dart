import 'package:flutter/material.dart';

class AcheivedTasks extends StatelessWidget {
  const AcheivedTasks({
    super.key,
    required this.totalTask,
    required this.totalDoneTask,
    required this.percent,
  });
  final int totalTask;
  final int totalDoneTask;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff282828),
      child: ListTile(
        title: Text(
          "Achieved Tasks",
          style: TextStyle(
            color: Color(0xffFFFCFC),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          "$totalDoneTask Out of $totalTask Done",
          style: TextStyle(
            color: Color(0xffC6C6C6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -3.14 / 2,
              child: SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  value: percent,
                  backgroundColor: Color(0xff6D6D6D),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff15B86C)),
                  strokeWidth: 4,
                ),
              ),
            ),
            Text(
              "${(percent * 100).toInt()} %",
              style: TextStyle(
                color: Color(0xffFFFCFC),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
