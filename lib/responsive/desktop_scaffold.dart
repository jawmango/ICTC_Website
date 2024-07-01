import 'package:ICTC_Website/constants.dart';
import 'package:ICTC_Website/util/my_box.dart';
import 'package:ICTC_Website/util/my_title.dart';
import 'package:flutter/material.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackground,
      appBar: myAppBar,
      body: Row(children: [
        //open drawer
        myDrawer,

        //rest of body
        Expanded(
          flex: 2,
          child: Column(
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
        }
        )
        ),

        Expanded(
          child: 
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.pink)
                  )
                ],
               )
                )

      ],))
      ],)
    );
  }
}