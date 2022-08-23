
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ItemLayout extends StatelessWidget {
//   final  model;
//   const ItemLayout({Key? key, required this.model})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         height: 100.h,
//         child: Card(
//           elevation: 9,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 height: 150.h,
//                 width: 100.w,
//                 color: Colors.white,
//                 child: Image.network(
//                   productDetailsModel.firstImage,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               Expanded(
//                 child: ListTile(
//                   dense: false,
//                   title: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       productDetailsModel.name,
//                       style: TextStyle(
//                           //fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: AppColors.basicColor),
//                     ),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 5.0),
//                     child: Text(
//                       productDetailsModel.description,
//                       style: const TextStyle(fontSize: 14),
//                       maxLines: 3,
//                     ),
//                   ),
//                   trailing: Icon(
//                     Icons.arrow_forward_ios,
//                     color: AppColors.basicColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
