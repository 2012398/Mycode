import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/Cart.dart';
import 'package:fyp/Screens/data.dart';
import 'package:fyp/Screens/login_screen.dart';
import 'package:fyp/Screens/main_drawer.dart';
import 'package:fyp/menu_screen_navigate/bath_accessories_screen.dart';
import 'package:fyp/menu_screen_navigate/feeding_bottles_screen.dart';
import 'package:fyp/menu_screen_navigate/medicine_screen.dart';
import 'package:fyp/menu_screen_navigate/nipple_pacifiers_screen.dart';
import 'package:fyp/menu_screen_navigate/nutri_and_supl_screen.dart';
import 'package:fyp/menu_screen_navigate/skin_care_screen.dart';
import 'package:fyp/menu_screen_navigate/toys_screen.dart';
import 'package:fyp/menu_screen_navigate/upload_products.dart';
import 'package:fyp/menu_screen_navigate/wet_wipes_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen1 extends StatefulWidget {
  const MenuScreen1({super.key});

  @override
  State<MenuScreen1> createState() => _MenuScreen1State();
}

class _MenuScreen1State extends State<MenuScreen1> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final List _photos = [
    Data(
        image: "assets/images/Nutrition.jpg",
        text: "Nutritions & \nSupplements"),
    Data(image: "assets/images/Medicine.png", text: "Medicine"),
    Data(image: "assets/images/Skincare.jpg", text: "Skin care"),
    Data(image: "assets/images/Wipes.jpg", text: "Wet wipes"),
    Data(image: "assets/images/Toys.jpg", text: "Toys"),
    Data(image: "assets/images/Feeders.jpg", text: "Feeding bottles"),
    Data(image: "assets/images/Bath.jpg", text: "Bath accessories"),
    Data(image: "assets/images/Nipples.jpg", text: "Nipple & Pacifiers"),
    Data(image: "assets/images/Nipples.jpg", text: "Upload Products")

  ];

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Nutri()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Medicine()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Skin_care()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Wet_wipes()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Toys()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Feeding_bottle()));
        break;
      case 6:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Bath_accesories()));
        break;
      case 7:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Nipple_Pacifier()));
        break;
      case 8:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Upload_product()));

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                _key.currentState!.openEndDrawer();
              },
              child: const Icon(
                Icons.shopping_cart_checkout_rounded,
              ),
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      endDrawer: SafeArea(child: Cart()),
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
                  return GestureDetector(
                    onTap: () {
                      navigateToPage(index);
                    },
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                          child: Container(
                            width: 110,
                            height: 110,
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
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              _photos[index].text,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.30,
                                  fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
