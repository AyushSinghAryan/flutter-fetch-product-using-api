import 'package:flutter/material.dart';
import 'package:product_search_app/services/product_services.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Calculate total price

  double getTotalPrice() {
    final value = Provider.of<ProductServices>(context, listen: false);

    return value.userCart.fold(
      0,
      (previousValue, product) => previousValue + product.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductServices>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Your Cart",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Display list of cart items
                    Expanded(
                      child: value.userCart.isEmpty
                          ? Center(
                              child: Text(
                                "Your cart is empty",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                            )
                          : ListView.builder(
                              itemCount: value.userCart.length,
                              itemBuilder: (context, index) {
                                final product = value.userCart[index];
                                return Card(
                                  margin: EdgeInsets.only(bottom: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Product Image
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            product.image,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 15),

                                        // Product Name and Price
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.title,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "\$${product.price.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Remove Button
                                        IconButton(
                                          icon: Icon(Icons.delete_outline,
                                              color: Colors.redAccent),
                                          onPressed: () {
                                            value.removeItemToCart(product);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "${product.title} removed from cart!"),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    // Total Price and Pay Now Button
                    if (value.userCart.isNotEmpty)
                      Column(
                        children: [
                          Divider(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$${getTotalPrice().toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Colors.pinkAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                // Handle payment process
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Proceeding to payment...")),
                                );
                              },
                              child: Text(
                                "Pay Now",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ));
  }
}
