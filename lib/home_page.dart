import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:product_search_app/Pages/cart_page.dart';
import 'package:product_search_app/models/product_Item.dart';
import 'package:product_search_app/services/product_services.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isConnected = true;

  bool isLoading =
      true; // To show loading indicator while products are being fetched
  final FocusNode _searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    checkConnection();
    fetchLatestProducts();
  }

  fetchLatestProducts() async {
    await ProductServices().fetchProduct();
    setState(() {
      isLoading = false; // Update loading state
    });
  }

  Future<void> checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = result != ConnectivityResult.none;
    });
  }

  void _filterProducts(String query) {
    setState(() {
      ProductServices.filteredProducts = ProductServices.products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<ProductServices>(context, listen: true);
    int cartLength = value.userCart.length;

    return Scaffold(
      backgroundColor: Colors.grey[900], // Modern dark theme background
      appBar: AppBar(
        title: const Text(
          "Shop Products",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -2, end: 1),

            badgeContent: Text(
              cartLength.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
            // badgeColor: Colors.green,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: isConnected
          ? isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pinkAccent,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                          focusNode: _searchFocusNode,
                          onChanged: _filterProducts,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.white),
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 20.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: ProductServices.filteredProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (context, index) {
                            return ProductItem(
                              product: ProductServices.filteredProducts[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
          : const Center(
              child: Text(
                'Please connect to the internet',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
    );
  }
}
