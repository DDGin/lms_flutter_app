/*
import 'package:flutter/material.dart';

// Assuming your Product class is defined as follows:
class Product {
  final String name;
  final String price;
  final int sales;
  final String image;

  Product(this.name, this.price, this.sales, this.image);
}

// Assuming _topProducts is a List<Product>
// final List<Product> _topProducts = [ ... ];

// Your widget code:
Widget build(BuildContext context) {
  // Use a SingleChildScrollView for the horizontal list
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: _topProducts.map((product) {
        return Container(
          width: 150,
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image,
                  height: 100,
                  width: 150,
                  fit: BoxFit.cover,
                  // Add loading and error builders for better UX
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 100,
                      width: 150,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: 150,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Product Name (Completed)
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              // Product Price (Completed)
              Text(
                product.price,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 4),

              // Sales Count (Completed)
              Text(
                "${product.sales} sales",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(), // Don't forget to call .toList() on the map result
    ),
  );
}
*/
