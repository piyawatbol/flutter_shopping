import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pgt_app/ipcon.dart';
import 'package:pgt_app/screen/login_system/login_screen.dart';
import 'package:pgt_app/widget/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? user_id;
  List userList = [];

  Future get_user() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
    });
    print(user_id);
    final response = await http
        .get(Uri.parse("$ipcon/api/user/user?userID=${user_id}&status=id"));
    var data = json.decode(response.body);

    setState(() {
      userList = data;
    });
    print(userList);
  }

  @override
  void initState() {
    get_user();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      child: userList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: width,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/bg_profile.jpg",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -height * 0.07,
                      left: width * 0.02,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                        backgroundColor: Colors.grey,
                        radius: width * 0.15,
                      ),
                    )
                  ],
                ),
                Container(
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.08),
                        buildBox("ชื่อ",
                            '${userList[0]['user_fname']} ${userList[0]['user_lname']}'),
                        buildBox("เบอร์โทรศัพท์", '${userList[0]['user_tel']}'),
                        buildBox("อีเมล", '${userList[0]['email']}'),
                        buildLogout()
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget buildBox(String? text1, String? text2) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.015),
        Custom_text(
          color: Colors.black,
          fontSize: 20,
          fontWeight: null,
          text: '$text1',
        ),
        Container(
          width: width,
          height: height * 0.05,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 2,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Custom_text(
                color: Colors.black,
                fontSize: 22,
                fontWeight: null,
                text: '$text2',
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildLogout() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * 0.5,
          height: height * 0.05,
          margin: EdgeInsets.symmetric(vertical: height * 0.04),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: Color(0xffFFF4F4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return LoginScreen();
              }), (route) => false);
            },
            child: Center(
              child: Custom_text(
                color: Colors.black,
                fontSize: 17,
                fontWeight: null,
                text: 'ออกจากระบบ',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
