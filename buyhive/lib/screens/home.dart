import 'package:buyhive/screens/productlist.dart';
import 'package:flutter/material.dart';
import 'package:buyhive/screens/category/Categories.dart';
import 'package:buyhive/screens/cart.dart';
import 'package:buyhive/screens/profile.dart';
import 'package:buyhive/widgets/fotter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        children: [
          buildHeroImage(),
          const SizedBox(height: 20),
          ShopByBrand(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: const Text(
              "Browse by Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          BrowseByCategory(),
          FSale(),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: const Text("Shop by Category", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductListPage()),
              );
            },
            child: ShopbyCategory()),
          const SizedBox(height: 40),
          MensCollection(),
         const SizedBox(height: 40),
          WomensCollection(),
          const SizedBox(height: 40),
          FAQSection(),
          const SizedBox(height: 60),
          Footer(),
        ],
      ),
    );
  }

PreferredSizeWidget buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(150),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black, size: 40),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person_2_outlined,
                      color: Colors.black, size: 35),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined,
                      color: Colors.black, size: 35),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                    );
                  },
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget buildHeroImage() {
    return Container(
      height: 300,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
      child: Image.asset(
        "assets/images/first.jpeg",
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}

class ShopByBrand extends StatelessWidget {
  final List<String> shopbybrand = [
    "assets/images/homepage/logo1.png",
    "assets/images/homepage/logo2.png",
    "assets/images/homepage/logo 3.png",
    "assets/images/homepage/logo 4.png",
    "assets/images/homepage/logo5.png",
    "assets/images/homepage/logo6.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shop By Brands",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: shopbybrand.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InteractiveViewer(
                        panEnabled: false,
                        boundaryMargin: const EdgeInsets.all(10),
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: Image.asset(
                          shopbybrand[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrowseByCategory extends StatelessWidget {
  BrowseByCategory({Key? key}) : super(key: key);

  final List<String> browsebyCategory = [
    "assets/images/homepage/2.png",
    "assets/images/homepage/3.png",
    "assets/images/homepage/4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 820,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: browsebyCategory.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset(
                  browsebyCategory[index],
                  height: 245,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FSale extends StatelessWidget {
  const FSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSaleItem("assets/images/homepage/5.jpeg"),
          _buildSaleItem("assets/images/homepage/5.2.jpeg"),
        ],
      ),
    );
  }

  Widget _buildSaleItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 300,
        width: 400,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1),
          child: Image.asset(
            imagePath,
            width: 330,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ShopbyCategory extends StatelessWidget {
  ShopbyCategory({Key? key}) : super(key: key);

  final List<Map<String, String>> category = [
    {"Watches": "assets/images/homepage/6.png"},
    {"Shoes": "assets/images/homepage/7.png"},
    {"Heels": "assets/images/homepage/8.png"},
    {"Beauty & MakeUp": "assets/images/homepage/9.png"},
    {"Bags & Bag Packs": "assets/images/homepage/10.png"},
    {"Jewellery": "assets/images/homepage/11.png"},
    {"Sunglasses": "assets/images/homepage/12.png"},
    {"Perfume": "assets/images/homepage/13.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: category.length,
        itemBuilder: (context, index) {
          String categoryName = category[index].keys.first;
          String imagePath = category[index][categoryName]!;
          return Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                categoryName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MensCollection extends StatelessWidget {
  const MensCollection({Key? key}) : super(key: key);

  final List<Map<String, String>> mensCollection = const [
    {"Crimson Crest Shirt": "assets/images/homepage/14.png"},
    {"Indigo Edge Denim Jacket": "assets/images/homepage/15.png"},
    {"Crimson Crest Shirt": "assets/images/homepage/m3.png"},
    {"Indigo Edge Denim Jacket": "assets/images/homepage/m4.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Men’s Cloth Collection",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mensCollection.length,
            itemBuilder: (context, index) {
              String productName = mensCollection[index].keys.first;
              String imagePath = mensCollection[index][productName]!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 180,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 180,
                      child: Text(
                        productName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Text(
                          "\$590",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "\$690",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class WomensCollection extends StatelessWidget {
  const WomensCollection({Key? key}) : super(key: key);

  final List<Map<String, String>> womensCollection = const [
    {"Crimson Crest Shirt": "assets/images/homepage/16.png"},
    {"Indigo Edge Denim Jacket": "assets/images/homepage/17.png"},
    {"Crimson Crest Shirt": "assets/images/homepage/w3.png"},
    {"Indigo Edge Denim Jacket": "assets/images/homepage/w4.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Women’s Cloth Collection",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: womensCollection.length,
            itemBuilder: (context, index) {
              String productName = womensCollection[index].keys.first;
              String imagePath = womensCollection[index][productName]!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 180,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 180,
                      child: Text(
                        productName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Text(
                          "\$590",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "\$690",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          _buildFAQTile(
            "How can I place an order?",
            "Yes, you can try us for free for 30 days. If you want, we’ll provide you with a free, personalized 30-minute onboarding call to get you up and running as soon as possible.",
          ),
          _buildFAQTile("Is COD (Cash on Delivery) available?", ""),
          _buildFAQTile("What is your cancellation policy?", ""),
          _buildFAQTile("What is your return policy?", ""),
          _buildFAQTile("Do You Offer International Shipping?", ""),
        ],
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Column(
      children: [
        ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          children: answer.isNotEmpty
              ? [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                    child: Text(
                      answer,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ]
              : [],
        ),
        const Divider(thickness: 1, height: 0),
      ],
    );
  }
}