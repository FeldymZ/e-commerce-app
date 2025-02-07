import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/classes/product_items.dart';
import 'package:flutter/material.dart';

class OneProduct extends StatelessWidget {
  final String categoryName;

  const OneProduct({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: FutureBuilder<List<ProductItem>>(
        future: getProductsByCategory(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucun produit dans cette catégorie"));
          } else {
            var products = snapshot.data!;

            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var item = products[index];
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(item.image,
                            height: 50,
                            width: double.infinity,
                            fit: BoxFit.contain),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.5)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("\$${item.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5)),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Fonction pour récupérer les produits d'une catégorie spécifique
  Future<List<ProductItem>> getProductsByCategory(String categoryName) async {
    List<ProductItem> products = [];
    try {
      var categoryRef =
          FirebaseFirestore.instance.collection('categories').doc(categoryName);
      var itemSnapshot = await categoryRef.collection('items').get();

      products = itemSnapshot.docs.map((itemDoc) {
        return ProductItem.fromFirestore(itemDoc.data());
      }).toList();
    } catch (e) {
      print("Erreur lors de la récupération des produits: $e");
    }
    return products;
  }
}
