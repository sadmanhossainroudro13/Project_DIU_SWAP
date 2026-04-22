import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_diu_swap/screens/home/widgets/search_bar.dart';
import 'package:project_diu_swap/widgets/bold_text.dart';
import 'package:project_diu_swap/screens/home/widgets/categories_sort.dart';
import 'package:project_diu_swap/screens/home/widgets/home_appbar.dart';

import 'package:project_diu_swap/screens/home/widgets/latest_listing_card.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = "All";
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //Search bar
                  Expanded(
                    child: CustomSearch(
                      searchFunction: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              BoldText(str: "Categories", fontSize: 25),

              //Category Section
              CategoriesSort(
                selectedCategory: selectedCategory,
                onTap: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              SizedBox(height: 10),

              //Latest listing
              BoldText(str: "Latest Listing", fontSize: 25),

              //Latese Listing Card
              LatestListingCard(
                selectedCategory: selectedCategory,
                searchQuery: searchQuery,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
