import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pgt_app/ipcon.dart';
import 'package:pgt_app/main.dart';
import 'package:pgt_app/screen/login_system/register_screen.dart';
import 'package:pgt_app/widget/custom_text.dart';
import 'package:pgt_app/widget/toast_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user_name = TextEditingController();
  TextEditingController pass_word = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  bool statusLoading = false;
  List userList = [];

  login() async {
    // final response = await http.get(Uri.parse(
    //     "$ipcon/api/user/login?userName=${user_name.text}&password=${pass_word.text}"));
    // var data = json.decode(response.body);
    // print(data);
    // if (data['detail'] == "username or password incorrect") {
    //   Toast_Custom("ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง", Colors.red);
    // } else {
    //   setState(() {
    //     userList = data['data'];
    //   });
    //   print(userList);
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    //   preferences.setString('user_id', userList[0]['userID'].toString());
    // }
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return TabButtom();
    }));
  }

  String hintText1 = 'ชื่อผู้ใช้';
  String hintText2 = 'รหัสผ่าน';
  @override
  void initState() {
    focusNode1.addListener(() {
      if (focusNode1.hasFocus) {
        setState(() {
          hintText1 = '';
        });
      } else {
        setState(() {
          hintText1 = 'ชื่อผู้ใช้';
        });
      }
    });
    focusNode2.addListener(() {
      if (focusNode2.hasFocus) {
        setState(() {
          hintText2 = '';
        });
      } else {
        setState(() {
          hintText2 = 'รหัสผ่าน';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg.jpg'),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.08),
                  child: Image.asset("assets/images/Login.png"),
                ),
                buildInputBox(hintText1, user_name, focusNode1),
                buildInputBox(hintText2, pass_word, focusNode2),
                SizedBox(height: height * 0.1),
                buildLoingButton(),
                buildRegisButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputBox(
      String? text, TextEditingController? controller, FocusNode? focusNode) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.02),
      width: width * 0.65,
      height: height * 0.07,
      decoration: BoxDecoration(
        color: Color(0xffFFF4F4),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 0.3,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: TextField(
          obscureText: controller == pass_word ? true : false,
          controller: controller,
          focusNode: focusNode,
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          cursorColor: Colors.pink,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: width * 0.06),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildLoingButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.5,
      height: height * 0.07,
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Color(0xffFFF4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onPressed: () {
          login();
        },
        child: Center(
          child: Custom_text(
            color: Colors.black,
            fontSize: 18,
            fontWeight: null,
            text: 'เข้าสู่ระบบ',
          ),
        ),
      ),
    );
  }

  Widget buildRegisButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.5,
      height: height * 0.07,
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Color(0xffFFF4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return RegisterScreen();
          }));
        },
        child: Center(
          child: Custom_text(
            color: Colors.black,
            fontSize: 17,
            fontWeight: null,
            text: 'สมัครสมาชิก',
          ),
        ),
      ),
    );
  }
}
