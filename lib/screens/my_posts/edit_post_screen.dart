import 'package:flutter/material.dart';
import 'package:project_diu_swap/widgets/custom_textfield.dart';
import 'package:project_diu_swap/widgets/bold_text.dart';
import 'package:project_diu_swap/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPostScreen extends StatefulWidget {
  final Map post;
  final String postId;
  const EditPostScreen({super.key, required this.post, required this.postId});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post['title'];
    _priceController.text = widget.post['price'].toString();
    _descController.text = widget.post['description'];
    _phoneController.text = widget.post['phoneNumber'].toString();
  }

  Future<void> updatePost() async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .update({
            "title": _titleController.text,
            "price": int.parse(_priceController.text),
            "description": _descController.text,
            "phoneNumber": _phoneController.text.trim(),
          });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Post updated successfully")));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Update failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Post"),
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldText(str: "Title"),
              CustomTexField(controller: _titleController, hint: "Title"),

              BoldText(str: "Price"),
              CustomTexField(controller: _priceController, hint: "Price"),
              BoldText(str: "Description"),
              CustomTexField(controller: _descController, hint: "Description"),
              BoldText(str: "Phone"),
              CustomTexField(controller: _phoneController, hint: "Phone"),

              SizedBox(height: 10),

              Custombutton(
                buttonText: "Update",
                buttonFunction: updatePost,
                bgColor: Colors.green,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
