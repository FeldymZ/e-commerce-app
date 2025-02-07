class ProductItem {
  final String id;
  final String image;
  final String name;
  final double price;
  final String description;

  ProductItem({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  // Méthode pour convertir les données Firestore en objet ProductItem
  factory ProductItem.fromFirestore(Map<String, dynamic> data) {
    return ProductItem(
      id: data['id'] ?? '',
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      price: data['price'] ?? 0.0,
      description: data['description'] ?? '',
    );
  }

  toggleFavorite(String userId) {}
}
