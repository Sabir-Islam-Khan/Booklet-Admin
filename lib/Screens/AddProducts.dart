import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
          child: Column(
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

              GestureDetector(
                onTap: () {},
                child: Image(
                  image: AssetImage('assets/images/photo.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
