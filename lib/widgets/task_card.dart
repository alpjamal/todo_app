part of '/main.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.title, required this.time});
  final String title;
  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, offset: Offset(0, 5), blurRadius: 7),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Row(
              children: [
                Container(height: double.infinity, width: 4, color: Colors.red),
                SizedBox(width: 15),
                Icon(3 == 3 ? Icons.circle_outlined : Icons.circle, color: Colors.grey),
                SizedBox(width: 10),
                Text('${time.hour}:${time.minute}', style: TodoStyle.cardTime),
                SizedBox(width: 10),
                Text(title, style: TodoStyle.taskCard),
                Spacer(),
                Icon(Icons.notifications, color: Colors.grey),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
