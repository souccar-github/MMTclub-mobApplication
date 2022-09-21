// import 'package:flutter/material.dart';
// import 'package:mmt_club/Models/Project/gifts_model.dart';
// import 'package:mmt_club/screens/gift_screen.dart';

// import '../../styles/app_colors.dart';

// class GiftCard extends StatelessWidget {
//   final GiftsModel gift;
//   const GiftCard({Key? key, required this.gift}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => GiftScreen(gift: gift),
//             ),
//           );
//         },
//         child: Container(
//           color: const Color.fromARGB(255, 235, 243, 242),
//           child: ListTile(
//             title: Text(
//               gift.name,
//               style: TextStyle(
//                   color: AppColors.textBlack.withOpacity(0.7), fontSize: 16),
//             ),
//             subtitle: Text(
//               gift.description ?? "",
//               style: TextStyle(
//                 color: AppColors.textBlack.withOpacity(0.7),
//                 fontSize: 14,
//               ),
//               overflow: TextOverflow.ellipsis,
//               softWrap: false,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
