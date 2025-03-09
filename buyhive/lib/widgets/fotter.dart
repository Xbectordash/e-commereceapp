import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png", height: 50),
          const SizedBox(height: 10),
          const Text(
            "KDigitalCurry",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FooterButton(title: "Products", isSelected: true),
              FooterButton(title: "Company"),
              FooterButton(title: "Shop"),
              FooterButton(title: "Service"),
            ],
          ),
          const SizedBox(height: 15),
          const Text("What’s New", style: TextStyle(color: Colors.white, fontSize: 14)),
          SizedBox(height: 5),
          const Text("Sales", style: TextStyle(color: Colors.white, fontSize: 14)),
          SizedBox(height: 5),
          const Text("Top Picks", style: TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 20),
          const Text(
            "© 2025 KDigitalCurry. All rights reserved.",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class FooterButton extends StatelessWidget {
  final String title;
  final bool isSelected;

  const FooterButton({Key? key, required this.title, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
