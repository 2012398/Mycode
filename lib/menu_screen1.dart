import 'package:flutter/material.dart';
import 'package:fyp/data.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen1 extends StatelessWidget {
  final List _photos = [
    Data(
        image: "images/Nutrition.jpg",
        text: "Nutritions &           Supplements"),
    Data(image: "images/Medicine.png", text: "Medicine"),
    Data(image: "images/Skincare.jpg", text: "Skin care"),
    Data(image: "images/Wipes.jpg", text: "Wet wipes"),
    Data(image: "images/Toys.jpg", text: "Toys"),
    Data(image: "images/Feeders.jpg", text: "Feeding bottles"),
    Data(image: "images/Bath.jpg", text: "Bath accessories"),
    Data(image: "images/Nipples.jpg", text: "Nipple & Pacifiers")
  ];
  MenuScreen1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xff374366),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.shopping_cart_checkout_rounded),
            ),
          ],
        ),
        drawer: Drawer(),
        body: GridView.builder(
          itemCount: _photos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.greenAccent,
                        image: DecorationImage(
                            image: AssetImage(_photos[index].image),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  _photos[index].text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.30,
                    fontSize: 14,
                  ),
                )
              ],
            );
          },
        ));
  }
}
