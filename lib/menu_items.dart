import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // Add Material to give proper look and tap effect
      color: Colors.deepPurple.shade50,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Important to avoid overflow
        children: [
          ListTile(
            
            title: Text("Add to Cart"),
            onTap: () {
              Navigator.pop(context);
              
            },
          ),
          ListTile(
           
            title: Text("Add to wishlist"),
            onTap: () {
              Navigator.pop(context);
              
            },
          ),
          ListTile(
           
            title: Text("View Details"),
            onTap: () {
              Navigator.pop(context);
              
            },
          ),
        ],
      ),
    );
  }
}
