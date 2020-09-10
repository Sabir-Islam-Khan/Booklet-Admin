import 'package:booklet_admin/Screens/AddProducts.dart';
import 'package:booklet_admin/Screens/UserApproval.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Center(
            child: Text("HomePage"),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: totalHeight * 0.01,
            ),

            // card for user manager
            Center(
              child: Card(
                elevation: 7.0,
                child: Container(
                  height: totalHeight * 0.15,
                  width: totalWidth * 0.96,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red[200],
                        Colors.red[400],
                        Colors.red[500],
                      ],
                    ),
                  ),
                  // navigator for user manager screen
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserApproval(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "User Manager",
                        style: GoogleFonts.meriendaOne(
                          color: Colors.white,
                          fontSize: totalHeight * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: totalHeight * 0.01,
            ),
            // card for Adding product
            Center(
              child: Card(
                elevation: 7.0,
                child: Container(
                  height: totalHeight * 0.15,
                  width: totalWidth * 0.96,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red[200],
                        Colors.red[400],
                        Colors.red[500],
                      ],
                    ),
                  ),
                  // navigator for user manager screen
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProducts(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Add Products",
                        style: GoogleFonts.meriendaOne(
                          color: Colors.white,
                          fontSize: totalHeight * 0.025,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
