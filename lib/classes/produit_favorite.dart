import 'package:cloud_firestore/cloud_firestore.dart';

class ProductItem2 {
  final String id;
  final String image;
  final String name;
  final double price;

  ProductItem2({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });

  // Méthode pour ajouter ou retirer un produit des favoris
  Future<void> toggleFavorite(String userId) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final favoriteRef = userRef.collection('favorites').doc(id);

    var docSnapshot = await favoriteRef.get();

    if (docSnapshot.exists) {
      // Si le produit est déjà un favori, on le retire
      await favoriteRef.delete();
    } else {
      // Sinon, on l'ajoute aux favoris
      await favoriteRef.set({
        'id': id,
        'image': image,
        'name': name,
        'price': price,
      });
    }
  }
}
