import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/classes/product_items.dart';
import 'package:flutter/material.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  late Future<List<ProductItem>> allProductsFuture;
  final String userId = "userIdHere";

  @override
  void initState() {
    super.initState();
    allProductsFuture =
        getAllProducts(); // Récupère tous les produits depuis Firestore
  }

  // Fonction pour récupérer tous les produits
  Future<List<ProductItem>> getAllProducts() async {
    List<ProductItem> allProducts = [];
    try {
      var categorySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      for (var categoryDoc in categorySnapshot.docs) {
        var itemSnapshot =
            await categoryDoc.reference.collection('items').get();

        allProducts.addAll(itemSnapshot.docs.map((itemDoc) {
          return ProductItem.fromFirestore(itemDoc.data());
        }).toList());
      }
    } catch (e) {
      print("Erreur lors de la récupération des produits: $e");
    }
    return allProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<ProductItem>>(
        future: allProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucun produit disponible"));
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
                      Stack(
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
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.red),
                              onPressed: () async {
                                await item.toggleFavorite(
                                    userId); // Marquer/démarquer le produit comme favori
                                setState(
                                    () {}); // Recharger l'état après l'ajout ou suppression du favori
                              },
                            ),
                          ),
                        ],
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
}
