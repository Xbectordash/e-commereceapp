import 'package:buyhive/screens/cart.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String category;

  const SubCategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    
    Map<String, Map<String, List<String>>> subcategories = {
      "Men": {
        "Clothing": ["T-Shirts", "Shirts", "Jeans", "Jacket"],
        "Footwear": ["Sneakers", "Formal Shoes", "Sandals"],
        "Accessories": ["Watches", "Bags", "Belts", "Luxury Watches"],
      },
      "Women": {
        "Clothing": ["Dresses", "Tops", "Jeans", "Skirts"],
        "Footwear": ["Heels", "Flats", "Sneakers"],
        "Accessories": ["Handbags", "Jewelry", "Scarves"],
      },
      "Electronics": {
        "Mobiles": ["Smartphones", "Feature Phones"],
        "Laptops": ["Gaming Laptops", "Business Laptops"],
        "Accessories": ["Headphones", "Chargers", "Power Banks"],
      },
      "Jewelry": {
        "Gold": ["Necklaces", "Bracelets"],
        "Silver": ["Rings", "Earrings"],
      }
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCartPage()));
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: subcategories[category]?.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...entry.value.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(item, style: const TextStyle(fontSize: 16)),
                  )),
              const SizedBox(height: 16),
            ],
          );
        }).toList() ?? [],
      ),
    );
  }
}
