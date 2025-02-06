import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api/models/getQuickInsights.dart';
import '../fontStyle.dart';

class DashboardCarousel extends StatefulWidget {
  @override
  State<DashboardCarousel> createState() => _DashboardCarouselState();
}

class _DashboardCarouselState extends State<DashboardCarousel> {
  int currentIndex = 0;
  bool isLoading = true;
  List<Map<String, String>> carouselData = [];
  final String apiBaseURL = 'http://10.131.213.166:8080/';

  Future<getQuickInsights> fetchQuickInsights() async {
    final response = await http.get(Uri.parse(apiBaseURL + 'quick-insights/'));

    if (response.statusCode == 200) {
      // Parse the JSON as a single object
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return getQuickInsights.fromJson(jsonData);
    } else {
      throw Exception('Failed to load quick insights');
    }
  }

  void loadCarouselData() async {
    try {
      getQuickInsights insights = await fetchQuickInsights();

      setState(() {
        carouselData = [
          {
            'title': 'TOTAL PROJECTS',
            'value': (insights.totalProjects ?? 0).toString(),
            'subtitle': '',
          },
          {
            'title': 'COMPLETED PROJECTS',
            'value': (insights.completedProjects ?? 0).toString(),
            'subtitle': '',
          },
          {
            'title': 'MOST OPEN FEEDBACKS',
            'value': insights.mostOpenFeedbacks?.name ?? 'N/A',
            'subtitle': '${insights.mostOpenFeedbacks?.openFeedbacks?? 0}',
          },
          {
            'title': 'UPCOMING RELEASE',
            'value': insights.upcomingRelease?.name ?? 'N/A',
            'subtitle': '${insights.upcomingRelease?.daysLeft ?? 0} Days',
          },
        ];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadCarouselData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return isLoading
        ? const Center(
            child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text('Loading...'),
          ))
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CarouselSlider.builder(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Title Text
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              cardData['title']!,
                              style: AppTextStyles.bold(fontSize: 25, color: Colors.white),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                cardData['value']!,
                                style: AppTextStyles.bold(fontSize: 30, color: Colors.white),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                            ),
                          ),

                          if (cardData['subtitle']!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text(
                                cardData['subtitle']!,
                                style: AppTextStyles.bold(fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                            ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    height: screenHeight * 0.4,
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
                        color: currentIndex == index ? Colors.blue : Colors.grey,
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
