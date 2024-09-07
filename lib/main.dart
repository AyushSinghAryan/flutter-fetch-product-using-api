import 'package:flutter/material.dart';
import 'package:product_search_app/home_page.dart';
import 'package:product_search_app/services/product_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductServices(),
      child: MaterialApp(
        title: 'Products',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
          ),
          // useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
