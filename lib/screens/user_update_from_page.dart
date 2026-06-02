import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/screens/admin_all_users_page.dart';
import 'package:sem5project/widgets/formButton.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class UserUpdateFormPage extends StatefulWidget {
  final String name;
  final String mno;
  final String password;
  final String email;

  UserUpdateFormPage({required this.name, required this.mno, required this.password,required this.email});

  @override
  State<UserUpdateFormPage> createState() => _UserUpdateFormPageState();
}

class _UserUpdateFormPageState extends State<UserUpdateFormPage> {
  TextEditingController nameController=TextEditingController();
  TextEditingController mnoController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool isLoad=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text=widget.name;
    mnoController.text=widget.mno;
    passwordController.text=widget.password;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Update User",
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 24.sp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 70.h,),
              RoundedTextfield(icon: Icon(Icons.person), controller: nameController),
              RoundedTextfield(icon: Icon(Icons.person), controller: mnoController),
              RoundedTextfield(icon: Icon(Icons.person), controller: passwordController),
              SizedBox(height: 40.h,),
              FormButton(name: "Update", isload: isLoad, onpress: () async {
                if(nameController.text!=""&&mnoController.text!=""&&passwordController.text!="")
                {
                  isLoad=true;
                  setState(() {

                  });
                  Map map={
                    'email': widget.email,
                    'name': nameController.text,
                    'mno': mnoController.text,
                    'password': passwordController.text,
                  };
                  var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/updateUser.php');
                  var response = await http.post(url, body: map);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminAllUsersPage(),));
                  successToast("Success", "User Updated Successfully", context);
                }
                else
                {
                  isLoad=false;
                  setState(() {

                  });
                  errorToast("Warning", "Please fill all data", context);
                }
              },)
            ],
          ),
        ),
      ),
    );
  }

  Widget RoundedTextfield(
      {
        required Icon icon,
        required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: SizedBox(
        height: 50.h,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.h,),
            labelStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
                fontFamily: "poppins",
                fontWeight: FontWeight.w500),
            suffixIcon: icon,
            enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.grey,width: 1)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.black,width: 2)),
          ),
        ),
      ),
    );
  }
}
