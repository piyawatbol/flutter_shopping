import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pgt_app/ipcon.dart';
import 'package:pgt_app/widget/custom_text.dart';
import 'package:pgt_app/widget/loading_screen.dart';
import 'package:pgt_app/widget/toast_custom.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController user_name = TextEditingController();
  TextEditingController pass_word = TextEditingController();
  TextEditingController confirm_pass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool statusLoading = false;

  register() async {
    print(user_name.text);
    var url = Uri.parse('$ipcon/api/user/register');
    var response = await http.post(url, body: {
      "userName": user_name.text,
      "password": pass_word.text,
      "user_fname": first_name.text,
      "user_lname": last_name.text,
      "email": email.text,
      "user_tel": phone.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        statusLoading = false;
      });
      if (data['status'] == 'success') {
        Navigator.pop(context);
      }
    }
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
            child: Stack(
              children: [
                Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildBackArrow(),
                        Image.asset("assets/images/Register.png"),
                        SizedBox(height: height * 0.03),
                        buildInputBox('ชื่อ', "กรุณากรอกชื่อ", first_name),
                        buildInputBox('นามสกุล', "กรุณากรอกนามสกุล", last_name),
                        buildInputBox('อีเมล', "กรุณากรอกอีเมล", email),
                        buildInputBox('โทรศัพท์', "กรุณากรอกโทรศัพท์", phone),
                        buildInputBox(
                            'ชื่อผู้ใช้', "กรุณากรอกชื่อผู้ใช้", user_name),
                        buildInputBox(
                            'รหัสผ่าน', "กรุณากรอกรหัสผ่าน", pass_word),
                        buildInputBox('รหัสผ่าน อีกครั้ง',
                            "กรุณากรอกยืนยันรหัสผ่าน", confirm_pass),
                        SizedBox(height: height * 0.02),
                        buildRegisButton()
                      ],
                    ),
                  ),
                ),
                LoadingScreen(statusLoading: statusLoading)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackArrow() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.03, horizontal: width * 0.05),
          child: IconButton(
            icon: Image.asset("assets/images/backicon.png"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Widget buildInputBox(
      String? text1, String? text2, TextEditingController? controller) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.08, vertical: height * 0.01),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return ('$text2');
          }
          return null;
        },
        style: GoogleFonts.kanit(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        cursorColor: Colors.pink,
        obscureText:
            text1 == "รหัสผ่าน" || text1 == "รหัสผ่าน อีกครั้ง" ? true : false,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: '$text1',
          hintStyle: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: width * 0.06, vertical: height * 0.0),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.white,
              width: 3,
            ),
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
          final isValid = formKey.currentState!.validate();
          if (isValid) {
            if (pass_word.text == confirm_pass.text) {
              register();
            } else {
              Toast_Custom("รหัสผ่านไม่ตรงกัน", Colors.red);
            }
          }
        },
        child: Center(
          child: Custom_text(
            color: Colors.black,
            fontSize: 18,
            fontWeight: null,
            text: 'สมัครสมาชิก',
          ),
        ),
      ),
    );
  }
}
