import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_diu_swap/widgets/bold_text.dart';
import 'package:project_diu_swap/widgets/home_appbar.dart';
import 'package:project_diu_swap/widgets/latestListing_seeAll.dart';
import 'package:project_diu_swap/widgets/latest_listing_card.dart';

class Homepage extends StatefulWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.all_inbox},
    {"name": "Electronics", "icon": Icons.devices},
    {"name": "Books", "icon": Icons.menu_book},
    {"name": "Furniture", "icon": Icons.chair},
    {"name": "Sports", "icon": Icons.sports_soccer},
    {"name": "Gaming", "icon": Icons.sports_esports},
    {"name": "Others", "icon": Icons.category},
  ];

  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = "All";
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
              LatestlistingSeeall(str: "Categories"),
              //Category Section
              SizedBox(
                height: 60,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = widget.categories[index]['name'];
                        });
                      },
                      child: Container(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                              ),
                              child: Icon(
                                widget.categories[index]['icon'],
                                size: 35,
                                color: const Color.fromARGB(255, 61, 189, 65),
                              ),
                            ),

                            Text(widget.categories[index]['name']),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              //Latest listing and see all
              LatestlistingSeeall(str: "Latest Listing"),

              //Latese Listing Card
              LatestListingCard(selectedCategory: selectedCategory,),
            ],
          ),
        ),
      ),
    );
  }
}
