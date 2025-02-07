import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addCategoriesToFirestore() async {
    // Liste des catégories et de leurs éléments
    Map<String, List<Map<String, dynamic>>> categories = {
      "Sofa": [
        {
          "id": "1",
          "image":
              "https://e7.pngegg.com/pngimages/386/23/png-clipart-couch-club-chair-sofa-bed-furniture-white-sofa-angle-black-white-thumbnail.png",
          "name": "Luxury Sofa",
          "price": 200.00,
          "description": "A luxury sofa made with premium materials.",
          "createdAt": Timestamp.now(),
        },
        {
          "id": "2",
          "image":
              "https://e7.pngegg.com/pngimages/790/456/png-clipart-sofa-sofa-thumbnail.png",
          "name": "Classic Sofa",
          "price": 150.00,
          "description": "A classic design that fits into any living room.",
          "createdAt": Timestamp.now(),
        },
        {
          "id": "3",
          "image":
              "https://e7.pngegg.com/pngimages/461/595/png-clipart-couch-chair-loveseat-seats-and-sofas-white-sofa-seat-angle-furniture-thumbnail.png",
          "name": "Classic Sofa",
          "price": 150.00,
          "description": "A classic design that fits into any living room.",
          "createdAt": Timestamp.now(),
        },
        {
          "id": "4",
          "image":
              "https://e7.pngegg.com/pngimages/868/259/png-clipart-couch-sofa-bed-furniture-futon-bed-angle-furniture-thumbnail.png",
          "name": "Classic Sofa",
          "price": 150.00,
          "description": "A classic design that fits into any living room.",
          "createdAt": Timestamp.now(),
        },
      ],
      "Chair": [
        {
          "id": "1",
          "image":
              "https://e7.pngegg.com/pngimages/878/13/png-clipart-chair-furniture-couch-chair-armrest-wood-thumbnail.png",
          "name": "Office Chair",
          "price": 100.00,
          "description": "Ergonomic office chair for maximum comfort.",
          "createdAt": Timestamp.now(),
        },
        {
          "id": "2",
          "image":
              "https://e7.pngegg.com/pngimages/847/281/png-clipart-eames-lounge-chair-barcelona-chair-office-desk-chairs-bar-stool-chair-furniture-wing-chair-thumbnail.png",
          "name": "Gaming Chair",
          "price": 180.00,
          "description": "A chair designed for long gaming sessions.",
          "createdAt": Timestamp.now(),
        },
        {
          "id": "3",
          "image":
              "https://e7.pngegg.com/pngimages/8/362/png-clipart-eames-lounge-chair-charles-and-ray-eames-eames-house-eames-fiberglass-armchair-chair-furniture-armrest-thumbnail.png",
          "name": "Gaming Chair",
          "price": 180.00,
          "description": "A chair designed for long gaming sessions.",
          "createdAt": Timestamp.now(),
        },
        {
          "id": "4",
          "image":
              "https://e7.pngegg.com/pngimages/76/310/png-clipart-office-desk-chairs-bonded-leather-swivel-chair-chair-angle-furniture-thumbnail.png",
          "name": "Gaming Chair",
          "price": 180.00,
          "description": "A chair designed for long gaming sessions.",
          "createdAt": Timestamp.now(),
        },
      ],
    };
    int retryCount = 0;
    const maxRetries = 3;
    bool success = false;

    while (retryCount < maxRetries && !success) {
      try {
        for (var category in categories.keys) {
          var categoryRef = firestore.collection('categories').doc(category);

          // Vérifier si la catégorie existe
          var docSnapshot = await categoryRef.get();
          if (!docSnapshot.exists) {
            await categoryRef.set({"name": category}); // Ajouter la catégorie
          }

          // Ajouter uniquement les éléments qui n'existent pas encore
          for (var item in categories[category]!) {
            var itemRef = categoryRef.collection("items").doc(item['id']);
            var itemSnapshot = await itemRef.get();

            if (!itemSnapshot.exists) {
              await itemRef.set(item);
            }
          }
        }

        success = true;
        print("✅ Vérification et ajout des catégories/éléments terminés !");
      } catch (e) {
        retryCount++;
        if (retryCount < maxRetries) {
          print("🔁 Tentative ${retryCount} échouée, réessai...");
          await Future.delayed(Duration(seconds: 2)); // Attente avant réessai
        } else {
          print("❌ Échec après ${maxRetries} tentatives. Erreur: $e");
        }
      }
    }
  }
}
