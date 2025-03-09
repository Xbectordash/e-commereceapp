import 'package:flutter/material.dart';
import 'package:buyhive/cartdata.dart';
import 'package:buyhive/screens/cart.dart';
import 'package:buyhive/widgets/fotter.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Map<String, dynamic> product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  String selectedSize = 'L';
  String selectedColor = 'Dark Brown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShoppingCartPage()));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              children: [
                ProductImage(imageUrl: widget.product['image']),
                ProductTitlePrice(
                    title: widget.product['title'],
                    price: widget.product['price']),
                QuantitySelector(
                  quantity: quantity,
                  onChanged: (val) {
                    setState(() {
                      quantity = val;
                    });
                  },
                ),
                const OfferTagWidget(),
                const SizedBox(height: 16),
                ColorOptionsWidget(
                selectedColor: selectedColor,
                onColorChanged: (val) {
                  setState(() {
                    selectedColor = val;
                  });
                },
              ),
                const SizedBox(height: 16),
                SizeSelectorWidget(
                  selectedSize: selectedSize,
                  onSizeChanged: (val) {
                    setState(() {
                      selectedSize = val;
                    });
                  },
                ),
                const SizedBox(height: 16),
                AddToCartButtonWidget(
                  product: widget.product,
                  quantity: quantity,
                  size: selectedSize,
                  color: selectedColor,
                ),

                const SizedBox(height: 12),
                const BuyNowButtonWidget(),
                const SizedBox(height: 20),
                WishlistButton(
                  onTap: () {
                    // Your wishlist logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to Wishlist")),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ProductDescription(description: widget.product['description']),
                const SizedBox(height: 16),
                const CustomerReviewsSection(),
                const SizedBox(height: 16),
                const RelatedProductsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

// ------------------------- UI WIDGETS ---------------------------

class ProductImage extends StatelessWidget {
  final String imageUrl;
  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(imageUrl, height: 300),
    );
  }
}

class ProductTitlePrice extends StatelessWidget {
  final String title;
  final dynamic price;
  const ProductTitlePrice(
      {super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text("\$$price",
            style: const TextStyle(fontSize: 18, color: Colors.red)),
        const SizedBox(height: 16),
      ],
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onChanged;

  const QuantitySelector(
      {super.key, required this.quantity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
        ),
        Text('$quantity'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onChanged(quantity + 1),
        ),
      ],
    );
  }
}

class OfferTagWidget extends StatelessWidget {
  const OfferTagWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.local_offer_outlined, size: 18, color: Colors.grey),
        const SizedBox(width: 6),
        Text("Save 30% Right Now",
            style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }
}

class ColorOptionsWidget extends StatelessWidget {
  final String selectedColor;
  final Function(String) onColorChanged;
  const ColorOptionsWidget({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> colors = ['Dark Brown', 'Steel Blue', 'Black'];
    final List<Color> colorValues = [
      const Color(0xFF6B4B3E),
      const Color(0xFF97A5B5),
      Colors.black,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Color",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        Row(
          children: List.generate(colors.length, (index) {
            return GestureDetector(
              onTap: () => onColorChanged(colors[index]),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColor == colors[index]
                              ? Colors.red
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: colorValues[index],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(colors[index]),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}


class SizeSelectorWidget extends StatelessWidget {
  final String selectedSize;
  final Function(String) onSizeChanged;
  const SizeSelectorWidget({
    super.key,
    required this.selectedSize,
    required this.onSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> sizes = ['S', 'M', 'L', 'XS', 'XL'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Select Size",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text("Size Chart >", style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: sizes.map((size) {
            bool isSelected = size == selectedSize;
            return GestureDetector(
              onTap: () => onSizeChanged(size),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.shade700 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}


class AddToCartButtonWidget extends StatelessWidget {
  final Map<String, dynamic> product;
  final int quantity;
  final String size;
  final String color;

  const AddToCartButtonWidget({
    super.key,
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        double originalPrice = product["price"].toDouble();
        double discountedPrice = originalPrice - 10;
        double discount = ((originalPrice - discountedPrice) / originalPrice) * 100;

        cartItems.add({
          "name": product["title"],
          "image": product["image"],
          "price": discountedPrice,
          "originalPrice": originalPrice,
          "discount": discount.toStringAsFixed(2),
          "quantity": quantity,
          "size": size,
          "color": color,
          "inStock": true,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Added to cart!")),
        );
      },
      child: const Center(
        child: Text("Add to Cart",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }
}


class BuyNowButtonWidget extends StatelessWidget {
  const BuyNowButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade700,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        // Buy now action
      },
      child: const Center(
        child: Text("Buy Now", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  final String description;
  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Product Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        Text(description),
      ],
    );
  }
}

class CustomerReviewsSection extends StatelessWidget {
  const CustomerReviewsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Customer Reviews",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://as1.ftcdn.net/v2/jpg/02/43/12/34/1000_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'),
              ),
              title: Text('User Name'),
              subtitle: Text('Great product! Highly recommend.'),
              trailing: Icon(Icons.star, color: Colors.yellow),
            );
          },
        ),
      ],
    );
  }
}

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Related Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Image.network(
                        'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg',
                        height: 80),
                    const SizedBox(height: 6),
                    const Text('Product Name'),
                    const Text('\$49.99', style: TextStyle(color: Colors.red)),
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

class WishlistButton extends StatelessWidget {
  final VoidCallback onTap;

  const WishlistButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
    
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF1F1F1), 
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.bookmark_border,
              color: Colors.black87,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          
          const Text(
            "Add To Wishlist",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}