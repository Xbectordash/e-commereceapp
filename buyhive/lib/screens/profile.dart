import 'package:buyhive/widgets/fotter.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Section
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.jpeg'), 
                ),
                const SizedBox(height: 10),
                const Text(
                  "John Doe",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "john.doe@email.com",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          
          Expanded(
            child: ListView(
              children: const [
                ProfileMenuItem(icon: Icons.shopping_cart, title: "My Orders"),
                ProfileMenuItem(icon: Icons.favorite, title: "My Wishlist"),
                ProfileMenuItem(icon: Icons.location_on, title: "My Address"),
                ProfileMenuItem(icon: Icons.contact_support, title: "Contact Us"),
                ProfileMenuItem(icon: Icons.logout, title: "Logout"),
              ],
            ),
          ),

          // Footer Section
          Footer()

        ],
      ),
    );
  }
}

// Profile Menu Item Widget
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileMenuItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      onTap: () {},
    );
  }
}

// Footer Tab Widget
class FooterTab extends StatelessWidget {
  final String title;

  const FooterTab({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
