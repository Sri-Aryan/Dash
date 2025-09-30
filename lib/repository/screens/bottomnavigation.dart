import 'package:dash/repository/screens/cart.dart';
import 'package:dash/repository/screens/category.dart';
import 'package:dash/repository/screens/home.dart';
import 'package:dash/repository/screens/print.dart';
import 'package:dash/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/cart_bloc.dart';
import 'orderscreen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    CategoryScreen(),
    PrintScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      // Always show navigation bar with cart bar above when needed
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cart bar (show above navigation when items are present)
              if (state.totalCost > 0) _buildCartBar(context, state, theme),

              // Navigation bar (always visible)
              _buildBottomNavigation(context, theme),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartBar(BuildContext context, CartState state, ThemeData theme) {
    final totalItems = state.cart.values.fold<int>(
      0,
          (sum, item) => sum + (item['quantity'] as int),
    );

    final totalCost = state.cart.values.fold<int>(
      0,
          (sum, item) => sum + ((item['quantity'] as int) * (item['price'] as int)),
    );

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Material(
        color: Colors.deepOrange,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderDetailsScreen(cart: state.cart),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cart summary
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "$totalItems items",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "₹$totalCost",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // View order button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View Order",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: theme.colorScheme.surface,
        selectedItemColor: Colors.deepOrange, // Changed to match your theme
        unselectedItemColor: theme.colorScheme.onSurfaceVariant,
        selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavIcon("home.png", 0),
            activeIcon: _buildNavIcon("home.png", 0, isActive: true),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon("shopping.png", 1),
            activeIcon: _buildNavIcon("shopping.png", 1, isActive: true),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon("category.png", 2),
            activeIcon: _buildNavIcon("category.png", 2, isActive: true),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon("printer.png", 3),
            activeIcon: _buildNavIcon("printer.png", 3, isActive: true),
            label: "Print",
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(String imagePath, int index, {bool isActive = false}) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: isActive
          ? BoxDecoration(
        color: Colors.deepOrange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      )
          : null,
      child: UiHelper.CustomImage(img: imagePath),
    );
  }
}
