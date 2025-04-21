import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> item) {
    int index = cartItems.indexWhere((element) => element['id'] == item['id']);
    if (index != -1) {
      cartItems[index]['quantity']++;
    } else {
      item['quantity'] = 1;
      cartItems.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> item) {
    cartItems.removeWhere((element) => element['id'] == item['id']);
    notifyListeners();
  }

  void incrementQuantity(Map<String, dynamic> item) {
    int index = cartItems.indexWhere((element) => element['id'] == item['id']);
    if (index != -1) {
      cartItems[index]['quantity']++;
    }
    notifyListeners();
  }

  void decrementQuantity(Map<String, dynamic> item) {
    int index = cartItems.indexWhere((element) => element['id'] == item['id']);
    if (index != -1 && cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    } else {
      cartItems.removeAt(index);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    return cartItems.fold(
        0, (total, item) => total + (item['price'] * item['quantity']));
  }
}
