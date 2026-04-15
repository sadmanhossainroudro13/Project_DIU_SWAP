import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class CloudinaryService {
  Future<String> uploadImage(File file) async {
    String cloudName = "dznxzqbth";
    String uploadPreset = "diu_swap_upload";

    var url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    var request = http.MultipartRequest("POST", url);

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var resData = await response.stream.bytesToString();
      var data = jsonDecode(resData);
      return data['secure_url'];
    } else {
      throw Exception("Upload failed");
    }
  }
}
