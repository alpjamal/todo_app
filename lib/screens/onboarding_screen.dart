part of '/main.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            SvgPicture.asset(TodoIcon.onboarding, height: 200),
            const Text('Reminders made simple', style: TodoStyle.entry),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: GradientButton(
                onPressed: () => _start(context),
                title: 'Get Started',
                gradient: LinearGradient(colors: [TodoColor.greenLight, TodoColor.greenDark]),
              ),
            )
          ],
        ),
      ),
    );
  }

  _start(ctx) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    BlocProvider.of<PrefsCubit>(ctx).start();
  }
}
