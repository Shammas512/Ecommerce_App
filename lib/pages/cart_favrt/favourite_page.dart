import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  final List favfinal;
  const FavouritePage({super.key, required this.favfinal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Items"),
        backgroundColor: const Color(0xff000080),
        foregroundColor: const Color(0xffFFFFFF),
      ),
      backgroundColor: const Color(0xffFFFFFF),
      body: favfinal.isEmpty
          ? const Center(
              child: Text(
                "No favourite items yet!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favfinal.length,
                    itemBuilder: (context, index) {
                      final item = favfinal[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          // horizontal: 10.0,
                        ),
                        child: ListTile(
                          tileColor: const Color(0xff000080),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          leading: item["image"] != null
                              ? Image.asset(
                                  item["image"],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image, color: Colors.white),
                          title: Text(
                            item['text2']?.toString() ?? 'Unnamed Item',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
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
