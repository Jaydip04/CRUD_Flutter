import 'package:crud_flutter/common/toast.dart';
import 'package:crud_flutter/pages/Home.dart';
import 'package:crud_flutter/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class employee extends StatefulWidget {
  const employee({super.key});

  @override
  State<employee> createState() => _employeeState();
}

class _employeeState extends State<employee> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Employee",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Form",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
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
                    fontSize: 24.0,
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
                    fontSize: 24.0,
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
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          showToast(message: "Please Enter Name Fields");
                          return;
                        } else if (ageController.text.isEmpty) {
                          showToast(message: "Please Enter Age Fields");
                          return;
                        } else if (locationController.text.isEmpty) {
                          showToast(message: "Please Enter Location Fields");
                          return;
                        } else {
                          String id = randomAlphaNumeric(10);
                          Map<String, dynamic> employeeInfoMap = {
                            "Name": nameController.text.toString(),
                            "Age": ageController.text.toString(),
                            "Id": id,
                            "Location": locationController.text.toString(),
                          };
                          DatabaseMethods()
                              .addEmployeeDetails(employeeInfoMap, id)
                              .then((value) {
                            nameController.clear();
                            ageController.clear();
                            locationController.clear();
                            FocusScope.of(context).unfocus();
                            showToast(message: "Employee Details has been uploaded successfully");
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                home()), (Route<dynamic> route) => false);
                          });
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
