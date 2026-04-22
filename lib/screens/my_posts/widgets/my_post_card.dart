import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_diu_swap/screens/my_posts/edit_post_screen.dart';

class MyPostCard extends StatelessWidget {
  final dynamic post;

  const MyPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black12,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,

      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                post['images'][0],
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 10),

            // RIGHT SIDE CONTENT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    post['title'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: 5),

                // PRICE
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "৳ ${post['price']}",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // BUTTONS
                Row(
                  children: [
                    // EDIT
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditPostScreen(
                              post: post.data(),
                              postId: post.id,
                            ),
                          ),
                        );
                      },
                      child: Text("Edit", style: TextStyle(color: Colors.blue)),
                    ),

                    // DELETE
                    TextButton(
                      onPressed: () async {
                        bool? confirm = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete post"),
                              content: Text(
                                "Are you sure you want to delete this post?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text("Cancel"),
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          await FirebaseFirestore.instance
                              .collection('posts')
                              .doc(post.id)
                              .delete();
                        }
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
