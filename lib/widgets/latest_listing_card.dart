import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bold_text.dart';

class LatestListingCard extends StatelessWidget {
  String selectedCategory;
  LatestListingCard({required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //stream: FirebaseFirestore.instance.collection("posts").snapshots(),
      stream: selectedCategory == "All"
          ? FirebaseFirestore.instance
                .collection('posts')
                .orderBy("createdAt", descending: true)
                .snapshots()
          : FirebaseFirestore.instance
                .collection('posts')
                .where("category", isEqualTo: selectedCategory)
                .orderBy("createdAt", descending: true)
                .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No posts yet"));
        }

        var posts = snapshot.data!.docs;

        return GridView.builder(
          //this stop scroll error
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: .7,
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var post = posts[index];

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        post["images"][0],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, StackTrace) {
                          return Container(
                            height: 150,
                            color: Colors.grey,
                            child: Icon(Icons.broken_image),
                          );
                        },
                      ),
                    ),
                  ),

                  //Titile inside card
                  Text(
                    post['title'],
                    maxLines: 1,

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  //price in card
                  BoldText(
                    str: "৳ ${post['price']}",
                    fontSize: 15,
                    color: Colors.green,
                    bottom: 0,
                  ),
                  //location
                  Text(
                    post["location"],
                    maxLines: 2,
                    style: TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
