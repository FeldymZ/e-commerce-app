import 'dart:async';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:e_commerce/screens/all_product.dart';
import 'package:e_commerce/screens/one_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HommePage extends StatefulWidget {
  const HommePage({super.key});

  @override
  State<HommePage> createState() => _HommePageState();
}

class _HommePageState extends State<HommePage> {
  final PageController _pageController = PageController();
  PageController pageController = PageController();

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.chair, "label": "Sofa"},
    {"icon": Icons.event_seat, "label": "Chair"},
    {"icon": Icons.lightbulb, "label": "Lamp"},
    {"icon": Icons.kitchen, "label": "Cupboard"},
  ];

  int hours = 2;
  int minutes = 12;
  int seconds = 56;
  String selectedCategory = "Newest";

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        if (minutes > 0) {
          setState(() {
            minutes--;
            seconds = 59;
          });
        } else if (hours > 0) {
          setState(() {
            hours--;
            minutes = 59;
            seconds = 59;
          });
        } else {
          timer.cancel();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 5,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location'),
                        Row(
                          children: [
                            Icon(IconsaxPlusBold.location),
                            Text('New York, USA')
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black26,
                      child: Icon(IconsaxPlusBold.notification_1,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    SizedBox(
                        height: 50.h,
                        width: 285.w,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(IconsaxPlusLinear.search_normal_1),
                            hintText: "Search Workout, Trainer",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[150], // Arrière-plan
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide
                                  .none, // Supprime la bordure de base
                            ),
                          ),
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.black),
                          cursorColor: Color(0xff3c5a5d),
                        )),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OneProduct(categoryName: "Sofa")),
                        );
                      },
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            color: Color(0xff3c5a5d),
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          IconsaxPlusLinear.setting_4,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 160, // Hauteur de la bannière
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildPromoCard(
                      title: "New Collection",
                      subtitle: "Discount 50% for\nthe first transaction",
                      buttonText: "Shop Now",
                      imageUrl:
                          "assets/img/pngegg (10).png", // Remplace par ton image
                    ),
                    _buildPromoCard(
                      title: "Winter Sale",
                      subtitle: "Up to 70% off\non selected items",
                      buttonText: "Explore",
                      imageUrl: "assets/img/pngegg (10).png",
                    ),
                    _buildPromoCard(
                      title: "Winter Sale",
                      subtitle: "Up to 70% off\non selected items",
                      buttonText: "Explore",
                      imageUrl: "assets/img/pngegg (10).png",
                    ),
                    _buildPromoCard(
                      title: "Winter Sale",
                      subtitle: "Up to 70% off\non selected items",
                      buttonText: "Explore",
                      imageUrl: "assets/img/pngegg (10).png",
                    ),
                    _buildPromoCard(
                      title: "Winter Sale",
                      subtitle: "Up to 70% off\non selected items",
                      buttonText: "Explore",
                      imageUrl: "assets/img/pngegg (10).png",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 5,
                    effect: const ScrollingDotsEffect(
                      spacing: 10.5,
                      activeDotColor: Color(0xff3c5a5d),
                      dotColor: Color.fromARGB(255, 179, 179, 179),
                      dotWidth: 7.0,
                      dotHeight: 7.0,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                          letterSpacing: -0.5,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(color: Color(0xff3c5a5d)),
                        ))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categories.map((category) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: Icon(
                            category["icon"],
                            size: 30,
                            color: Color(0xff3c5a5d),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          category["label"],
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre & Countdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Flash Sale",
                          style: TextStyle(
                              letterSpacing: -0.5,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "Closing in : ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Text(
                              "${hours.toString().padLeft(2, '0')} : "
                              "${minutes.toString().padLeft(2, '0')} : "
                              "${seconds.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Boutons de Catégories
                  ],
                ),
              ),
              SizedBox(
                height: 35,
                child: ButtonsTabBar(
                  decoration: BoxDecoration(
                    color: const Color(0xff3c5a5d),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: const Color(0xFF422f96),
                      width: 1,
                    ),
                  ),
                  unselectedDecoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xFF1c1d21),
                  ),
                  buttonMargin: const EdgeInsets.symmetric(horizontal: 10),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 17),
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Newest'),
                    Tab(text: 'Popular'),
                    Tab(text: 'Bedromo'),
                    Tab(text: 'Bedromo'),
                  ],
                ),
              ),
              const SizedBox(
                height: 300, // Ajuste cette hauteur selon ton besoin
                child: TabBarView(
                  children: [
                    AllProduct(),
                    Center(child: Text('data')),
                    Center(child: Text('data')),
                    Center(child: Text('data')),
                    Center(child: Text('data')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//Stylisation de la PageView
  Widget _buildPromoCard({
    required String title,
    required String subtitle,
    required String buttonText,
    required String imageUrl,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffe7e7e7),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Texte
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    letterSpacing: -0.5,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    letterSpacing: -0.5,
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF064635),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),

            // Image du produit
            Image.asset(
              imageUrl,
              height: 100,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
