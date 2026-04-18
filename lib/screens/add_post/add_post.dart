import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_diu_swap/services/cloudinary_service.dart';
import 'package:project_diu_swap/widgets/bold_text.dart';
import 'package:project_diu_swap/widgets/customButton.dart';
import 'package:project_diu_swap/screens/add_post/widgets/custom_drop_down.dart';
import 'package:project_diu_swap/screens/add_post/widgets/custom_textfield.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_diu_swap/screens/add_post/widgets/upload_photo_widget.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool isLoading = false;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String? selectedCategory;

  List<XFile> images = [];

  final ImagePicker picker = ImagePicker();

  // Pick Image Function
  Future<void> pickImages() async {
    final selectedImage = await picker.pickMultiImage();
    if (selectedImage.isNotEmpty) {
      setState(() {
        images.addAll(selectedImage);
      });
    }
  }

  //Submit Post Function

  Future<void> submitPost() async {
    String title = _titleController.text;
    int? price = int.tryParse(_priceController.text);
    String location = _locationController.text;
    String description = _descriptionController.text;
    int? phoneNumber = int.tryParse(_phoneNumberController.text);

    if (title.isEmpty ||
        location.isEmpty ||
        images.isEmpty ||
        selectedCategory == null ||
        price == null ||
        phoneNumber == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Pleas fill all required fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      //Object of Cloudinary service
      CloudinaryService service = CloudinaryService();
      //store image urls
      List<String> imageUrls = [];

      for (var img in images) {
        String url = await service.uploadImage(File(img.path));
        imageUrls.add(url);
      }

      await FirebaseFirestore.instance.collection("posts").add({
        "title": title,
        "price": price,
        "category": selectedCategory,
        "location": location,
        "description": description,
        "phoneNumber": phoneNumber,
        "images": imageUrls,
        "createdAt": Timestamp.now(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Post Uploaded Successfully")));

      _titleController.clear();
      _priceController.clear();
      _locationController.clear();
      _descriptionController.clear();
      _phoneNumberController.clear();

      setState(() {
        images.clear();
        selectedCategory = null;
      });
    } catch (e) {
      print("Error: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Post",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldText(str: 'Upload Photos'),

              SizedBox(height: 10),

              //image
              UploadPhotoWidget(
                images: images,
                onAdd: pickImages,
                onRemove: (index) {
                  setState(() {
                    images.removeAt(index);
                  });
                },
              ),

              BoldText(str: "Title"),

              CustomTexField(
                controller: _titleController,
                hint: "Enter item title",
              ),

              //Price
              BoldText(str: "Price"),

              CustomTexField(
                controller: _priceController,
                hint: "Enter price",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              //Category
              BoldText(str: "Category"),

              CustomDropdown(
                selectedCategory: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              //Location
              BoldText(str: "Location"),

              CustomTexField(
                controller: _locationController,
                hint: "YKSG hall-1, Daffodil International University",
                maxLines: 1,
              ),
              //Description
              BoldText(str: "Description"),

              CustomTexField(
                controller: _descriptionController,
                hint: "Describe your item...",
                maxLines: 2,
              ),

              BoldText(str: "Phone Number"),

              CustomTexField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hint: "Enter contact number",
              ),

              SizedBox(height: 5),

              //PostAdd Button
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Custombutton(
                      buttonText: "Post Ad",
                      buttonFunction: submitPost,
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
