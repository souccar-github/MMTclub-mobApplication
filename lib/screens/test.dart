// import 'package:flutter/material.dart';
// import 'package:flutter_offline/flutter_offline.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Offline Demo',
//       theme: ThemeData.dark(),
//       home: Scaffold(
//         appBar: new AppBar(
//           title: new Text("Offline Demo"),
//         ),
//         body: OfflineBuilder(
//             connectivityBuilder: (
//               BuildContext context,
//               ConnectivityResult connectivity,
//               Widget child,
//             ) {
//               final bool connected = connectivity != ConnectivityResult.none;
//               return new Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Positioned(
//                     height: 24.0,
//                     left: 0.0,
//                     right: 0.0,
//                     child: Container(
//                       color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
//                       child: Center(
//                         child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
//                       ),
//                     ),
//                   ),
//                   connected
//                       ? Center(
//                           child: new Text(
//                             'hi',
//                           ),
//                         )
//                       : Center(
//                           child: new Text(
//                             'Yay!',
//                           ),
//                         ),
//                 ],
//               );
//             },
//             child: Container()),
//       ),
//     );
//   }
// }
