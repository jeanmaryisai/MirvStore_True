import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hello/Screens/Home/HomeScreen.dart';
import 'package:hello/components/data.dart';
import 'package:hello/database.dart';
import 'package:hello/models/Product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class NewPost extends StatefulWidget {
  static String routeName = "/NewPost";
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File? _image;String? url;DatabaseReference? dbRef;
  final picker = ImagePicker();
  bool _showStaticPrice = false;
  TextEditingController _captionController = TextEditingController();
  TextEditingController _staticPriceController = TextEditingController();
  TextEditingController _TitleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('users');
  }
  Future<void> _selectAndCropImage() async {
    var pickedFile;
    showModalBottomSheet<XFile>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a Picture'),
                onTap: () async {

                    pickedFile=  await picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      _image =File(pickedFile!.path);
                    });
                    Navigator.pop(context);},
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {pickedFile=  await picker.pickImage(source: ImageSource.gallery);
                // ImageCropper myImageCropper = ImageCropper();
                // File? croppedImage = await myImageCropper.cropImage(
                //   sourcePath: pickedFile.path,
                //   aspectRatio:
                //   CropAspectRatio(ratioX: 1, ratioY: 8), // Set TikTok ratio (1:1)
                //   compressQuality: 70, // Adjust compression quality as needed
                //   maxHeight: 1080, // Set maximum height of the cropped image
                //   maxWidth: 1080, // Set maximum width of the cropped image
                //   androidUiSettings: AndroidUiSettings(
                //     toolbarTitle: 'Crop Image',
                //     toolbarColor: Colors.deepPurple,
                //     toolbarWidgetColor: Colors.white,
                //     initAspectRatio: CropAspectRatioPreset.square,
                //     lockAspectRatio: true,
                //   ),
                // );
                //
                // if (croppedImage != null) {
                //   setState(() {
                //     _image = croppedImage;
                //   });
                // }

                  setState(() {
                  _image =File(pickedFile!.path);

                });
                  Navigator.pop(context);
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
            CropAspectRatio(ratioX: 1, ratioY: 8), // Set TikTok ratio (1:1)
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

  void _createPost() async{
    String caption = _captionController.text.trim();
    if (_image != null && caption.isNotEmpty) {
      // Perform the post creation logic here
      if (_showStaticPrice) {
        String staticPrice = _staticPriceController.text.trim();
        if (staticPrice.isNotEmpty) {
          // Add the static price to the post
        }
      }
      try {
        var imagefile = FirebaseStorage.instance
            .ref()
        // .child("contact_photo")
            .child("profile_pic")
            .child("/${Uuid().v4()}.jpg");
        UploadTask task = imagefile.putFile(_image!);
        TaskSnapshot snapshot = await task;
        url = await snapshot.ref.getDownloadURL();
        print('hello');
        setState(() {
          url = url;
        });
        if (url != null) {

          Product p=Product(
              title:_TitleController.text.trim(),
            description: _captionController.text.trim(),
            image: url!,
            owner: currentUser.myId, myId: Uuid().v4(),
              staticPrice:double.tryParse(_staticPriceController.text.trim())
          );
          Post post=Post(product: p.myId, caption: p.description, author: currentUser.myId, isRepost: false, myId: Uuid().v4(), liked: []);
          ProductDb.add(p);
          PostDb.add(post);
        }
      } on Exception catch (e) {
        Fluttertoast.showToast(msg: 'Error: ${e}');
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
                width: 100,
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
            ),Container(
              width: 100,
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
            SizedBox(height: 16),
            TextField(
              controller: _TitleController,

              decoration: InputDecoration(
                labelText: 'Title of the Art',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                labelText: 'Description of the Art',
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
