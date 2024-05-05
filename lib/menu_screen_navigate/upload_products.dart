// ignore_for_file: unused_import, unused_field, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db.dart' as db;
import 'package:image_picker/image_picker.dart';

var imageUrl;

// ignore: camel_case_types
class Upload_product extends StatefulWidget {
  const Upload_product({Key? key}) : super(key: key);

  @override
  State<Upload_product> createState() => _UploadProductState();
}

class _UploadProductState extends State<Upload_product> {
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController productCategory = TextEditingController();

  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Upload Products'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// Image Uploading Start

                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 200,
                      )
                    : Container(
                        // height: 200,
                        ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      child: const Text('Take a Picture'),
                    ),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: const Text('Choose from Gallery'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Image Uploading end
                const Text(
                  'Product Name',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: productName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }

                    // Check if the value starts with a space
                    if (value.startsWith(' ')) {
                      return 'Product name should not start with a space';
                    }

                    // Define a regex pattern to match only text (letters) and spaces between words
                    RegExp regex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid product name containing only letters';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter product name',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Product Price',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: productPrice,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product price';
                    }
                    // Define a regex pattern to match Rupees input (numbers only)
                    RegExp regex = RegExp(r'^[0-9]+$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid price in Rupees';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter product price',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Product Quantity',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: productQuantity,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product quantity';
                    }

                    RegExp regex = RegExp(r'^([1-9]|[1-9][0-9]|100)$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a number from 1 to 100';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter product quantity',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Product Category',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: productCategory,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product category';
                    }

                    // Define the list of allowed categories
                    List<String> allowedCategories = [
                      'Toys',
                      'Skin Care',
                      'Wet wipes',
                      'Nutrition and Supplies',
                      'Nipple Pacifier',
                      'Medicine',
                      'Feeding bottle',
                      'Bath accessories',
                    ];

                    if (!allowedCategories.contains(value)) {
                      return 'Please enter a valid product category from the provided list';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter product category',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _uploadImage();

                        uploadInvoice();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xff374366),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Upload Item',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      // print('No image selected');
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${db.dblink}/uploadImage'),
      );
      request.fields['filename'] = productName.text.toString();
      request.files
          .add(await http.MultipartFile.fromPath('filename', _imageFile!.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var msg = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          imageUrl = msg['image'];
        });
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        // Handle failure
      }
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error
    }
  }

  Future<void> uploadInvoice() async {
    const String apiUrl = "${db.dblink}/uploadinvo";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ProductName': productName.text.toString(),
          'ProductPrice': int.tryParse(productPrice.text.toString()) ?? 0,
          'ProductQuantity': int.tryParse(productQuantity.text.toString()) ?? 0,
          'ProductCategory': productCategory.text.toString(),
          'imageurl': imageUrl.toString()
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Item Added')));
      } else if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item Updated Succesfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode} / ${response.body}'),
          ),
        );
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
