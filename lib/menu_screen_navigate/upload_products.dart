// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../db.dart' as db;
import 'package:image_picker/image_picker.dart';

class Upload_product extends StatefulWidget {
  const Upload_product({Key? key});

  @override
  State<Upload_product> createState() => _Upload_productState();
}

class _Upload_productState extends State<Upload_product> {
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController productCategory = TextEditingController();

  File? _image;

  Future<void> _uploadImage() async {
    var uri = Uri.parse('YOUR_NODEJS_API_ENDPOINT/uploadImage');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('filename', _image!.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(await response.stream.bytesToString());
      String imageUrl = jsonResponse['image'];
      print('Image uploaded. URL: $imageUrl');
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  }
// Future<File> pickImage() async {
//     // Implementation depends on the image picker library you're using
//     // Example using image_picker package

//     File image = (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
//     return image;
//   }
  // File? _image;

  final picker = ImagePicker();

  // Future getImage() async {
  //   // final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // Future uploadImage() async {
  //   if (_image == null) {
  //     print('No image selected.');
  //     return;
  //   }

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('${db.dblink}/uploadImage'), // Replace with your API endpoint
  //   );

  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       'image',
  //       _image!.path,
  //     ),
  //   );

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     print('Image uploaded successfully');
  //   } else {
  //     print('Failed to upload image. Error: ${response.reasonPhrase}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff374366),
        title: Text('Upload Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//             Center(
//               child: _image == null
//                   ? Text('No image selected')
//                   : Image.file(_image!),
//             ),
// FloatingActionButton(
//               onPressed: () async {
//                 // Select an image from the gallery
//                 // You may need to include the image_picker package for this
//                 // https://pub.dev/packages/image_picker
//                 // This example assumes you have already implemented image picking
//                 File image = await pickImage();
//                 setState(() {
//                   _image = image;
//                 });
//               },
//               tooltip: 'Pick Image',
//               child: Icon(Icons.add_a_photo),
//             ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     _image == null
            //         ? Text('No image selected.')
            //         : Image.file(_image!),
            //     SizedBox(height: 20),
            //     ElevatedButton(
            //       onPressed: getImage,
            //       child: Text('Select Image'),
            //     ),
            //     SizedBox(height: 20),
            //     ElevatedButton(
            //       onPressed: uploadImage,
            //       child: Text('Upload Image'),
            //     ),
            //   ],
            // ),
            Text(
              'Product Name',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productName,
              decoration: InputDecoration(
                hintText: 'Enter product name',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Product Price',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productPrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter product price',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Product Quantity',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productQuantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter product quantity',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Product Category',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productCategory,
              decoration: InputDecoration(
                hintText: 'Enter product category',
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  uploadInvoice();
                },
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Upload Item',
                      style: TextStyle(fontSize: 15),
                    )),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff374366)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> uploadInvoice() async {
    final String apiUrl = "${db.dblink}/uploadinvo";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ProductName': productName.text.toString(),
          'ProductPrice': int.tryParse(productPrice.text.toString()) ?? 0,
          'ProductQuantity': int.tryParse(productQuantity.text.toString()) ?? 0,
          'ProductCategory': productCategory.text.toString(),
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Item Added')));
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User Already Exists.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${response.statusCode} / ${response.body}')));
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
