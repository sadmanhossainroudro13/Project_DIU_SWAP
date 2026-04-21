import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// class FirebaseService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   //Function to get image url
  
//   Future<String> uploadImage(File file) async {
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();

//     Reference ref = _storage.ref().child('posts/$fileName');

//     await ref.putFile(file);

//     String url = await ref.getDownloadURL();

//     return url;
//   }
// }
