import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/pages/desktop/placer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';

class AttendedDetails extends StatefulWidget {
  const AttendedDetails({super.key});

  @override
  State<AttendedDetails> createState() => _AttendedDetailsState();
}

class _AttendedDetailsState extends State<AttendedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Placer(
              child: attendedCourseDetails(context),
            ),
            FooterWidget()
          ],
        ),
      ),
    );
  }
}

Widget attendedCourseDetails(context) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.arrow_back),
            ),
            Text(
              "Attended Course Details",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
      Divider(),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Course Name: Advance Figma",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Course Date: January 12 - 13, 2024",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Payment Status: Paid",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Certificate Status: Received",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      )
    ],
  ));
}
