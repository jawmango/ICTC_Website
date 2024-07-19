import 'package:ICTC_Website/models/course.dart';
import 'package:ICTC_Website/models/trainer.dart';
import 'package:ICTC_Website/pages/desktop/preRegister/preregister.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class CourseCardMobile extends StatefulWidget {
  CourseCardMobile({super.key, required this.course});

  final Course course;

  @override
  State<CourseCardMobile> createState() => _CourseCardState();
}


class _CourseCardState extends State<CourseCardMobile> {
  late Future<String?> courseUrl = getCourseUrl();

  Future<String?> getCourseUrl() async {
    try {
      final url = await Supabase.instance.client.storage
          .from('images')
          .createSignedUrl('${widget.course.id}/image.png', 60);
      return url;
    } catch (e) {
      return null;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 600,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('${program.title}',
              //         style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.w400,
              //             decoration: TextDecoration.underline)),
              //     //Text("₱ ${course.cost}")
              //   ],
              // ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12)),
                child: FutureBuilder(
                    future: courseUrl,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        final url = snapshot.data!;
                        return Image.network(
                          url,
                          fit: BoxFit.cover,
                        );
                      }

                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/logo_ictc.png'),
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('No image attached.',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54))
                        ],
                      ));
                    }),
              ),
              Text('${widget.course.title}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              SizedBox(height: 7),
              Row(
                  children: [

                    
                    Text(
                      "Schedule: ",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      " ${DateFormat.yMMMMd().format(widget.course.startDate!)} - ${DateFormat.yMMMMd().format(widget.course.endDate!)} ",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 7),
              Row(
                children: [
                   Text(
                      "Trainer: ",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  FutureBuilder(
                              future: Supabase.instance.client
                    .from('trainer')
                    .select('first_name, last_name')
                    .eq('id', '${widget.course.trainerId}')
                    .single()
                    .then((response) {
                  final firstName = response['first_name'] as String;
                  final lastName = response['last_name'] as String;
                  final fullName = '$firstName $lastName';
                  return fullName;
                              }),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(
                    snapshot.data ?? '',
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                           ),
                          );
                  }
                              },
                            ),
                ],
              ),
                SizedBox(height: 7),
              Text(
                '${HtmlUnescape().convert(widget.course.description ?? "No description provided.")}',
                maxLines: 3,
                textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: true,
                    applyHeightToLastDescent: true),
                //style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
              ),
              
              
             
              // Text('${course.schedule}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              // SizedBox(height: 10),
              // Text('${course.duration}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              // SizedBox(height: 10),
              // Text('${course.venue}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FilledButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PreRegisterPage(course: widget.course)));
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
              //Expanded(child: Placeholder())
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
