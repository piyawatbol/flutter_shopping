// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pgt_app/ipcon.dart';
import 'package:pgt_app/screen/detail_product_scree.dart';
import 'package:pgt_app/widget/custom_text.dart';

class TypeScreen extends StatefulWidget {
  String? type;
  TypeScreen({required this.type});

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  List productList = [];
  get_type() async {
    final response = await http
        .get(Uri.parse("$ipcon/api/product/producttype?p_type=${widget.type}"));
    var data = json.decode(response.body);

    setState(() {
      productList = data;
    });
    print(productList[0]);
  }

  @override
  void initState() {
    get_type();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.pink.shade200,
        ),
      ),
      body: productList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: [buildMenu()],
                ),
              ),
            ),
    );
  }

  Widget buildMenu() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return productList[0] == "not type"
        ? Container()
        : Container(
            child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 5),
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return DetailProductScreen(
                              product_id: '${productList[index]['p_id']}',
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.2,
                            blurRadius: 0.5,
                            offset: Offset(3, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width,
                                padding: EdgeInsets.all(1),
                                height: height * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0.1,
                                      blurRadius: 0.2,
                                      offset: Offset(2, 3),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  '$ipcon/p_img/${productList[index]['p_img']}',
                                  width: width * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.015,
                                    horizontal: width * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Custom_text(
                                      text: "${productList[index]['p_name']}",
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: null,
                                    ),
                                    Custom_text(
                                      text: "${productList[index]['p_detail']}",
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontWeight: null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.01,
                                vertical: height * 0.001),
                            child: Custom_text(
                              text: "฿${productList[index]['p_price']}",
                              fontSize: 18,
                              color: Colors.pink.shade200,
                              fontWeight: null,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
