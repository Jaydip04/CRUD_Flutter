import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/pages/employee.dart';
import 'package:crud_flutter/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/toast.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  Stream? EmplyoeeStream;

  getontheload() async {
    EmplyoeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmplyoeeDetails() {
    return StreamBuilder(
        stream: EmplyoeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name : " + ds["Name"],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      nameController.text = ds["Name"];
                                      ageController.text = ds["Age"];
                                      locationController.text = ds["Location"];
                                      EditEmployeeDetail(ds["Id"]);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  GestureDetector(
                                      onTap: ()async{
                                        await DatabaseMethods().deleteEmployeeDetails(ds["Id"]);
                                      },
                                      child: Icon(
                                    Icons.delete,
                                    color: Colors.orange,
                                  ))
                                ],
                              ),
                              Text(
                                "Age : " + ds["Age"],
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Location : " + ds["Location"],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                employee()), (Route<dynamic> route) => false);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Flutter",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Firebase",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Column(
            children: [
              Expanded(child: allEmplyoeeDetails()),
            ],
          ),
        ));
  }

  Future EditEmployeeDetail(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel),
                        ),
                        SizedBox(
                          width: 60.0,
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Details",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Age",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: ageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateInfo = {
                            "Name": nameController.text.toString(),
                            "Age": ageController.text.toString(),
                            "Id": id,
                            "Location": locationController.text.toString(),
                          };
                          await DatabaseMethods()
                              .updateEmployeeDetails(id, updateInfo)
                              .then((onValue) {
                            showToast(
                                message:
                                    "Employee Details has been updated successfully");
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Update"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
}
