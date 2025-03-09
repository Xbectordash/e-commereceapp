import 'package:buyhive/screens/cart.dart';
import 'package:buyhive/screens/category/subcategory.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Men", "Women", "Electronics", "Jewelry"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
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
              // TODO: Navigate to cart page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShoppingCartPage()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: Navigate to category details page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubCategoriesScreen(category: categories[index])));

            },
          );
        },
      ),
    );
  }
}
