import 'package:flutter/material.dart';
import 'package:project_diu_swap/widgets/bold_text.dart';

class ProductDetails extends StatelessWidget {
  final Map<String, dynamic> post;

  const ProductDetails({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
            // 🔥 IMAGE
            Stack(
              children: [
                Image.network(
                  post['images'][0],
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.black54,
                    child: Text("1/5", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),

            // 🔥 DETAILS
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    post['title'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  // PRICE
                  Text(
                    "৳ ${post['price']}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  // LOCATION + TIME
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 5),
                      Text(post['location'] ?? ""),
                      Spacer(),
                      Text("2 hours ago"), // later dynamic
                    ],
                  ),

                  SizedBox(height: 20),

                  // DESCRIPTION TITLE
                  BoldText(str: "Description", fontSize: 16, bottom: 5),

                  // DESCRIPTION
                  Text(post['description'] ?? ""),

                  SizedBox(height: 15),

                  BoldText(str: "Contact Number", fontSize: 16, bottom: 5),

                  Text(post['phoneNumber']?.toString() ?? "No number"),

                  SizedBox(height: 20),

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

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post['userEmail'] ?? "User"),
                          Text("DIU", style: TextStyle(color: Colors.grey)),
                        ],
                      ),

                      Spacer(),

                      OutlinedButton(
                        onPressed: () {},
                        child: Text("View Profile"),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // BUTTONS
                  Row(
                    children: [
                      // CALL
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.call),
                          label: Text("Call"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),

                      SizedBox(width: 10),

                      // MESSAGE
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.message),
                          label: Text("Message"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
