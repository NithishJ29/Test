import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<dynamic> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Function to remove an item from the cart
  void removeFromCart(int index) {
    setState(() {
      widget.cartItems.removeAt(index); // Remove item by index
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Item removed from cart")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.cartItems.isEmpty
            ? Center(
                child: Text(
                  'Your cart is empty!',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final product = widget.cartItems[index];
                  return ListTile(
                    leading: Image.network(
                      product['thumbnail'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product['title']),
                    subtitle: Text('\$${product['price']}'),
                    trailing: IconButton(
                      icon:
                          Icon(Icons.remove_circle_outline, color: Colors.red),
                      onPressed: () {
                        removeFromCart(index); // Call the remove function
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
