// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardCarousel extends StatefulWidget {
  const DashboardCarousel({super.key});

  @override
  State<DashboardCarousel> createState() => _DashboardCarouselState();
}

class _DashboardCarouselState extends State<DashboardCarousel> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int currentIndex = 0;

  final List<Map<String, String>> carouselData = [
    {
      'title': 'TOTAL PROJECTS',
      'value': '8',
      'subtitle': '',
    },
    {
      'title': 'COMPLETED PROJECTS',
      'value': '0',
      'subtitle': '',
    },
    {
      'title': 'MOST BUGS',
      'value': 'sTSI',
      'subtitle': '8',
    },
    {
      'title': 'UPCOMING RELEASE',
      'value': 'NMS Care',
      'subtitle': '24 Days',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: carouselData.length,
            itemBuilder: (context, index, realIndex) {
              final cardData = carouselData[index];

              return Container(
                width: screenWidth * 0.4,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xff282828),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 0.5,
                      blurRadius: 10,
                      offset: Offset(3, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cardData['title']!,
                      style: GoogleFonts.lato(
                        color: Color(0xffDFECFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      cardData['value']!,
                      style: GoogleFonts.lato(
                        color: Color(0xffDFECFF),
                        fontWeight: FontWeight.w900,
                        fontSize: 45,
                      ),
                    ),
                    if (cardData['subtitle']!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          '（${cardData['subtitle']!}）',
                          style: GoogleFonts.lato(
                            color: Color(0xffDFECFF),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              height: screenHeight * 0.3,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.9,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),

          // Dots below the carousel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              carouselData.length,
                  (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 7,
                width: currentIndex == index ? 20 : 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.blue
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
