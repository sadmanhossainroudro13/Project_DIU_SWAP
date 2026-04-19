import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_diu_swap/screens/home/widgets/search_bar.dart';
import 'package:project_diu_swap/widgets/bold_text.dart';
import 'package:project_diu_swap/screens/home/widgets/categories_sort.dart';
import 'package:project_diu_swap/screens/home/widgets/home_appbar.dart';
import 'package:project_diu_swap/screens/home/widgets/latestListing_seeAll.dart';
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

                  IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt)),
                ],
              ),

              LatestlistingSeeall(str: "Categories"),

              //Category Section
              CategoriesSort(
                selectedCategory: selectedCategory,
                onTap: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              //Latest listing and see all
              LatestlistingSeeall(str: "Latest Listing"),

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
