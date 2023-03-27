part of '/main.dart';

class GradientFloatingBtn extends StatelessWidget {
  const GradientFloatingBtn({required this.onPressed, this.icon, super.key});
  final Function() onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [TodoColor.fltLight, TodoColor.fltDark]),
          shape: BoxShape.circle,
          boxShadow: [TodoShadow.floatingBtn],
        ),
        child: icon ?? Image.asset(TodoIcon.add, cacheHeight: 30),
      ),
    );
  }
}
