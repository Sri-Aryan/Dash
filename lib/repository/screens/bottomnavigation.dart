import 'package:dash/repository/screens/cart.dart';
import 'package:dash/repository/screens/category.dart';
import 'package:dash/repository/screens/home.dart';
import 'package:dash/repository/screens/print.dart';
import 'package:dash/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget{
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {

  int currentIndex = 0;
  List<Widget>page = [
    HomeScreen(),
    CartScreen(),
    CategoryScreen(),
    PrintScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: page,),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: UiHelper.CustomImage(img: "home.png"),label:"Home"),
        BottomNavigationBarItem(icon: UiHelper.CustomImage(img: "shopping.png"),label: "Cart"),
        BottomNavigationBarItem(icon: UiHelper.CustomImage(img: "category.png"),label: "Category"),
        BottomNavigationBarItem(icon: UiHelper.CustomImage(img: "printer.png"),label: "Print"),

      ],type: BottomNavigationBarType.fixed,currentIndex: currentIndex,onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      ),
    );
  }
}