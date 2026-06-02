import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:sem5project/modalclasses/usersJsonParse.dart';
import 'package:sem5project/screens/user_update_from_page.dart';
import 'package:sem5project/widgets/formButton.dart';
import '../constants.dart';

class AdminAllUsersPage extends StatefulWidget {
  const AdminAllUsersPage({super.key});

  @override
  State<AdminAllUsersPage> createState() => _AdminAllUsersPageState();
}

class _AdminAllUsersPageState extends State<AdminAllUsersPage> {
  UsersJsonParse? u1;
  bool isLoad=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Users",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
      ),
      body: isLoad?Center(
        child: LoadingAnimationWidget.threeRotatingDots(color: primaryColor, size: 60.w),
      ):(u1!.userJsonParse.isEmpty?Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Text("No users are registered yet",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppins"
              )),
        ),
      ):Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: u1!.userJsonParse.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex :2,
                                child: Container(
                                  height: 50.h,
                                  width: 50.w,
                                  child: Image.asset("LogoImages/profile.png"),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${u1!.userJsonParse[index].name}",style: TextStyle(fontFamily: "poppins")),
                                      Text("${u1!.userJsonParse[index].email}",style: TextStyle(fontFamily: "poppins")),
                                      Text("${u1!.userJsonParse[index].mno}",style: TextStyle(fontFamily: "poppins"))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserUpdateFormPage(name: "${u1!.userJsonParse[index].name}", mno: "${u1!.userJsonParse[index].mno}", password: "${u1!.userJsonParse[index].password}",email: "${u1!.userJsonParse[index].email}",)));
                              }, child: Text("Update"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor
                              ),
                              ),
                              SizedBox(width: 10.w,),
                              ElevatedButton(
                                onPressed: () async {
                                  isLoad=true;
                                  setState(() {

                                  });
                                  Map map={
                                    'email': u1!.userJsonParse[index].email
                                  };
                                  var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/adminDeleteUser.php');
                                  var response = await http.post(url, body: jsonEncode(map));
                                  isLoad=true;
                                  getUsers();
                                  setState(() {

                                  });
                              },
                                  child: Text("Delete"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                );
              },),
          )
        ],
      )),
    );
  }

  Future<void> getUsers() async {
    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/getAllUsers.php');
    var response = await http.post(url);
    Map map=jsonDecode(response.body);
    u1=UsersJsonParse(map: map);
    isLoad=false;
    setState(() {

    });

  }
}
