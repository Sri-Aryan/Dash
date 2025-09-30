import 'package:dash/repository/cart/cart_bloc.dart';
// import 'package:dash/repository/cart/cart_event.dart';
// import 'package:dash/repository/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/uihelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  var data = [
    {"img": "image 50.png", "text": "Lights, Diyas"},
    {"img": "image 51.png", "text": "Diwali"},
    {"img": "image 52.png", "text": "Appliances"},
    {"img": "image 53.png", "text": "Home"}
  ];

  var categroy = [
    {"img": "image 54.png", "text": "Golden Glass", "price": 79},
    {"img": "image 57.png", "text": "Royal Gulab Jamun", "price": 120},
    {"img": "image 63.png", "text": "Golden Glass", "price": 150},
    {"img": "image 32.png", "text": "Sweets", "price": 60},
  ];

  var grocerykitchen = [
    {"img": "image 41.png", "text": "Vegetables"},
    {"img": "image 42.png", "text": "Atta, Dal"},
    {"img": "image 43.png", "text": "Oil, Ghee"},
    {"img": "image 44 (1).png", "text": "Dairy, Bread "},
    {"img": "image 45 (1).png", "text": "Biscuits"}
  ];

  // Cart storage
  Map<String, Map<String, dynamic>> cart = {};

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      if (cart.containsKey(item['text'])) {
        cart[item['text']]!['quantity']++;
      } else {
        cart[item['text']] = {
          "name": item['text'],
          "price": item['price'],
          "quantity": 1,
        };
      }
    });
  }

  int get totalItems =>
      cart.values.fold(0, (sum, item) => sum + (item['quantity'] as int));
  int get totalCost => cart.values.fold(
      0,
          (sum, item) =>
      sum + ((item['quantity'] as int) * (item['price'] as int)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Stack(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                color: Colors.deepOrange,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        UiHelper.CustomText(
                            text: "Dash",
                            color: Color(0XFFFFFFFF),
                            fontweight: FontWeight.bold,
                            fontsize: 15,
                            fontfamily: "bold"),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        UiHelper.CustomText(
                            text: "15 minutes",
                            color: Color(0XFFFFFFFF),
                            fontweight: FontWeight.bold,
                            fontsize: 20,
                            fontfamily: "bold")
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        UiHelper.CustomText(
                            text: "HOME ",
                            color: Color(0XFFFFFFFF),
                            fontweight: FontWeight.bold,
                            fontsize: 14),
                        UiHelper.CustomText(
                            text: "- Uttar Pradesh, India",
                            color: Color(0XFFFFFFFF),
                            fontweight: FontWeight.bold,
                            fontsize: 14)
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                bottom: 100,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
              Positioned(
                  bottom: 30,
                  left: 20,
                  child: UiHelper.CustomTextField(controller: searchController))
            ],
          ),
          Container(height: 1, width: double.infinity, color: Colors.white),
          Container(
            height: 216,
            width: double.maxFinite,
            color: Colors.deepOrange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      UiHelper.CustomImage(img: "image 60.png"),
                      UiHelper.CustomImage(img: "image 55.png"),
                      UiHelper.CustomText(
                          text: "Diwali Sale",
                          color: Colors.white,
                          fontweight: FontWeight.bold,
                          fontsize: 20,
                          fontfamily: "bold"),
                      UiHelper.CustomImage(img: "image 55.png"),
                      UiHelper.CustomImage(img: "image 60.png"),
                    ]),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            height: 108,
                            width: 86,
                            decoration: BoxDecoration(
                                color: Color(0XFFEAD3D3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                UiHelper.CustomText(
                                    text: data[index]["text"].toString(),
                                    color: Colors.black,
                                    fontweight: FontWeight.bold,
                                    fontsize: 10),
                                UiHelper.CustomImage(
                                    img: data[index]["img"].toString())
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = categroy[index];
                  return GestureDetector(
                    onTap: () => context.read<CartBloc>().add(AddToCartEvent(item["text"].toString(), item['price'] as int)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            height: 108,
                            width: 93,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: UiHelper.CustomImage(
                                img: item["img"].toString()),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: UiHelper.CustomText(
                              text: item["text"].toString(),
                              color: Colors.black,
                              fontweight: FontWeight.bold,
                              fontsize: 8),
                        ),
                        SizedBox(height: 5),
                        UiHelper.CustomText(
                            text: "₹${item["price"]}",
                            color: Colors.deepOrange,
                            fontweight: FontWeight.bold,
                            fontsize: 12),
                      ],
                    ),
                  );
                },
                itemCount: categroy.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 20),
              UiHelper.CustomText(
                  text: "Grocery & Kitchen",
                  color: Colors.black,
                  fontweight: FontWeight.bold,
                  fontsize: 14,
                  fontfamily: "bold")
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 78,
                          width: 71,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0XFFD9EBEB)),
                              child: UiHelper.CustomImage(
                              img: grocerykitchen[index]["img"].toString()),
                        ),
                      ),
                      UiHelper.CustomText(
                          text: grocerykitchen[index]["text"].toString(),
                          color: Colors.black,
                          fontweight: FontWeight.normal,
                          fontsize: 10)
                    ],
                  );
                },
                itemCount: grocerykitchen.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
        bottomNavigationBar: BlocBuilder<CartBloc,CartState>(
            builder: (context, state) {
              if(state.totalCost==0) return SizedBox.shrink();
              final totalItems = state.cart.values.fold<int>(
                0,
                    (sum, item) => sum + (item['quantity'] as int),
              );

              final totalCost = state.cart.values.fold<int>(
                0,
                    (sum, item) => sum + ((item['quantity'] as int) * (item['price'] as int)),
              );
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetailsScreen(cart: state.cart)),
                );
              },
                child: Container(
                  color: Colors.deepOrange,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$totalItems items | ₹$totalCost",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text("View Order", style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              );
            }),
      );
  }
}

class OrderDetailsScreen extends StatefulWidget {
  final Map<String, Map<String, dynamic>> cart;
  const OrderDetailsScreen({super.key, required this.cart});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  void updateQuantity(String name, int change) {

    context.read<CartBloc>().add(UpdateQuantityEvent(name, change));
    setState(() {
      if (widget.cart.containsKey(name)) {
        widget.cart[name]!['quantity'] += change;
        if (widget.cart[name]!['quantity'] <= 0) {
          widget.cart.remove(name);
        }
      }
    });
  }

  int get totalCost => widget.cart.values.fold(
      0,
          (sum, item) =>
      sum + ((item['quantity'] as int) * (item['price'] as int)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return ListView(
            children: state.cart.values.map((item) {
              return ListTile(
                title: Text(item['name']),
                subtitle: Text("₹${item['price']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () =>
                          context.read<CartBloc>().add(UpdateQuantityEvent(item['name'], -1)),
                      icon: Icon(Icons.remove),
                    ),
                    Text(item['quantity'].toString()),
                    IconButton(
                      onPressed: () =>
                          context.read<CartBloc>().add(UpdateQuantityEvent(item['name'], 1)),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),

      bottomNavigationBar: InkWell(
        onTap: () {
          context.read<CartBloc>().add(ClearCartEvent());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ConfirmScreen()),
          );
        },
        child: Container(
          color: Colors.deepOrange,
          padding: EdgeInsets.all(16),
          child: Text("Confirm Order (₹$totalCost)",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
    return Scaffold(
      body: Center(
        child: Text("✅ Order Confirmed!",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
      ),
    );
  }
}
