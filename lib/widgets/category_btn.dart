part of '/main.dart';

class SelectCategoryBtn extends StatelessWidget {
  const SelectCategoryBtn({super.key, required this.category, required this.onTap});
  final TodoCategory category;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorCubit = BlocProvider.of<ColorCubit>(context);
    final categoryName = category.name;
    bool isSelected = category == colorCubit.selectedCategory;
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: isSelected ? colorCubit.getColor(category) : Colors.black12,
        borderRadius: TodoRadius.categoryCard,
      ),
      child: TextButton.icon(
        icon: Icon(Icons.circle, size: 15, color: isSelected ? Colors.white : colorCubit.getColor(category)),
        label: Text(
          '${categoryName[0].toUpperCase()}${categoryName.substring(1)} ',
          style: isSelected ? TodoStyle.panelCategory.copyWith(color: Colors.white) : TodoStyle.panelCategory,
        ),
        onPressed: () {
          colorCubit.select(category);
          onTap();
        },
      ),
    );
  }
}
