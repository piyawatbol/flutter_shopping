import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pgt_app/ipcon.dart';
import 'package:pgt_app/screen/detail_product_scree.dart';
import 'package:pgt_app/widget/custom_text.dart';

class BasketScreen extends StatefulWidget {
  BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List productList = [];
  get_basket() async {
    final response =
        await http.get(Uri.parse("$ipcon/api/basket/basketuser?userID=1"));
    var data = json.decode(response.body);

    setState(() {
      productList = data;
    });
    print(productList);
  }

  @override
  void initState() {
    get_basket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Custom_text(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'รถเข็น',
        ),
        backgroundColor: Colors.pink.shade200,
      ),
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [buildBasket()],
        ),
      ),
    );
  }

  Widget buildBasket() {
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
                            '$ipcon/p_img/${productList[index]['p_img']}'),
                      ),
                    ),
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
                              Custom_text(
                                text: "${productList[index]['p_qty']} ชิ้น",
                                fontSize: 16,
                                color: Colors.pink.shade200,
                                fontWeight: null,
                              ),
                              Custom_text(
                                text: "${productList[index]['p_price']} ฿",
                                fontSize: 18,
                                color: Colors.pink.shade200,
                                fontWeight: null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.03),
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
