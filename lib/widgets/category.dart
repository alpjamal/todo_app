part of '/main.dart';

class TodoCategoryCard extends StatelessWidget {
  const TodoCategoryCard(this.index, this.state, {super.key});
  final int index;
  final TodosState state;

  @override
  Widget build(BuildContext context) {
    int len = 0;
    TodoCategory category = TodoCategory.values[index];
    String categoryName = '${category.name[0].toUpperCase()}${category.name.substring(1)}';
    if (state is TodosLoaded) {
      len = (state as TodosLoaded).todos.where((todo) => todo.category == category).toList().length;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: TodoRadius.categoryCard,
        boxShadow: [TodoShadow.category],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset('assets/icons/category$index.svg', height: 50),
          Text(categoryName, style: TodoStyle.appBar),
          Text(len.toString(), style: TodoStyle.btn),
        ],
      ),
    );
  }
}
