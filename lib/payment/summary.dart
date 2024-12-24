import 'package:ecom/payment/finalpage.dart';
import 'package:ecom/widgets/elevatedbutton.dart';
import 'package:flutter/material.dart';

class Summar extends StatelessWidget {
  final double productCharges;
  final double deliveryCharges;

  Summar(
      {super.key, required this.productCharges, required this.deliveryCharges});

  double getTotal() {
    double tax = 200;
    return productCharges + deliveryCharges + tax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summary")),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            const Text("Total Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Product Charges: Rs ",
                          style: TextStyle(fontSize: 16)),
                      Text("$productCharges"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Charges: Rs ",
                          style: TextStyle(fontSize: 16)),
                      Text("$deliveryCharges"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax: Rs ", style: TextStyle(fontSize: 16)),
                      Text("200"),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Rs ${getTotal().toString()}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            MYElevatedButton(
                buttonText: "Continue",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentMethodPage(totalamount: productCharges, delievry: deliveryCharges,)));
                })
          ],
        ),
      ),
    );
  }
}
