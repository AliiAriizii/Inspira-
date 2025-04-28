import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _selectedIndex;
  bool _showDescription = false; // متغیر برای کنترل نمایش توضیحات
  bool _bestDesignSelected = false; // برای انتخاب بهترین طراحی

  final List<Map<String, String>> cardData = [
    {
      'image': 'assets/images/moon.jpg',
      'text': 'First Inspiration',
      'description': 'This is a detailed description of the first image.',
    },
    {
      'image': 'assets/images/moon3.jpg',
      'text': 'Second Vision',
      'description': 'This is a detailed description of the second image.',
    },
    {
      'image': 'assets/images/moon1.jpg',
      'text': 'Third Dream',
      'description': 'This is a detailed description of the third image.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 183, 183, 184),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          child: AppBar(
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            elevation: 4.0,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: Colors.black87),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 10,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Find Your",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "Inspiration",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'RobotoCondensed',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(244, 243, 243, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.black87),
                        hintText: "Search What you're looking for",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'promo Today',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cardData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = (_selectedIndex == index) ? null : index;
                                _showDescription = (_selectedIndex == index); // تنظیم نمایش توضیحات
                              });
                            },
                            child: _buildCard(index),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // The Best Design Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _bestDesignSelected = !_bestDesignSelected; // تغییر وضعیت انتخاب بهترین طراحی
                  });
                },
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 29, 29, 29),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/moon2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 125,
                        right: 110,
                        child: Text(
                          'The Best Design',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // if (_bestDesignSelected)
                      //   Positioned(
                      //     bottom: 1,
                      //     left: 17,
                      //     right: 20,
                      //     child: AnimatedOpacity(
                      //       opacity: 1.0,
                      //       duration: const Duration(milliseconds: 600),
                      //       child: Text(
                      //         'This is the best design section where we showcase the most beautiful design.',
                      //         style: const TextStyle(
                      //           fontSize: 13,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    final card = cardData[index];
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: Container(
        key: ValueKey<int>(index),
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(card['image']!),
            fit: BoxFit.cover,
          ),
        ),
        child: _selectedIndex == index
            ? _buildBlurredCard(card['text']!, card['description']!)
            : _buildNormalCard(card['text']!),
      ),
    );
  }

  Widget _buildNormalCard(String text) {
    return Stack(
      children: [
        Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBlurredCard(String text, String description) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                top: _selectedIndex == null ? 20 : 10,
                left: 20,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (_showDescription && _selectedIndex != null)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
