// import 'package:flutter/material.dart';

// class ResponsiveLayout extends StatelessWidget {
//   final Widget mobileScaffold;
//   final Widget tabletSCaffold;
//   final Widget desktopScaffold;

//   ResponsiveLayout(
//     {
//       required this.mobileScaffold,
//       required this.tabletSCaffold,
//       required this.desktopScaffold,
//     }
//   )

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//     builder: (context, constraints){
//       if (constraints.maxWidth < 500)
//       {
//         return mobileScaffold;
//       } else if (constraints.maxWidth < 1100){
//         return tabletSCaffold;
//       } else {
//         return desktopScaffold;
//       }
//     },
//     );
//   }
// }