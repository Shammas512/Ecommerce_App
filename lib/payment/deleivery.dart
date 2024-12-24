import 'package:flutter/material.dart';
import 'package:ecom/payment/summary.dart'; // Make sure the import is correct

class PaymentOptionsBottomSheet extends StatelessWidget {
  final double totalProductCharges;

  PaymentOptionsBottomSheet({required this.totalProductCharges});

  final List<Map<String, dynamic>> delivery = [
    {
      "icon": Icons.fire_truck,
      "title": "14 Days Delivery",
      "price": "Rs 100",
    },
    {
      "icon": Icons.car_repair,
      "title": "7 Days Delivery",
      "price": "Rs 400",
    },
    {
      "icon": Icons.delivery_dining,
      "title": "2 Days Express Delivery",
      "price": "Rs 700",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   const Text(
            "Select Delivery Method",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.blue,
              letterSpacing: 1.2,
              wordSpacing: 2.0,
             
            ),
            overflow: TextOverflow.ellipsis, 
          ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
        
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: delivery.length,
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1, color: Colors.grey),
              itemBuilder: (context, index) {
                final item = delivery[index];
                return Material(
                  color:
                      Colors.transparent, // Prevent Material color interference
                  child: ListTile(
                    leading: Icon(item["icon"], color: Colors.blue, size: 30),
                    title: Text(item["title"],
                        style: const TextStyle(fontSize: 16)),
                    subtitle: Text(item["price"],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    onTap: () {
                      double deliveryCharge = double.parse(
                          item["price"].substring(3)); // Parsing price
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Summar(
                            productCharges: totalProductCharges,
                            deliveryCharges: deliveryCharge,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
