import 'package:ecommerce_new_new/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body: cart.cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];
                      return ListTile(
                        leading: Image.network(item['thumbnail'], width: 50),
                        title: Text(item['title']),
                        subtitle: Text(
                            "Price: \$${item['price']} x ${item['quantity']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon:
                                  Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => cart.decrementQuantity(item),
                            ),
                            Text("${item['quantity']}",
                                style: TextStyle(fontSize: 18)),
                            IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.green),
                              onPressed: () => cart.incrementQuantity(item),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      "Total: \$${cart.getTotalPrice().toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
    );
  }
}
