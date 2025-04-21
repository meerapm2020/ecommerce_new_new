import 'dart:convert';

import 'package:ecommerce_new_new/cart_provider.dart';
import 'package:ecommerce_new_new/cart_screen.dart';
import 'package:ecommerce_new_new/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            ),
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            showPopover(
                              context: context,
                              bodyBuilder: (context) => MenuItems(),
                              width: 250,
                              height: 150,
                              backgroundColor: Colors.deepPurple.shade50,
                              direction: PopoverDirection.bottom,
                              arrowHeight: 10,
                              arrowWidth: 20,
                            );
                          },
                          child:
                              Image.network(product['thumbnail'], height: 250)),
                      Text(product['title']),
                      Text('\$${product['price']}'),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Provider.of<CartProvider>(context, listen: false)
                      //         .addToCart(product);
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(content: Text("Added to cart")));
                      //   },
                      //   child: Text("Add to Cart"),
                      // ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
