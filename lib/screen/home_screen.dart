import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pgt_app/screen/basket_screen.dart';
import 'package:pgt_app/screen/detail_product_scree.dart';
import 'package:pgt_app/screen/seemore_screen.dart';
import 'package:pgt_app/ipcon.dart';
import 'package:pgt_app/screen/type_screen.dart';
import 'package:pgt_app/widget/custom_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  List productList = [];
  List image_slide = ["img.jpg", "img1.jpg", "img2.jpg"];
  List text_group = [
    "เสื้อผ้า",
    "ชุดเดรส",
    "ยีนส์",
    "บอดี้สูท",
    "รองเท้า",
    "กระเป๋า",
    "กระโปรง",
    "กางเกง",
    "ชุดบิกินี",
    "เครื่องประดับ"
  ];
  List img_group = [
    "group1.png",
    "group2.png",
    "group3.png",
    "group4.png",
    "group5.png",
    "group6.png",
    "group7.png",
    "group8.png",
    "group9.png",
    "group10.png"
  ];
  get_product() async {
    final response = await http.get(Uri.parse("$ipcon/api/product/product"));
    var data = json.decode(response.body);

    setState(() {
      productList = data;
    });
  }

  @override
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return BasketScreen();
                }));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.pink.shade200,
              ))
        ],
      ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/b.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCarousel(),
              buildgrop(),
              buildRecommend(),
              buildMenu()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCarousel() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          width: width,
          height: height * 0.26,
          child: CarouselSlider.builder(
            itemCount: image_slide.length,
            itemBuilder: ((context, index, realIndex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                width: width,
                height: height * 0.5,
                child: Image.asset(
                  'assets/images/${image_slide[index]}',
                  fit: BoxFit.cover,
                ),
              );
            }),
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _index = index;
                });
              },
              enlargeCenterPage: true,
              height: height * 0.5,
              autoPlay: true,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: AnimatedSmoothIndicator(
            activeIndex: _index,
            count: image_slide.length,
            effect: WormEffect(
              activeDotColor: Colors.pink.shade200,
              dotHeight: 10,
              dotWidth: 15,
            ),
          ),
        )
      ],
    );
  }

  Widget buildgrop() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.02),
      width: width,
      height: height * 0.23,
      child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return TypeScreen(
                    type: '${text_group[index]}',
                  );
                }));
              },
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.14,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0.2,
                          blurRadius: 0.5,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/${img_group[index]}',
                      width: width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Custom_text(
                    text: "${text_group[index]}",
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: null,
                  )
                ],
              )),
            );
          }),
    );
  }

  Widget buildRecommend() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return productList.isEmpty
        ? Center(
            child: CircularProgressIndicator(color: Colors.pink.shade200),
          )
        : Container(
            height: height * 0.25,
            color: Colors.white38,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.012),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Custom_text(
                          text: "รายการแนะนำ",
                          fontSize: 16,
                          color: Colors.pink.shade200,
                          fontWeight: null),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SeeMoreScreen();
                          }));
                        },
                        child: Row(
                          children: [
                            Custom_text(
                                text: "ดูทั้งหมด",
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: null),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.18,
                  // color: Colors.red,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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
                              vertical: height * 0.01,
                              horizontal: width * 0.01),
                          width: width * 0.34,
                          height: height * 0.18,
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
                              children: [
                                productList.isEmpty
                                    ? Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.pink.shade200),
                                      )
                                    : Container(
                                        height: height * 0.11,
                                        width: double.infinity,
                                        child: Image.network(
                                          '$ipcon/p_img/${productList[index]['p_img']}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Custom_text(
                                      text:
                                          "${productList[index]['p_price']} ฿",
                                      fontSize: 14,
                                      color: Colors.pink.shade200,
                                      fontWeight: null),
                                ),
                              ]),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }

  Widget buildMenu() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return productList.isEmpty
        ? Center(
            child: CircularProgressIndicator(color: Colors.pink.shade200),
          )
        : Container(
            child: GridView.builder(
                shrinkWrap: true,
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
