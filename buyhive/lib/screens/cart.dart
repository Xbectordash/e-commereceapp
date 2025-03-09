import 'package:flutter/material.dart';
import 'package:buyhive/cartdata.dart';
import 'package:buyhive/widgets/fotter.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool standardShipping = true;
  final TextEditingController couponController = TextEditingController();
    void applyCoupon(BuildContext context) {
    String coupon = couponController.text.trim();
    // Your logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Coupon '$coupon' applied")),
    );
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = cartItems.fold(
      0,
      (sum, item) => sum + ((item['price'] ?? 0.0) * (item['quantity'] ?? 1)),
    );
    double shipping = standardShipping ? 5.0 : 15.0;
    double total = subtotal + shipping;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        leading: const BackButton(),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty."))
          : ListView(
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CheckoutStepIndicator(currentStep: 0),
                ),
                ...cartItems
                    .asMap()
                    .entries
                    .map((entry) => StylishCartItem(
                        imageUrl: entry.value['image'],
                        name: entry.value['name'],
                        price: entry.value['price'],
                        originalPrice: entry.value['originalPrice'],
                        discount: (entry.value['discount'] is num)
                            ? (entry.value['discount'] as num).round()
                            : 0,
                        quantity: int.parse(entry.value['quantity'].toString()),
                        size: entry.value['size'],
                        color: entry.value['color'],
                        inStock: entry.value['inStock'],
                        onDelete: () => _removeItem(entry.key),
                        onWishlistToggle: () {}))
                    .toList(),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Shipping Options",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                DiscountCouponCard(
                        couponController: couponController,
                        onApplyCoupon: () => applyCoupon(context),
                      ),
                const SizedBox(height: 20),
                OrderSummaryCard(),
                const SizedBox(height: 40),
                const Footer(),
              ],
            ),
    );
  }
}



// ─────────────────────────────────────────────────────────────
// 🧩 Cart Item Tile Widget
class CartItemTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;

  const CartItemTile({
    required this.item,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item['image'] ?? '',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 80),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name'] ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                      'Qty: ${item['quantity']}  |  Size: ${item['size'] ?? 'M'}'),
                  Text('Color: ${item['color'] ?? 'N/A'}'),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$${item['price']}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      if (item['originalPrice'] != null)
                        Text(
                          '\$${item['originalPrice']}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                      const SizedBox(width: 6),
                      if (item['discount'] != null)
                        Text(
                          '${item['discount']} Off',
                          style: const TextStyle(color: Colors.green),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.bookmark_border,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "Save to Wishlist",
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 📦 Shipping Options Widget
class ShippingOptions extends StatelessWidget {
  final bool standardShipping;
  final Function(bool) onOptionChanged;

  const ShippingOptions({
    required this.standardShipping,
    required this.onOptionChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text("Standard Delivery (5-7 days)"),
          value: standardShipping,
          onChanged: (val) => onOptionChanged(true),
        ),
        CheckboxListTile(
          title: const Text("Express Delivery (2-3 days)"),
          value: !standardShipping,
          onChanged: (val) => onOptionChanged(false),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 💳 Order Summary Card Widget

class CheckoutStepIndicator extends StatelessWidget {
  final int currentStep; // 0 = Cart, 1 = Delivery, 2 = Payment

  const CheckoutStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStep(
          icon: Icons.shopping_bag,
          label: "Cart",
          isActive: currentStep == 0,
        ),
        _buildLine(),
        _buildStep(
          icon: Icons.location_on_outlined,
          label: "Delivery Details",
          isActive: currentStep == 1,
        ),
        _buildLine(),
        _buildStep(
          icon: Icons.credit_card_outlined,
          label: "Payment",
          isActive: currentStep == 2,
        ),
      ],
    );
  }

  Widget _buildStep(
      {required IconData icon, required String label, required bool isActive}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: isActive ? Colors.red : Colors.grey.shade200,
          child: Icon(icon, color: isActive ? Colors.white : Colors.black54),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.black : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildLine() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey.shade300,
      ),
    );
  }
}




class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Summary Card
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Total Summary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSummaryRow("Total MRP", "\$1100"),
                _buildSummaryRow("Discount", "-\$213"),
                _buildSummaryRow("Coupon Code", "-\$220"),
                _buildSummaryRow("Delivery Fee", "\$0"),
                const Divider(thickness: 1, height: 24),
                _buildSummaryRow("Order Total", "\$667", isBold: true),
              ],
            ),
          ),
        ),

        // Proceed to Shipping Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navigate to Shipping Screen or perform action
              },
              child: const Text(
                "Proceed to Shipping",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}


class StylishCartItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final double originalPrice;
  final int discount;
  final int quantity;
  final String size;
  final String color;
  final bool inStock;
  final VoidCallback onDelete;
  final VoidCallback onWishlistToggle;

  const StylishCartItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.quantity,
    required this.size,
    required this.color,
    required this.inStock,
    required this.onDelete,
    required this.onWishlistToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    height: 100,
                    width: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported, size: 80),
                  ),
                ),
                const SizedBox(width: 12),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("Qty"),
                              const SizedBox(width: 5),
                              DropdownButton<int>(
                                value: quantity,
                                items: List.generate(
                                  10,
                                  (index) => DropdownMenuItem(
                                    value: index + 1,
                                    child: Text("${index + 1}"),
                                  ),
                                ),
                                onChanged: (val) {},
                                underline: SizedBox(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Size "),
                              Text(size,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text("Color "),
                          Text(color),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        inStock ? "In stock" : "Out of stock",
                        style: TextStyle(
                          color: inStock ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text("\$$price",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            "\$$originalPrice",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "$discount% Off",
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: onWishlistToggle,
                        child: Row(
                          children: const [
                            Icon(Icons.favorite_border, size: 18),
                            SizedBox(width: 6),
                            Text("Save To Wishlist"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Delete Icon
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }


}



class DiscountCouponCard extends StatefulWidget {
  final TextEditingController couponController;
  final VoidCallback onApplyCoupon;

  const DiscountCouponCard({
    super.key,
    required this.couponController,
    required this.onApplyCoupon,
  });

  @override
  State<DiscountCouponCard> createState() => _DiscountCouponCardState();
}

class _DiscountCouponCardState extends State<DiscountCouponCard> {
  String _selectedCoupon = "SHIRT20";

  void _handleCouponSelection(String? value) {
    if (value != null) {
      setState(() {
        _selectedCoupon = value;
        widget.couponController.text = value; // optional autofill
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Have a promocode",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Coupon TextField + Apply Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.couponController,
                    decoration: InputDecoration(
                      hintText: "Enter Coupon Code",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: widget.onApplyCoupon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "Applicable Coupons",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Coupon List Items
            _buildRadioTile("SHIRT20", "SHIRT20", "Get 20% off on your favorite shirts!"),
            _buildRadioTile("BUYSHIRT10", "BUYSHIRT10", "Save \$10 on your shirt purchase."),
            _buildRadioTile("CLASSYSHIRTS25", "CLASSYSHIRTS25", "25% off on premium shirts"),
            _buildRadioTile("SHIRTFEST15", "SHIRTFEST15", "Enjoy 15% off this season"),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(String value, String title, String subtitle) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedCoupon,
      onChanged: _handleCouponSelection,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      activeColor: Colors.red,
    );
  }
}
