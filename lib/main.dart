import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product.dart'; // Importing product class
import 'theme.dart'; // Importing theme class

void main() {
  runApp(MyApp());
}

// Main application widget with stateful behavior to manage theme switching.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Variable to track the current theme mode.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemes.lightTheme, // Set light theme as default
      darkTheme: AppThemes.darkTheme, // Set dark theme
      themeMode: isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Toggle between light and dark mode
      home: CatalogPage(
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode; // Toggle the theme mode on button press
          });
        },
      ),
    );
  }
}

// Product catalog page with list of products.
class CatalogPage extends StatelessWidget {
  final VoidCallback onThemeToggle; // Callback for theme toggle action
  final List<Product> products = [
    Product(
        name: 'Laptop',
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/03/27/07/08/notebook-1283862_1280.jpg',
        price: 999.99),
    Product(
        name: 'Smartphone',
        imageUrl:
            'https://cdn.pixabay.com/photo/2014/10/23/18/05/battery-499946_1280.jpg',
        price: 499.99),
    Product(
        name: 'Headphones',
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/11/29/03/53/audio-1867121_1280.jpg',
        price: 199.99),
  ];

  CatalogPage({required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Store'), // AppBar title
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6), // Theme toggle button
            onPressed: onThemeToggle, // Toggle theme when button is pressed
          ),
        ],
      ),
      // Display the products in a grid layout
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () {
            // Display a snackbar when a product is tapped
            Get.snackbar(
              'Product Selected',
              products[i].name,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: ProductCard(
              product: products[i]), // Create a product card for each product
        ),
      ),
    );
  }
}

// Product card widget with animation and interactivity.
class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double _opacity = 0.0; // Initial opacity for animation

  @override
  void initState() {
    super.initState();
    // Delay to animate opacity
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0; // Fade in animation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(seconds: 1), // Duration for the fade-in effect
      opacity: _opacity, // Opacity controlled by the state
      child: Card(
        child: Column(
          children: [
            Image.network(widget.product.imageUrl, height: 100,
                errorBuilder: (context, error, stackTrace) {
              // Handle image loading errors
              return Icon(Icons.error);
            }), // Display product image
            SizedBox(height: 10),
            Text(
              widget.product.name, // Display product name
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${widget.product.price}', // Display product price
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
