import 'dart:convert';

import 'package:ecom/payment/deleivery.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  final List finalCart;

  const CartPage({super.key, required this.finalCart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String mydata = jsonEncode(widget.finalCart);
    prefs.setString('mydata', mydata);
  }

  Future<void> gettasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? mydata = prefs.getString('mydata');
    if (mydata != null) {
      final List mydatalist = jsonDecode(mydata);
      setState(() {
        widget.finalCart.clear();
        widget.finalCart.addAll(
            mydatalist.map((e) => Map<String, dynamic>.from(e)).toList());
      });
    }
  }

  double calculateTotalPrice() {
    return widget.finalCart.fold(0.0, (total, item) {
      double price = 0.0;
      if (item["text"] is String) {
        price = double.tryParse(item["text"]) ?? 0.0;
      } else if (item["text"] is double) {
        price = item["text"];
      }
      int quantity = item["quantity"] ?? 0;
      return total + (price * quantity);
    });
  }

  // Function to update the quantity of an item
  void updateQuantity(int index, int change) {
    setState(() {
      if (widget.finalCart[index]["quantity"] + change <= 0) {
        widget.finalCart.removeAt(index);
      } else {
        widget.finalCart[index]["quantity"] += change;
      }
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(title: const Text("Cart Items")),
      body: widget.finalCart.isEmpty
          ? const Center(
              child:
                  Text("Your cart is empty!", style: TextStyle(fontSize: 18)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.finalCart.length,
                    itemBuilder: (context, index) {
                      final item = widget.finalCart[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ListTile(
                          leading:
                              Image.asset(item["image"], width: 60, height: 60),
                          title: Text(item["text2"],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price: Rs ${item["text"]}",
                                  style: const TextStyle(fontSize: 14)),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Quantity: ${item["quantity"]}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle,
                                            color: Colors.red),
                                        onPressed: () =>
                                            updateQuantity(index, -1),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle,
                                            color: Colors.green),
                                        onPressed: () =>
                                            updateQuantity(index, 1),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 85,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("TOTAL",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("Rs ${calculateTotalPrice().toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            // Pass product charges to the next screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentOptionsBottomSheet(
                                  totalProductCharges: calculateTotalPrice(),
                                ),
                              ),
                            );
                          },
                          child: const Text("Select Payment Method"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[400])),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
