import 'package:ecom/pages/HomeScreen/homeview.dart';
import 'package:ecom/widgets/elevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentMethodPage extends StatefulWidget {
  final double totalamount;
  final double delievry;

  PaymentMethodPage(
      {Key? key, required this.totalamount, required this.delievry})
      : super(key: key);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  void clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('mydata'); // Clears all data
    print('All data cleared');
  }

  String? selectedCard;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController securityCodeController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();

  // Define the method inside the _PaymentMethodPageState class
  double finalamountsummary() {
    int tax = 200;
    return widget.totalamount + widget.delievry + tax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment method"),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select existing card",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedCard,
              isExpanded: true,
              hint: const Text("Choose card"),
              items: [
                const DropdownMenuItem(
                  value: "1934",
                  child: Row(
                    children: [
                      Icon(Icons.credit_card),
                      SizedBox(width: 8),
                      Text("**** **** **** 1934"),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedCard = value;
                });
              },
            ),
            if (selectedCard != null)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      selectedCard = null;
                    });
                  },
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              "Or input new card",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Card number",
                suffixIcon: Icon(Icons.credit_card),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: "Exp date",
                      hintText: "mm/yy",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: securityCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Security code",
                      hintText: "ccv/csv",
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: cardHolderController,
              decoration: const InputDecoration(
                labelText: "Card holder",
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${finalamountsummary().toStringAsFixed(2)}", // Call the method correctly
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: const Color(0xffFFFFFF),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 700,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 200,
                              width: 300,
                              child: Image.asset("assets/images/check.jpg")),
                          const Text(
                            "Congrats Your Payment Is",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            "Success!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Thank you for your order. For further inquiries, contact us.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                          const Spacer(),
                          MYElevatedButton(
                              buttonText: "Continue",
                              onPressed: () {
                                clearAllData();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Homeview()));
                              })
                        ],
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green[300],
              ),
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
