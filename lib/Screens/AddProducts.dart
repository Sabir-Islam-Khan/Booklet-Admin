import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  // text controllers
  final nameController = TextEditingController();
  final sizeController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  // variables for image selection and upload
  File _imageOne;
  File _imageTwo;
  File _imageThree;
  File _imageFour;

  final picker = ImagePicker();

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://digital-booklet-6f8a5.appspot.com");

  // function to select image one;
  Future getImageOne() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(
      () {
        _imageOne = File(pickedFile.path);
      },
    );
  }

  // function to select second image
  Future getImageTwo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(
      () {
        _imageTwo = File(pickedFile.path);
      },
    );
  }

  // function to select third image
  Future getImageThree() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(
      () {
        _imageThree = File(pickedFile.path);
      },
    );
  }

  // function to select fourth image
  Future getImageFour() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(
      () {
        _imageFour = File(pickedFile.path);
      },
    );
  }

  // function to upload whole product
  void uploadProduct(File image1, File image2, File image3, File image4,
      BuildContext ctx) async {
    setState(() {
      _isLoading = true;
    });

    String name = nameController.value.text;
    String size = sizeController.value.text;

    // putting image one
    StorageTaskSnapshot snapshot = await _storage
        .ref()
        .child("$name-$size/${DateTime.now().microsecondsSinceEpoch}")
        .putFile(image1)
        .onComplete;
    final String downloadUrlOne = await snapshot.ref.getDownloadURL();

    // putting image 2

    StorageTaskSnapshot snapshot2 = await _storage
        .ref()
        .child("$name-$size/${DateTime.now().microsecondsSinceEpoch}")
        .putFile(image2)
        .onComplete;
    final String downloadUrlTwo = await snapshot2.ref.getDownloadURL();

    // putting image 3

    StorageTaskSnapshot snapshot3 = await _storage
        .ref()
        .child("$name-$size/${DateTime.now().microsecondsSinceEpoch}")
        .putFile(image3)
        .onComplete;
    final String downloadUrlThree = await snapshot3.ref.getDownloadURL();

    // putting image 4

    StorageTaskSnapshot snapshot4 = await _storage
        .ref()
        .child("$name-$size/${DateTime.now().microsecondsSinceEpoch}")
        .putFile(image4)
        .onComplete;
    final String downloadUrlFour = await snapshot4.ref.getDownloadURL();

    await Firestore.instance.collection("Products").add({
      'name': nameController.value.text,
      'size': sizeController.value.text,
      'price': priceController.value.text,
      'details': descriptionController.value.text,
      'imgLinkOne': downloadUrlOne,
      'imgLinkTwo': downloadUrlTwo,
      'imgLinkThree': downloadUrlThree,
      "imgLinkFour": downloadUrlFour,
    });

    nameController.clear();
    sizeController.clear();
    priceController.clear();
    descriptionController.clear();
    setState(() {
      _isLoading = false;
      _imageOne = null;
      _imageTwo = null;
      _imageThree = null;
      _imageFour = null;
    });

    Alert(
      context: context,
      type: AlertType.success,
      title: "Congrats !",
      desc: "Product was uploaded successfully !",
      buttons: [
        DialogButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  // bool var for loading state
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Center(
            child: Text("Add Products"),
          ),
        ),
        body: SingleChildScrollView(
          child: _isLoading == true
              ? Container(
                  height: totalHeight * 1,
                  width: totalWidth * 1,
                  color: Colors.red[200],
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Please wait...",
                            style: GoogleFonts.meriendaOne(
                              color: Colors.white,
                              fontSize: totalHeight * 0.025,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: totalHeight * 0.2,
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: totalHeight * 0.01,
                    ),
                    // text field for name
                    Center(
                      child: Container(
                        width: totalWidth * 0.95,
                        child: Center(
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Enter Product Name",
                              labelText: "Name ",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: totalHeight * 0.009,
                    ),
                    // text field for size
                    Center(
                      child: Container(
                        width: totalWidth * 0.95,
                        child: Center(
                          child: TextField(
                            controller: sizeController,
                            decoration: InputDecoration(
                              hintText: "Enter Product Size",
                              labelText: "Size ",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: totalHeight * 0.009,
                    ),
                    // text field for price
                    Center(
                      child: Container(
                        width: totalWidth * 0.95,
                        child: Center(
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Enter Product Price",
                              labelText: "Price ",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: totalHeight * 0.009,
                    ),
                    // text field for details
                    Center(
                      child: Container(
                        width: totalWidth * 0.95,
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: descriptionController,
                            decoration: InputDecoration(
                              hintText: "Enter Product Description",
                              labelText: "Details",
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: totalHeight * 0.02,
                    ),

                    Center(
                      child: Text(
                        "Tap to pick image :",
                        style: GoogleFonts.meriendaOne(
                          color: Colors.black,
                          fontSize: totalHeight * 0.024,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: totalHeight * 0.01,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // first image section
                        GestureDetector(
                          onTap: () {
                            getImageOne();
                          },
                          child: _imageOne == null
                              ? Image(
                                  height: totalHeight * 0.1,
                                  width: totalWidth * 0.2,
                                  image: AssetImage('assets/images/photo.png'),
                                )
                              : Container(
                                  height: totalHeight * 0.1,
                                  width: totalWidth * 0.2,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.file(
                                      _imageOne,
                                    ),
                                  ),
                                ),
                        ),

                        // second image section
                        SizedBox(
                          width: totalWidth * 0.04,
                        ),
                        GestureDetector(
                          onTap: () {
                            getImageTwo();
                          },
                          child: _imageTwo == null
                              ? Image(
                                  height: totalHeight * 0.1,
                                  width: totalWidth * 0.2,
                                  image: AssetImage('assets/images/photo.png'),
                                )
                              : Container(
                                  height: totalHeight * 0.1,
                                  width: totalWidth * 0.2,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.file(
                                      _imageTwo,
                                    ),
                                  ),
                                ),
                        ),

                        SizedBox(
                          width: totalWidth * 0.04,
                        ),

                        // third image section

                        GestureDetector(
                          onTap: () {
                            getImageThree();
                          },
                          child: _imageThree == null
                              ? Image(
                                  height: totalHeight * 0.1,
                                  width: totalWidth * 0.2,
                                  image: AssetImage('assets/images/photo.png'),
                                )
                              : Container(
                                  height: totalHeight * 0.1,
                                  width: totalWidth * 0.2,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.file(
                                      _imageThree,
                                    ),
                                  ),
                                ),
                        ),

                        SizedBox(
                          width: totalWidth * 0.04,
                        ),

                        // fourth image section
                        GestureDetector(
                          onTap: () {
                            getImageFour();
                          },
                          child: _imageFour == null
                              ? Image(
                                  height: totalHeight * 0.1,
                                  width: totalWidth * 0.2,
                                  image: AssetImage('assets/images/photo.png'),
                                )
                              : Container(
                                  height: totalHeight * 0.1,
                                  width: totalWidth * 0.2,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.file(
                                      _imageFour,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: totalHeight * 0.1,
                    ),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          uploadProduct(
                            _imageOne,
                            _imageTwo,
                            _imageThree,
                            _imageFour,
                            context,
                          );
                        },
                        child: Card(
                          color: Colors.transparent,
                          elevation: 5.0,
                          child: Container(
                            height: totalHeight * 0.07,
                            width: totalWidth * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red[200],
                                  Colors.red[400],
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Add Product",
                                style: GoogleFonts.meriendaOne(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: totalHeight * 0.024,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
