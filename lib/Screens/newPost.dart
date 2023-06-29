import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPost extends StatefulWidget {
  static String routeName = "/NewPost";
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File? _image;
  final picker = ImagePicker();
  bool _showStaticPrice = false;
  TextEditingController _captionController = TextEditingController();
  TextEditingController _staticPriceController = TextEditingController();

  Future<void> _selectAndCropImage() async {
    final pickedFile = await showModalBottomSheet<PickedFile>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a Picture'),
                onTap: () async {
                  // Navigator.pop(context,
                      // await picker.getImage(source: ImageSource.camera));
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  // Navigator.pop(context,
                      // await picker.getImage(source: ImageSource.gallery));
                },
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      ImageCropper myImageCropper = ImageCropper();
      File? croppedImage = await myImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio:
            CropAspectRatio(ratioX: 1, ratioY: 1), // Set TikTok ratio (1:1)
        compressQuality: 70, // Adjust compression quality as needed
        maxHeight: 1080, // Set maximum height of the cropped image
        maxWidth: 1080, // Set maximum width of the cropped image
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
      );

      if (croppedImage != null) {
        setState(() {
          _image = croppedImage;
        });
      }
    }
  }

  void _createPost() {
    String caption = _captionController.text.trim();
    if (_image != null && caption.isNotEmpty) {
      // Perform the post creation logic here
      if (_showStaticPrice) {
        String staticPrice = _staticPriceController.text.trim();
        if (staticPrice.isNotEmpty) {
          // Add the static price to the post
        }
      }
      // Reset the form
      setState(() {
        _image = null;
        _captionController.clear();
        _staticPriceController.clear();
        _showStaticPrice = false;
      });
      Fluttertoast.showToast(msg: 'Post created successfully');
    } else {
      Fluttertoast.showToast(msg: 'Please select an image and enter a caption');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _selectAndCropImage,
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/comment.svg',
                            width: 48,
                            height: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text('Tap to select an image'),
                        ],
                      ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                labelText: 'Caption',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _showStaticPrice,
                  onChanged: (value) {
                    setState(() {
                      _showStaticPrice = value ?? false;
                    });
                  },
                ),
                Text('Add Static Price'),
              ],
            ),
            if (_showStaticPrice) ...[
              SizedBox(height: 16),
              TextField(
                controller: _staticPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Static Price',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createPost,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
