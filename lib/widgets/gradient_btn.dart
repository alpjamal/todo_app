part of '/main.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({required this.onPressed, required this.title, this.gradient, super.key});
  final Function() onPressed;
  final String title;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient ?? LinearGradient(colors: [TodoColor.purpleLight, TodoColor.purpleDark]),
        borderRadius: TodoRadius.gradientBtn,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          minimumSize: Size.fromHeight(50),
        ),
        child: Text(title, style: TodoStyle.btn),
      ),
    );
  }
}
