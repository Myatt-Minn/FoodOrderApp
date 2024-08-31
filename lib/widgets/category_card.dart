import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final bool? category;
  final String img;
  const CategoryCard({super.key, this.category, required this.img});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            color: category! ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          img,
          width: 45,
          height: 45,
          color: category! ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
