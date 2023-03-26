part of '/main.dart';

class TodoCategoryCard extends StatelessWidget {
  const TodoCategoryCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: TodoRadius.categoryCard,
        boxShadow: [TodoShadow.category],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/icons/category$index.png', cacheHeight: 60),
          Text('category', style: TodoStyle.appBar),
          Text('category', style: TodoStyle.label),
        ],
      ),
    );
  }
}
