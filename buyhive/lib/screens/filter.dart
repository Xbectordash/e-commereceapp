import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Active selection index
  int selectedIndex = 0;

  // Filter categories
  final List<String> filters = [
    "Price",
    "Category",
    "Brands",
    "Colors",
    "Size & Fit"
  ];

  // Checkboxes state
  Map<String, bool> priceFilters = {
    "Below \$500": false,
    "Above \$500": false,
    "Above \$1000": false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Row(
        children: [
          // Sidebar Filter Categories
          Container(
            width: 120,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    color: selectedIndex == index ? Colors.red : Colors.transparent,
                    child: Text(
                      filters[index],
                      style: TextStyle(
                        color: selectedIndex == index ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Filter Options Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildFilterOptions(),
            ),
          ),
        ],
      ),
    );
  }

  // Function to display selected filter options
  Widget _buildFilterOptions() {
    if (selectedIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var entry in priceFilters.entries)
            CheckboxListTile(
              title: Text(entry.key),
              value: entry.value,
              onChanged: (bool? newValue) {
                setState(() {
                  priceFilters[entry.key] = newValue!;
                });
              },
            ),
        ],
      );
    } else {
      return const Center(
        child: Text(
          "Other filters will be added here.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
  }
}
