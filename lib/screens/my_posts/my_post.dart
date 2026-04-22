import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_diu_swap/screens/my_posts/widgets/my_post_card.dart';

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Listing",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where("userId", isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var posts = snapshot.data!.docs;

          if (posts.isEmpty) {
            return Center(child: Text("No posts yet"));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              var post = posts[index];
              return MyPostCard(post: post);
            },
          );
        },
      ),
    );
  }
}
