import 'package:buyhive/screens/filter.dart';
import 'package:buyhive/widgets/fotter.dart';

import 'package:flutter/material.dart';
import 'package:buyhive/api.dart';
import 'package:buyhive/screens/product.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    List<dynamic> data = await fetchapi();
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          
          Row(
            children: [
              SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {
                  
                },
                icon: Icon(Icons.swap_vert,
                    color: Colors.white), 
                label: Text("Sort By", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, 
                  ),
                  elevation: 0, 
                ),
              ),
              SizedBox(width: 26),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterScreen()),
                  );
                },
                icon: Icon(Icons.filter_list,
                    color: Colors.white), 
                label: Text("Filter", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, 
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Product Grid
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else if (products.isEmpty)
            Center(child: Text("No products found"))
          else
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsPage(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                child: Image.network(
                                  product['image'],
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.favorite_border,
                                      color: Colors.red),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product['description'] ?? "Product Description",
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "\$${product['price']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "\$740", 
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "(30% OFF)",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          SizedBox(height: 40),
          Footer(),
        ],
      ),
    );
  }
}
