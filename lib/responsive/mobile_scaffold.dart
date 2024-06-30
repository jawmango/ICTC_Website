import 'package:ICTC_Website/constants.dart';
import 'package:ICTC_Website/util/my_box.dart';
import 'package:ICTC_Website/util/my_title.dart';
import 'package:flutter/material.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: myDefaultBackground,
      drawer: myDrawer,

      body: Column(
        children: [

        AspectRatio(
          aspectRatio: 1,
          child: SizedBox(
            width: double.infinity,
            child: GridView.builder(
              itemCount: 4, //4 boxes
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), //2 in each row
            itemBuilder: (context, index) {
              return const MyBox();
            }),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemBuilder: (contex, index){
              return MyTitle();
        }))

        
      ],)
    );
  }
}