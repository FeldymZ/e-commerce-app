import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'one_product.dart'; // Importer la page des produits

class CategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Sofa", "icon": Icons.weekend},
    {"name": "Chair", "icon": Icons.chair},
    {"name": "Lamp", "icon": Icons.lightbulb},
    {"name": "Cupboard", "icon": Icons.kitchen},
    {"name": "Table", "icon": Icons.table_bar},
    {"name": "Bed", "icon": Icons.bed},
    {"name": "Bookcases", "icon": Icons.library_books},
    {"name": "Office Chair", "icon": Icons.chair_alt},
    {"name": "Desk Table", "icon": Icons.desk},
    {"name": "Dining Table", "icon": Icons.table_restaurant},
    {"name": "Dresser", "icon": Icons.cabin},
    {"name": "Rocking Chair", "icon": Icons.chair_rounded},
    {"name": "Swing Zula", "icon": Icons.outdoor_grill},
    {"name": "Vase", "icon": Icons.vignette},
    {"name": "Mattress", "icon": Icons.bedroom_child},
    {"name": "TV Table", "icon": Icons.tv},
    {"name": "Drawer", "icon": Icons.draw},
    {"name": "Wall Mirror", "icon": Icons.mic},
    {"name": "Stool", "icon": Icons.stacked_bar_chart},
    {"name": "Other", "icon": Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 colonnes comme sur l'image
            crossAxisSpacing: 10,
            mainAxisSpacing: 40,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String categoryName = categories[index]["name"];
            IconData categoryIcon = categories[index]["icon"];

            return GestureDetector(
              onTap: () {
                // Aller à la page OneProduct avec la catégorie sélectionnée
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OneProduct(categoryName: categoryName),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(categoryIcon, size: 30, color: Colors.black),
                  ),
                  SizedBox(height: 15.h),
                  Text(categoryName, textAlign: TextAlign.center),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
