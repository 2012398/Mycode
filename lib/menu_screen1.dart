import 'package:flutter/material.dart';
import 'package:fyp/data.dart';
import 'package:fyp/main_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen1 extends StatefulWidget {
  MenuScreen1({super.key});

  @override
  State<MenuScreen1> createState() => _MenuScreen1State();
}

class _MenuScreen1State extends State<MenuScreen1> {
  final List _photos = [
    Data(image: "images/Nutrition.jpg", text: "Nutritions\n & Supplements"),
    Data(image: "images/Medicine.png", text: "Medicine"),
    Data(image: "images/Skincare.jpg", text: "Skin care"),
    Data(image: "images/Wipes.jpg", text: "Wet wipes"),
    Data(image: "images/Toys.jpg", text: "Toys"),
    Data(image: "images/Feeders.jpg", text: "Feeding bottles"),
    Data(image: "images/Bath.jpg", text: "Bath accessories"),
    Data(image: "images/Nipples.jpg", text: "Nipple\n & Pacifiers")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.shopping_cart_checkout_rounded,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Categories",
              style:
                  GoogleFonts.rubik(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _photos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 17),
                                    blurRadius: 17,
                                    spreadRadius: -25)
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,
                              image: DecorationImage(
                                  image: AssetImage(_photos[index].image),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        _photos[index].text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.30,
                            fontSize: 14),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
