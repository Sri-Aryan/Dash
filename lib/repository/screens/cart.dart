import 'package:dash/domain/constants/appcolors.dart';
import 'package:dash/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CartScreen> {
  TextEditingController searchController = TextEditingController();

  Widget buildProductCard({
    required String image,
    required String name,
    required String timerText,
    required String price,
    required VoidCallback onAdd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            UiHelper.CustomImage(img: image),
            Positioned(
              bottom: 5,
              right: 5,
              child: UiHelper.CustomButton(onAdd),
            ),
          ],
        ),
        SizedBox(height: 5),
        UiHelper.CustomText(
          text: name,
          color: Colors.black,
          fontweight: FontWeight.bold,
          fontsize: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomImage(img: "timer.png"),
            SizedBox(width: 3),
            UiHelper.CustomText(
              text: timerText,
              color: Colors.black,
              fontweight: FontWeight.normal,
              fontsize: 7,
            ),
          ],
        ),
        UiHelper.CustomText(
          text: price,
          color: Colors.black,
          fontweight: FontWeight.bold,
          fontsize: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: AppColors.scaffoldbackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: UiHelper.CustomText(
                        text: "Dash",
                        color: Color(0X0ff00000),
                        fontweight: FontWeight.bold,
                        fontsize: 14,
                        fontfamily: "bold",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: UiHelper.CustomText(
                        text: "15 minutes",
                        color: Color(0XFF000000),
                        fontweight: FontWeight.bold,
                        fontsize: 22,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          UiHelper.CustomText(
                            text: "Home - ",
                            color: Color(0XFF000000),
                            fontweight: FontWeight.bold,
                            fontsize: 14,
                          ),
                          UiHelper.CustomText(
                            text: "Uttar Pradesh, India",
                            color: Color(0XFF000000),
                            fontweight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                bottom: 60,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black, size: 15),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 30,
                child: UiHelper.CustomTextField(controller: searchController),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(child: UiHelper.CustomImage(img: "cart_1.png")),
          SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                UiHelper.CustomText(
                  text: "Reordering will be easy",
                  color: Colors.black,
                  fontweight: FontWeight.bold,
                  fontsize: 15,
                ),
                UiHelper.CustomText(
                  text: "Items you order will show up here",
                  color: Colors.black,
                  fontweight: FontWeight.bold,
                  fontsize: 15,
                ),
                UiHelper.CustomText(
                  text: "Buy them easily.",
                  color: Colors.black,
                  fontweight: FontWeight.bold,
                  fontsize: 15,
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: UiHelper.CustomText(
              text: "Best Seller",
              color: Colors.black,
              fontweight: FontWeight.bold,
              fontsize: 15,
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                buildProductCard(
                  image: "image 44.png",
                  name: "Potato",
                  timerText: "16 mins",
                  price: "Rs.27",
                  onAdd: () {},
                ),
                SizedBox(width: 15),
                buildProductCard(
                  image: "image 45.png",
                  name: "Milk",
                  timerText: "16 mins",
                  price: "Rs.35",
                  onAdd: () {},
                ),
                SizedBox(width: 15),
                buildProductCard(
                  image: "image 46.png",
                  name: "Tomato",
                  timerText: "16 mins",
                  price: "Rs.47",
                  onAdd: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
