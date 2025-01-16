import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Home/top_sports_details.dart';
import 'package:untitled/Home/trainers_detail.dart';
import 'package:untitled/Login_screen.dart';
import 'package:untitled/models/sliders_model.dart';

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

  HomeView({super.key});

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
    // Initialize the Future to fetch images from the API
    _sliderImagesFuture = ApiManager.fetchSource('carousel-url');
    _teamImageFuture = ApiManager.fetchTeam('card-url');
    trainers = ApiManager.fetchTeam('card-url');
    _trainersFuture = ApiManager.fetchTeam('card-url');
    // _trainersFuture = [];
    // ApiManager.fetchTeam('card-url'); // Fetch trainers from API
  }

  //List<Trainers> trainers = [
  // Trainers(
  //   name: "Hassan",
  // sports: "Sports supervisor",
  //  urlAvatar: 'assets/image/image.jpg'),
  //  Trainers(
  //   name: "Ali", sports: "Trainer", urlAvatar: 'assets/image/image.jpg'),
  //Trainers(
  //   name: "Sara",
  //  sports: "Yoga Instructor",
  //    urlAvatar: 'assets/image/image.jpg'),
  //];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        toolbarHeight: 40,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
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
                backgroundImage: NetworkImage(user?.photoURL ??
                    "https://www.example.com/default-avatar.png"),
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
                    if (imageUrls.isEmpty)
                      return const Text("No images available");
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: CarouselSlider.builder(
                        options: CarouselOptions(height: 200, autoPlay: true),
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index, realIndex) {
                          return buildImage(imageUrls[index], index);
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
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins-Medium",
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 200,
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 16),
                  itemBuilder: (context, index) =>
                      buildCard(items[index], context),
                  scrollDirection: Axis.horizontal,
                ),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                "Top Trainers",
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins-Medium",
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 170,
                child: FutureBuilder<List<InstructorData>>(
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
                        scrollDirection: Axis.horizontal,
                        itemCount: trainers.length,
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
                                padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          NetworkImage(trainer.img ?? ''),
                                    ),
                                    Text(trainer.fullName ?? 'Unknown'),
                                    Text(trainer.position ?? 'No Position'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 8);
                        },
                      );
                    }
                    return const Center(child: Text('No trainers available.'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Image for the Slider

  Widget buildImage(ToolData tool, int index) {
    return Container(
      width: 200,
      height: 300,
      color: Colors.grey,
      child: Stack(
        children: [
          CachedNetworkImage(
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
          ),
        ],
      ),
    );
  }

  // Build Card for Popular Classes
  Container buildCard(CardItem item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey,
          )),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopSportsDetails(items: item),
            ),
          );
        },
        child: Image.asset(
          item.urlImage,
          fit: BoxFit.cover,
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
          trainer.fullName?.isNotEmpty == true
              ? trainer.fullName!
              : "Unknown", // إذا كان الاسم فارغًا، عرض "Unknown"
        ),
        subtitle: Text(
          trainer.position?.isNotEmpty == true
              ? trainer.position!
              : "Position not available", // إذا كانت الوظيفة فارغة، عرض "Position not available"
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
