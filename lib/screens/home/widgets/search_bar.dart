import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final Function(String) searchFunction;
  const CustomSearch({required this.searchFunction});

  @override
  Widget build(BuildContext context) {
    return TextField(
                onChanged: searchFunction ,
                decoration: InputDecoration(
                  hint: Text(
                    "Search any item",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  prefixIcon: Icon(Icons.search),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
  }
}