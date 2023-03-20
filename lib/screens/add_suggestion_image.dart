// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/screens/render_all_suggestions.dart';
import 'package:dss/widgets/my_bottom.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class AddSuggestionImage extends StatefulWidget {
  final String suggestionUid;

  const AddSuggestionImage({super.key, required this.suggestionUid});
  @override
  _AddSuggestionImageState createState() => _AddSuggestionImageState();
}

class _AddSuggestionImageState extends State<AddSuggestionImage> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

  Future _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> uploadImage(File _image) async {
    String? imageUrl;

    // Create a reference to the Firebase Storage location where the file will be uploaded
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('suggestion_images/${path.basename(_image.path)}}');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() async {
      try {
        imageUrl = await storageReference.getDownloadURL();
      } catch (e) {
        // Handle any errors that occur while getting the download URL
        print('Error getting download URL: $e');
      }
    });

    return imageUrl;
  }

  Future<String?> updateSuggestionWithImage(
      String suggestionUid, File imageFile) async {
    setState(() {
      _isUploading = true;
    });
    String? imageUrl = await uploadImage(imageFile);
    if (imageUrl != null) {
      // Update the suggestion in Firestore with the new image URL
      await FirebaseFirestore.instance
          .collection('suggestions')
          .doc(suggestionUid)
          .update({'imageUrl': imageUrl});
    } else {
      return null;
    }

    setState(() {
      _isUploading = false;
    });
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestion Box'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Add a photo (optional)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            if (_image != null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(_image!),
                  ),
                ),
              ),
            if (_image == null)
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: Icon(Icons.photo_camera, size: 64),
              ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await _getImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: _isUploading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_image != null) {
                          await updateSuggestionWithImage(
                              widget.suggestionUid, _image!);
                        }
                        // print('after mounted');

                        // if (mounted) return;

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBottom(),
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Suggestion added successfully!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text('Submit'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
