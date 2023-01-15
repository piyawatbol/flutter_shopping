import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pgt_app/ipcon.dart';
import 'package:pgt_app/screen/detail_product_scree.dart';
import 'package:pgt_app/widget/custom_text.dart';

class SeeMoreScreen extends StatefulWidget {
  SeeMoreScreen({Key? key}) : super(key: key);
  @override
  State<SeeMoreScreen> createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  List productList = [];
  get_product() async {
    final response = await http.get(Uri.parse("$ipcon/api/product/product"));
    var data = json.decode(response.body);

    setState(() {
      productList = data;
    });
  }

  void initState() {
    get_product();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.pink.shade200,
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          width: width,
          height: height * 0.047,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Color(0xffdedede).withOpacity(0.9),
                spreadRadius: 0.8,
                blurRadius: 0.1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                color: Colors.pink.shade200,
              ),
              SizedBox(width: width * 0.02),
              Custom_text(
                text: "Search",
                fontSize: 16,
                color: Colors.pink.shade200,
                fontWeight: null,
              ),
            ],
          ),
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.pink.shade200,
            ),
          )
        ],
      ),
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [buildSeemore()],
        ),
      ),
    );
  }

  Widget buildSeemore() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: ListView.builder(
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
              margin: EdgeInsets.symmetric(
                  vertical: height * 0.003, horizontal: width * 0.01),
              width: double.infinity,
              height: height * 0.14,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffdedede).withOpacity(0.9),
                    spreadRadius: 0.8,
                    blurRadius: 0.1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: width * 0.32,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '$ipcon/p_img/${productList[index]['p_img']}'))),
                  ),
                  Container(
                    width: width * 0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.01,
                              horizontal: width * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Custom_text(
                                text: "${productList[index]['p_name']}",
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: null,
                              ),
                              Custom_text(
                                text: "${productList[index]['p_detail']}",
                                fontSize: 14,
                                color: Colors.grey.shade500,
                                fontWeight: null,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Custom_text(
                              text: "${productList[index]['p_price']} ฿",
                              fontSize: 18,
                              color: Colors.pink.shade200,
                              fontWeight: null,
                            ),
                            SizedBox(width: width * 0.03),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: height * 0.005),
                              width: width * 0.17,
                              height: height * 0.04,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.pink.shade200,
                                  shape: const RoundedRectangleBorder(),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return DetailProductScreen(
                                          product_id:
                                              '${productList[index]['p_id']}',
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Custom_text(
                                    text: "ซื้อเลย",
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: null),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
