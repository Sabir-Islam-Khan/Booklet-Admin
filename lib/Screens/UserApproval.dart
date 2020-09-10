import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class UserApproval extends StatefulWidget {
  @override
  _UserApprovalState createState() => _UserApprovalState();
}

class _UserApprovalState extends State<UserApproval> {
  @override
  Widget build(BuildContext context) {
    // total Height and width constains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "User Manager",
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    "Manage Users",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("Users").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 40.0,
                        width: totalWidth * 1,
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: totalWidth * 0.2,
                                ),
                                Text(
                                  snapshot.data.documents[index].data['name'],
                                ),
                                SizedBox(
                                  width: totalWidth * 0.2,
                                ),
                                FlutterSwitch(
                                  width: 70.0,
                                  height: 20.0,
                                  valueFontSize: 14.0,
                                  toggleSize: 15.0,
                                  value: snapshot
                                      .data.documents[index].data["isApproved"],
                                  borderRadius: 10.0,
                                  padding: 2.0,
                                  showOnOff: true,
                                  activeColor: Colors.green,
                                  inactiveColor: Colors.red,
                                  activeText: "Allow",
                                  inactiveText: "Deny",
                                  onToggle: (val) {
                                    setState(() {
                                      print("Function Starts");
                                    });
                                    String docId = snapshot
                                        .data.documents[index].documentID
                                        .toString();
                                    Firestore.instance
                                        .collection("Users")
                                        .document(docId)
                                        .updateData({
                                      'isApproved': val,
                                    });

                                    setState(() {
                                      print("DATA PUSHED ==== $val");
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
