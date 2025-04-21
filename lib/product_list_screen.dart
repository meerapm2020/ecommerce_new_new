import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:popover/popover.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body)['products'];
      });
    }
  }

  void showCustomPopover(BuildContext context, GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    showPopover(
      context: context,
      bodyBuilder: (context) => Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          height: 40,
          color: Colors.deepPurple[300],
          alignment: Alignment.center,
          child: Text("Add to Cart"),
        ),
        Container(
          height: 40,
          color: Colors.deepPurple[200],
          alignment: Alignment.center,
          child: Text("Add to Wishlist"),
        ),
        Container(
          height: 50,
          color: Colors.deepPurple[300],
          alignment: Alignment.center,
          child: Text("View Details"),
        ),
      ])),
      direction: PopoverDirection.left,
      backgroundColor: Colors.deepPurple.shade50,
      width: 200,
      height: 150,
      arrowHeight: 10,
      arrowWidth: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("E-commerce App")),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final GlobalKey key = GlobalKey();

                return Card(
                  child: Column(
                    children: [
                      Builder(
                        builder: (context) {
                          return IconButton(
                            key: key,
                            icon: Image.network(product['thumbnail'],
                                height: 100),
                            onPressed: () {
                              showCustomPopover(context, key);
                            },
                          );
                        },
                      ),
                      Text(product['title']),
                      Text('\$${product['price']}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
