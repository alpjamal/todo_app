part of '/main.dart';

class GradientFloatingBtn extends StatelessWidget {
  const GradientFloatingBtn({required this.onPressed, this.icon, super.key});
  final Function() onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [TodoColor.fltLight, TodoColor.fltDark]),
        shape: BoxShape.circle,
        boxShadow: [TodoShadow.floatingBtn],
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: onPressed,
        child: icon ?? Image.asset(TodoIcon.add, cacheHeight: 30),
      ),
    );
  }
}
