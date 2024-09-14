import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File?
      image; //This is a nullable File object that will store the selected image file once it's picked from the gallery.
  final picker =
      ImagePicker(); //This is an instance of the ImagePicker class, which allows the app to access the device's gallery or camera for selecting images.
  bool showSpinner = false;
  Future getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile
          .path); // // Creating a File object from the image's path and store i image variable
      setState(() {
//// This updates the UI to reflect that an image was selected
      });
    } else {
      print('no image selected');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;//Show Spinner (Loading Indicator)
    });//
    var stream = new http.ByteStream(image!.openRead());//The ByteStream class handles the streaming of byte data efficiently, which is crucial for uploading files
    stream.cast();//The cast ensures that the stream is interpreted as a stream of bytes, which is necessary for uploading files.
    var length = await image!.length();//Get the File Length
    var uri = Uri.parse('https://fakestoreapi.com/products');// Define the API Endpoint (URI)
    var request = new http.MultipartRequest('POST', uri);//Create a Multipart POST Request

    request.fields['title'] = "Static title";//Add Text Fields to the Request
    var multiport = new http.MultipartFile('image', stream, length);//Create a MultipartFile for the Image
    request.files.add(multiport);//Add the Image File to the Request

    var response = await request.send();// Send the Request
    print(response.stream.toString());//Print the Response Stream

    if (response.statusCode == 200) {//Handle the Response (Success or Failure)
      setState(() {
        showSpinner = false;
      });
      print('image uploaded');
    } else {
      setState(() {
        showSpinner = false;
      });
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(title: Text('upload image')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  child: image == null
                      ? Center(
                          child: Text('pick image'),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path),
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage();
                },
                child: Container(
                  height: 40,
                  width: 200,
                  child: Center(child: Text('Upload Image')),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
//Image Selection: The user can select an image from the device's gallery using the getImage() function. The selected image is stored in the image variable, and the UI is updated to reflect the change.
// Image Upload: When the uploadImage() function is triggered, a loading spinner is shown to indicate that the image upload process has started. The upload logic will follow the spinner initialization.
