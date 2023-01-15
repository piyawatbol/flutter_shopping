// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pgt_app/ipcon.dart';
import 'package:pgt_app/widget/custom_text.dart';

class DetailProductScreen extends StatefulWidget {
  String? product_id;
  DetailProductScreen({required this.product_id});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  List productList = [];
  bool heart = false;

  get_product_one() async {
    final response = await http
        .get(Uri.parse("$ipcon/api/product/product?p_id=${widget.product_id}"));
    var data = json.decode(response.body);

    setState(() {
      productList = data;
    });
  }

  add_basket() async {
    var url = Uri.parse('$ipcon/api/basket/basket');
    var response = await http.post(url, body: {
      "userID": "1",
      "p_id": widget.product_id.toString(),
      "basket_qty": "1"
    });
    var data = json.decode(response.body);
    print(data);
  }

  @override
  void initState() {
    get_product_one();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: productList.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.pink.shade200,
              ),
            )
          : Container(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      buildImg(),
                      buildInfo(),
                    ],
                  ),
                  buildBottom()
                ],
              ),
            ),
    );
  }

  Widget buildImg() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: width,
          height: height * 0.37,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("$ipcon/p_img/${productList[0]['p_img']}"),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.01),
            child: CircleAvatar(
              backgroundColor: Colors.black26,
              radius: width * 0.06,
              child: Center(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: width * 0.06,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildInfo() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      width: width,
      height: height * 0.21,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xffdedede).withOpacity(0.4),
            spreadRadius: 0.8,
            blurRadius: 0.1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Custom_text(
            text: "${productList[0]['p_name']}",
            fontSize: 20,
            color: Colors.black,
            fontWeight: null,
          ),
          Custom_text(
            text: "${productList[0]['p_detail']}",
            fontSize: 18,
            color: Colors.grey,
            fontWeight: null,
          ),
          Custom_text(
            text: "${productList[0]['p_price']} ฿",
            fontSize: 18,
            color: Colors.pink.shade200,
            fontWeight: null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: width * 0.35,
                    height: height * 0.03,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Icon(
                          Icons.star,
                          color: Colors.yellow.shade700,
                        );
                      },
                    ),
                  ),
                  Custom_text(
                    text: "5.0",
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: null,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                    height: height * 0.03,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Custom_text(
                    text: "ขายได้ 10 ชิ้น",
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: null,
                  ),
                ],
              ),
              Row(
                children: [
                  heart == false
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              heart = !heart;
                            });
                          },
                          child: Image.asset(
                            "assets/images/heart.png",
                            width: width * 0.05,
                            height: height * 0.03,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              heart = !heart;
                            });
                          },
                          child: Image.asset(
                            "assets/images/heart_full.png",
                            width: width * 0.05,
                            height: height * 0.03,
                          ),
                        ),
                  SizedBox(width: width * 0.02),
                  Icon(Icons.share)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildBottom() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        add_basket();
      },
      child: Container(
        width: width,
        height: height * 0.07,
        color: Colors.pink.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width * 0.6,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    Custom_text(
                      text: "เพิ่มไปยังรถเข็น",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: null,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.red,
              width: width * 0.38,
              child: Center(
                child: Custom_text(
                  text: "ซื้อสินค้า",
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
