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
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        title: Text(
          "Achieved Tasks",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          "$totalDoneTask Out of $totalTask Done",
          style: Theme.of(context).textTheme.titleSmall,
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
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
