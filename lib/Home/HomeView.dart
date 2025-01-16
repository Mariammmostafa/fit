import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Home/top_sports_details.dart';
import 'package:untitled/Home/trainers_detail.dart';
import 'package:untitled/Login_screen.dart';
import 'package:untitled/models/get_sports_request.dart';
import 'package:untitled/models/sliders_model.dart';
import 'package:untitled/settingsView/settings_view.dart';

import '../models/trainers_model.dart';
import '../network_layer/api_manager.dart';

class Trainers {
  final String name;
  final String sports;
  final String urlAvatar;

  Trainers({
    required this.name,
    required this.sports,
    required this.urlAvatar,
  });
}

List<CardItem> items = [
  CardItem(urlImage: 'assets/image/cardio.jpg', title: 'Cardio'),
  CardItem(urlImage: 'assets/image/cr.jpg', title: 'CrossFit'),
  CardItem(urlImage: 'assets/image/fitness.jpg', title: 'Fitness'),
  CardItem(urlImage: 'assets/image/packages.jpg', title: 'Packages'),
  CardItem(urlImage: 'assets/image/image5.jpg', title: 'Online Coach'),
  CardItem(urlImage: 'assets/image/private.jpg', title: 'Private Classes'),
];

class HomeView extends StatefulWidget {
  static const String routeName = "HomeView";

  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<ToolData>> _sliderImagesFuture;
  late Future<List<InstructorData>> _teamImageFuture;
  late Future<List<InstructorData>> trainers;
  late Future<List<InstructorData>> _trainersFuture;

  @override
  void initState() {
    super.initState();
    _sliderImagesFuture = ApiManager.fetchSource('carousel-url');
    _trainersFuture = ApiManager.fetchTeam('card-url');
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
            ),
            onPressed: () {
            },
          ),
        ],
        backgroundColor: const Color(0xFF39A552),
        title: const Text(
          "FitLyft",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? " "),
              accountEmail: Text(user?.email ?? "No Email"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  user?.photoURL ??
                      "https://www.example.com/default-avatar.png",
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Sign Out"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed(
                    LoginScreen.routeName); // Navigate to login screen
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                      color: Colors.grey,
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              const Text(
                "Popular Classes",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins-Medium",
                ),
              ),
              const SizedBox(height: 16),

              // Slider - Fetch images dynamically from API
              FutureBuilder<List<ToolData>>(
                future: _sliderImagesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    var imageUrls = snapshot.data!;
                    print("Fetched images: $imageUrls");
                    if (imageUrls.isEmpty) {
                      return const Text("No images available");
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          enlargeFactor: 1.1,
                        ),
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index, realIndex) {
                          return buildPopularImage(imageUrls[index], index);
                        },
                      ),
                    );
                  }
                  return const Center(child: Text('No images available.'));
                },
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                "Top Sports",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins-Medium",
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: ApiManager.getSports(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    var data = snapshot.data as GetSportsRequest;
                    return SizedBox(
                      height: 200,
                      child: ListView.separated(
                        itemCount: data.toolData.length,
                        separatorBuilder: (context, _) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) =>
                            buildSportsCard(data.toolData[index], context),
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                "Top Trainers",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins-Medium",
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<InstructorData>>(
                future: _trainersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    var trainers = snapshot.data!;
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: trainers.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final trainer = trainers[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrainerFinalDetails(
                                  trainer: trainer,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 8,
                              ),
                              // child: Row(
                              //   children: [
                              //     CircleAvatar(
                              //       radius: 40,
                              //       backgroundImage:
                              //           NetworkImage(trainer.img ?? ''),
                              //     ),
                              //     Text(trainer.fullName ?? 'Unknown'),
                              //     Text(trainer.position ?? 'No Position'),
                              //   ],
                              // ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      trainer.img ?? '',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return const Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(trainer.fullName ?? 'Unknown'),
                                      const SizedBox(height: 8),
                                      Text(trainer.position ?? 'No Position'),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 8);
                      },
                    );
                  }
                  return const Center(child: Text('No trainers available.'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Image for the Slider

  Widget buildPopularImage(ToolData tool, int index) {
    return CachedNetworkImage(
      imageUrl: tool.img!,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child:
            Text('No image found', style: TextStyle(color: Colors.red)),
      ),
    );
  }

  Widget buildSportsCard(SportModel item, BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopSportsDetails(
                item: item,
              ),
            ),
          );
        },
        child: Image.network(
          item.img ?? "",
          fit: BoxFit.cover,
          width: size.width / 2,
        ),
      ),
    );
  }

  Widget buildTrainerCard(InstructorData trainer, BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(trainer.img ?? ''),
        ),
        title: Text(
          trainer.fullName?.isNotEmpty == true ? trainer.fullName! : "Unknown",
        ),
        subtitle: Text(
          trainer.position?.isNotEmpty == true
              ? trainer.position!
              : "Position not available",
        ),
      ),
    );
  }
}

class CardItem {
  final String urlImage;
  final String title;

  CardItem({
    required this.urlImage,
    required this.title,
  });
}
