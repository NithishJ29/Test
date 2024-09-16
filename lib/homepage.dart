import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:testapp/product_detals.dart';
import 'package:testapp/cart_screen.dart';

import 'package:testapp/profilepage.dart'; // Import ProfilePage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String productsApiUrl = 'https://dummyjson.com/products';
  List<dynamic>? products;
  List<dynamic> cart = []; // List to store selected items (cart)
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchApiData();
  }

  Future<void> fetchApiData({String query = ''}) async {
    setState(() {
      isLoading = true;
    });

    try {
      String url = productsApiUrl;
      if (query.isNotEmpty) {
        url = '$productsApiUrl/search?q=$query'; // API search endpoint
      }
      final productsResponse = await http.get(Uri.parse(url));
      if (productsResponse.statusCode == 200) {
        products = json.decode(productsResponse.body)['products'];
      }
      setState(() {
        isLoading = false;
      });
    } on SocketException catch (e) {
      print('SocketException: $e');
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product); // Add product to cart
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product['title']} added to cart!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text('Products'),
        actions: [
          // Cart Icon in AppBar
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to Cart Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CartScreen(cartItems: cart), // Pass the cart list
                ),
              );
            },
          ),
          // Profile Icon in AppBar
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to Profile Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(), // Navigate to ProfilePage
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search products...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    fetchApiData(query: searchController.text);
                  },
                ),
              ),
              onChanged: (value) {
                // Fetch products as user types
                fetchApiData(query: value);
              },
            ),
            SizedBox(height: 10),
            Text(
              'Featured Products:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : products != null && products!.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Two products per row
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: products?.length ?? 0,
                          itemBuilder: (context, index) {
                            final product = products![index];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to Product Details on tap
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage(
                                                  product: product),
                                        ),
                                      );
                                    },
                                    child: Image.network(
                                      product['thumbnail'],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    product['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '\$${product['price']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      addToCart(product); // Add product to cart
                                    },
                                    child: Text('Add to Cart'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Center(child: Text('No products found')),
          ],
        ),
      ),
    );
  }
}
