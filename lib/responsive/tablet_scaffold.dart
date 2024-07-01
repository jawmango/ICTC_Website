import 'package:ICTC_Website/constants.dart';
import 'package:ICTC_Website/util/my_box.dart';
import 'package:ICTC_Website/util/my_title.dart';
import 'package:flutter/material.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackground,
      appBar: myAppBar,
      drawer: myDrawer,

      body: Column(
        children: [

        AspectRatio(
          aspectRatio: 4,
          child: SizedBox(
            width: double.infinity,
            child: GridView.builder(
              itemCount: 4, //4 boxes
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), //2 in each row
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