import 'package:ICTC_Website/models/course.dart';
import 'package:ICTC_Website/pages/desktop/preRegister/preregister.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
class SkillCard extends StatelessWidget {
  const SkillCard({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Micro-Credential",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline)),
                  //Text("₱ ${course.cost}")
                ],
              ),
              SizedBox(height: 20),
              Text('${course.title}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              SizedBox(height: 20),
              Text('${HtmlUnescape().convert(course.description ?? "No description provided.")}',
                maxLines: 3,
                textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: true,
                    applyHeightToLastDescent: true),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              SizedBox(height: 20),
              // Text('${course.schedule}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              // SizedBox(height: 10),
              // Text('${course.duration}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              // SizedBox(height: 10),
              // Text('${course.venue}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PreRegisterPage(course: course)));
                      },
                      child: Text(
                        "Pre-Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 40),
              //   child: AspectRatio(
              //     aspectRatio: 20 / 10,
              //     child: Image.asset(
              //       'assets/images/program1.png',
              //       fit: BoxFit.fitWidth,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}