import 'dart:convert';
import 'dart:math';

import 'package:ecom/data/product_data.dart';
import 'package:ecom/pages/HomeScreen/categorywidget.dart';
import 'package:ecom/pages/cart_favrt/cart_items.dart';
import 'package:ecom/pages/cart_favrt/favourite_page.dart';
import 'package:ecom/widgets/elevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String mydata = jsonEncode(cartItems);
    prefs.setString('mydata', mydata);
  }

  Future<void> gettasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? mydata = prefs.getString('mydata');
    if (mydata != null) {
      final List mydatalist = jsonDecode(mydata);
      setState(() {
        cartItems.clear();
        cartItems.addAll(
            mydatalist.map((e) => Map<String, dynamic>.from(e)).toList());
      });
    }
  }

  List topimages = [
    "assets/images/banner1.jpg",
    "assets/images/banner3.jpg",
    "assets/images/banner2.jpg",
  ];
  List<Map<String, dynamic>> cartItems = [];
  List favlist = [];

  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.80,
    );
    gettasks();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  double getCartItemCount() {
    return cartItems.fold<double>(
        0, (sum, item) => sum + (item["quantity"] ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: const Text(
          "Karachi City, Central Java",
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
        actions: [
          badges.Badge(
            badgeContent: Text(
              cartItems
                  .fold<num>(
                    0,
                    (sum, item) => sum + (item["quantity"] ?? 0),
                  )
                  .toString(),
            ),
            child: IconButton(
              onPressed: () async {
                setState(() {}); // Update the UI after adding/removing items
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(finalCart: cartItems)),
                );
                setState(
                    () {}); // Refresh the UI when returning from the CartPage
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavouritePage(favfinal: favlist),
                  ),
                );
              },
              icon: const Icon(Icons.favorite_outlined),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search Here",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 170,
              child: PageView.builder(
                itemCount: topimages.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      topimages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text("Image not found"));
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "All Category",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Categorywidget(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 275,
                ),
                itemCount: product.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              color: Colors.grey.shade200,
                              image: DecorationImage(
                                image: AssetImage(product[index]["image"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product[index]["text2"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (product[index]["isfav"] == true) {
                                          product[index]["isfav"] = false;
                                          favlist.remove(product[index]);
                                        } else {
                                          product[index]["isfav"] = true;
                                          favlist.add(product[index]);
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.favorite),
                                    color: product[index]["isfav"] == true
                                        ? Colors.red
                                        : Colors.blueGrey[600],
                                  ),
                                ],
                              ),
                              Text('Rs ${product[index]["text"]}'),
                              MYElevatedButton(
                                buttonText: "  Add To Cart  ",
                                onPressed: () {
                                  setState(() {
                                    saveTasks();
                                    int itemIndex = cartItems.indexWhere(
                                        (item) =>
                                            item["id"] == product[index]["id"]);
                                    if (itemIndex == -1) {
                                      cartItems.add(
                                          {...product[index], "quantity": 1});
                                    } else {
                                      cartItems[itemIndex]["quantity"] += 1;
                                    }
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green[400],
                                      content: Text(
                                          "${product[index]["text2"]} added to Cart"),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
