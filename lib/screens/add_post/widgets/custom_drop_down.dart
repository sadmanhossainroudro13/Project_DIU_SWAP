import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? selectedCategory;
  final Function(String?) onChanged;
  CustomDropdown({required this.selectedCategory, required this.onChanged});

  final List<String> categories = const [
    "All",
    "Electronics",
    "Books",
    "Furniture",
    "Sports",
    "Gaming",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        value: selectedCategory,
        hint: Text("Select Category"),
        items: categories.map((category) {
          return DropdownMenuItem(value: category, child: Text(category));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
