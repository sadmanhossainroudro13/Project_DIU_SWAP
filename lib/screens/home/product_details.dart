import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_diu_swap/widgets/bold_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> post;

  const ProductDetails({super.key, required this.post});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isfavourite = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List images = widget.post['images'];

    final timestamp = widget.post['createdAt'];

    DateTime postTime = timestamp.toDate();

    DateTime now = DateTime.now();

    Duration diff = now.difference(postTime);

    String timeAgo;

    if (diff.inMinutes < 1) {
      timeAgo = "Just now";
    } else if (diff.inHours < 1) {
      timeAgo = "${diff.inMinutes} minutes ago";
    } else if (diff.inDays < 1) {
      timeAgo = "${diff.inHours} hours ago";
    } else {
      timeAgo = "${diff.inDays} days ago";
    }

    Future<void> makeCall(String number) async {
      final Uri phoneUri = Uri(scheme: 'tel', path: number);

      await launchUrl(phoneUri);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black87,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  IMAGE
            Stack(
              children: [
                Image.network(
                  images[currentIndex],
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                //left button
                Positioned(
                  left: 10,
                  top: 180,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      if (currentIndex > 0) {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    },
                  ),
                ),

                //Right button
                Positioned(
                  right: 10,
                  top: 180,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: () {
                      if (currentIndex < images.length - 1) {
                        setState(() {
                          currentIndex++;
                        });
                      }
                    },
                  ),
                ),

                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.black54,
                    child: Text(
                      "${currentIndex + 1}/${images.length})",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            //  DETAILS
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          // TITLE
                          Text(
                            widget.post['title'],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          // PRICE
                          Text(
                            "৳ ${widget.post['price']}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // //Favourite
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       isfavourite = !isfavourite;
                      //     });
                      //   },
                      //   icon: Icon(
                      //     isfavourite ? Icons.heart_broken : Icons.abc,
                      //     size: 45,
                      //   ),
                      // ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // LOCATION + TIME
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 5),
                      Text(widget.post['location'] ?? ""),
                      Spacer(),
                      Text(timeAgo), // later dynamic
                    ],
                  ),

                  SizedBox(height: 20),

                  // DESCRIPTION TITLE
                  BoldText(str: "Description", fontSize: 16, bottom: 5),

                  // DESCRIPTION
                  Text(widget.post['description'] ?? ""),

                  SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldText(
                            str: "Contact Number",
                            fontSize: 16,
                            bottom: 5,
                          ),

                          Text(
                            widget.post['phoneNumber']?.toString() ??
                                "No number",
                          ),
                        ],
                      ),

                      ElevatedButton(
                        onPressed: () {
                          String number =
                              widget.post['phoneNumber']?.toString() ?? "";

                          if (number.isNotEmpty) {
                            makeCall(number);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("No phone number found")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Call"),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // POSTED BY
                  Text(
                    "Posted by",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      CircleAvatar(radius: 20, child: Icon(Icons.person)),

                      SizedBox(width: 10),

                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.post['userId'])
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Loading...");
                          }

                          var userData = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userData['name']),
                              Text(
                                widget.post['userEmail'] ?? "User",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
