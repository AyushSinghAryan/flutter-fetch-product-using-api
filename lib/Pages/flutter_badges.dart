// import 'package:flutter/material.dart';

// class FlutterBadges extends StatefulWidget {
//   const FlutterBadges({super.key});

//   @override
//   State<FlutterBadges> createState() => _FlutterBadgesState();
// }

// class _FlutterBadgesState extends State<FlutterBadges> {
//   @override
//   Widget build(BuildContext context) {
//       int cartItemCount = value.userCart.length; // Example, depends on your logic

//     return badges.Badge(
//       position: badges.BadgePosition.topEnd(top: -2, end: 1),
//       badgeContent: Text(
//         cartItemCount.toString(),
//         style: TextStyle(color: Colors.white, fontSize: 13),
//       ),
//       child: GestureDetector(
//         onTap: () async {
//           // Navigate to CartPage and wait for result
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CartPage(),
//             ),
//           );

//           // Once the user returns from CartPage, update the badge if necessary
//           setState(() {
//             // Update the cartItemCount if value.userCart changes
//             cartItemCount = value.userCart.length;
//           });
//         },
//         child: const Padding(
//           padding: EdgeInsets.only(right: 15.0),
//           child: Icon(
//             Icons.shopping_cart_outlined,
//             color: Colors.white,
//             size: 28,
//           ),
//         ),
//       ),
//     );
//   }
// }