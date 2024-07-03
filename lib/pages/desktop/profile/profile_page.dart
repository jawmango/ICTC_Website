import 'dart:async';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ICTC_Website/models/course.dart';
import 'package:ICTC_Website/models/student.dart';
import 'package:ICTC_Website/pages/desktop/home.dart';
import 'package:ICTC_Website/pages/desktop/profile/profileDetails.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ICTC_Website/pages/desktop/styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final _stream = Supabase.instance.client
      .from('student')
      .stream(primaryKey: ['id'])
      .eq('uuid', Supabase.instance.client.auth.currentSession?.user.id ?? "")
      .limit(1)
      .map((event) => Student.fromJson(event.first));

  late StreamSubscription authStream;

  @override
  void initState() {
    authStream =
        Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      print('noticed change');

      if (event.event == AuthChangeEvent.signedOut) {
        print('signed out, put back to home');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeDesktopPage(),
            ));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    authStream.cancel();
    super.dispose();
  }

  Future<bool> checkIfApproved(Student student, Course course) async { //payment status
    final query = await Supabase.instance.client
        .from('registration')
        .select('is_approved')
        .eq('student_id', student.id)
        .eq('course_id', course.id!)
        .single()
        .withConverter((data) => data['is_approved'] as bool);

    return query;
  }
  Future<bool> checkIfAttended(Student student, Course course) async { // Attendance Status
    final query = await Supabase.instance.client
        .from('registration')
        .select('attend_status')
        .eq('student_id', student.id)
        .eq('course_id', course.id!)
        .single()
        .withConverter((data) => data['attend_status'] as bool);

    return query;
  }
  Future<bool> checkIfBill(Student student, Course course) async { // Billing Status
    final query = await Supabase.instance.client
        .from('registration')
        .select('bill_status')
        .eq('student_id', student.id)
        .eq('course_id', course.id!)
        .single()
        .withConverter((data) => data['bill_status'] as bool);

    return query;
  }

  Future<bool> checkEval(Student student, Course course) async {
    final query = await Supabase.instance.client
        .from('registration')
        .select('eval_status')
        .eq('student_id', student.id)
        .eq('course_id', course.id!)
        .single()
        .withConverter((data) => data['eval_status'] as bool);

    return query;
  }

  Future<bool> checkCert(Student student, Course course) async {
    final query = await Supabase.instance.client
        .from('registration')
        .select('cert_status')
        .eq('student_id', student.id)
        .eq('course_id', course.id!)
        .single()
        .withConverter((data) => data['cert_status'] as bool);

    return query;
  }

  Future<String?> getCourseUrl(Course course) async {
    try {
      final url = await Supabase.instance.client.storage
          .from('images')
          .createSignedUrl(
              '${course.id}/image.png',
              60);
      return url;
    } catch (e) {
      return null;
    }
  }

  Future<List<Course>> getPendingCourses(Student student) async {
    final query = await Supabase.instance.client
        .from('course')
        .select('*, registration!inner(*)')
        .eq('registration.student_id', student.id)
        .eq('registration.is_approved', false)
        .withConverter(
          (data) => data
              .map(
                (e) => Course.fromJson(e),
              )
              .toList(),
        );

    return query;
  }

  Future<List<Course>> getOngoingCourses(Student student) async {
    final query = await Supabase.instance.client
        .from('course')
        .select('*, registration!inner(*)')
        .eq('registration.student_id', student.id)
        .eq('registration.is_approved', true)
        .eq('registration.eval_status', false)
        .withConverter(
          (data) => data
              .map(
                (e) => Course.fromJson(e),
              )
              .toList(),
        );

    return query;
  }

  Future<List<Course>> getCompletedCourses(Student student) async {
    final query = await Supabase.instance.client
        .from('course')
        .select('*, registration!inner(*)')
        .eq('registration.student_id', student.id)
        .eq('registration.is_approved', true)
        .eq('registration.eval_status', true)
        .withConverter(
          (data) => data
              .map(
                (e) => Course.fromJson(e),
              )
              .toList(),
        );

    return query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawerdesktop(),
        appBar: AppBarDesktop(),
        // backgroundColor: const Color.fromARGB(255, 146, 58, 58),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    buildStudentDetails(),
                  ],
                ),
                FooterWidget(),
              ],
            ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile_bg.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: const Color.fromARGB(38, 0, 0, 0)),
                  ),
          ),
        ));
  }

  Widget buildStudentDetails() {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return buildProfileWidgets(context, snapshot.data!);
        }

        return Center(child: Text('Are you not logged in?'));
      },
    );
  }

  Widget buildProfileWidgets(BuildContext context, Student student) {
    return Container(
      margin: EdgeInsets.only(left: 90),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileDetails(student: student),
            ],
          ),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Adjust the radius as needed
                ),
                  color: Colors.white,
                  elevation: 3,
                  child: pendingCard(context, student)),
                Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Adjust the radius as needed
                ),
                  color: Colors.white,
                  elevation: 3,
                  child: ongoingCard(context, student)),
                Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Adjust the radius as needed
                ),
                  color: Colors.white,
                  elevation: 3,
                  child: completedCard(context, student)),
                //completedCard(context, student)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pendingCard(BuildContext context, Student student) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20),
      Container(
        margin: EdgeInsets.only(left: 55),
        child: Text(
          'Pending Courses',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.19,
        width: MediaQuery.of(context).size.width * 0.63,
        margin: EdgeInsets.only(left: 50, right: 10, bottom: 15),
        child: FutureBuilder(
          future: getPendingCourses(student),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final courseList = snapshot.data!;

            if (courseList.isEmpty) {
              return Center(
                child: Text("No registered courses!"),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: courseList.length,
              scrollDirection:Axis.horizontal,
              itemBuilder: (context, index) {
                return createPendingText(courseList[index], student);
              },
            );
          },
        ),
      ),
    ],
  );
}


  Widget createPendingText(Course course, Student student) {
    return Row(
      children: [
           Container(
            width: MediaQuery.of(context).size.width * 0.15,
            margin: EdgeInsets.only(top: 0, bottom: 5, left: 5),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Color.fromARGB(139, 46, 46, 46),width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            child: InkWell(
              onTap: () async {
                await showDialog<void>(
                    barrierLabel: 'Pending Course Details',
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return buildPendingDialog(course, student);
                    }
                    //context: context, builder: (context) => buildPendingDialog(course)
                    );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height:35),
                        Text(
                          course.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height:5),
                        Text(
                            " ${DateFormat.yMMMMd().format(course.startDate!)} - ${DateFormat.yMMMMd().format(course.endDate!)} ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget buildPendingDialog(Course course, Student student) {
    return AlertDialog(
      content: Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        // height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    "Pending Course Details",
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 360,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: FutureBuilder(
                        future: getCourseUrl(course),
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
                              height: 200,
                              width: 150,
                            );
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/images/logo_ictc.png'),
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 150,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'No image attached.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Title: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(
                          text: '${course.title}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Cost: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(text:'₱''${course.cost}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Schedule: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(
                          text:
                              '${DateFormat.yMMMMd().format(course.startDate!)} - ${DateFormat.yMMMMd().format(course.endDate!)}',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  FutureBuilder(
                    future: checkIfBill(student, course),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return RichText(
                        text: TextSpan(
                          style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                          children: [
                            TextSpan(
                              text: 'Billing Statement: ',
                              style: AppTextStyles.displaySmallBlackDialog,
                            ),
                            TextSpan(
                              text: '${snapshot.data! ? "Sent" : "Pending"}',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  FutureBuilder(
                    future: checkIfApproved(student, course),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return RichText(
                        text: TextSpan(
                          style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                      ),
                          children: [
                            TextSpan(
                              text: 'Payment Status: ',
                              style: AppTextStyles.displaySmallBlackDialog,
                            ),
                            TextSpan(
                              text: '${snapshot.data! ? "Paid" : "Pending"}',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget ongoingCard(BuildContext context, Student student) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(left: 50),
          child: Text(
            'Ongoing Courses',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.19,
          width: MediaQuery.of(context).size.width * 0.63,
          margin: EdgeInsets.only(left: 50, right: 10, bottom: 15),
          child: FutureBuilder(
            future: getOngoingCourses(student),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final courseList = snapshot.data!;

              if (courseList.isEmpty) {
                return Center(
                  child: Text("No ongoing courses!"),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: courseList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return createOngoingText(courseList[index], student);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget createOngoingText(Course course, Student student) {
    return Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            margin: EdgeInsets.only(top: 0, bottom: 5, left: 5),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Color.fromARGB(139, 46, 46, 46), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            child: InkWell(
              onTap: () async {
                await showDialog<void>(
                    barrierLabel: 'Ongoing Course Details',
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return buildOngoingDialog(course, student);
                    }
                    //context: context, builder: (context) => buildOngoingDialog(course)
                    );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: [
                        SizedBox(height:35),
                        Text(
                          course.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height:5),
                        Text(
                          " ${DateFormat.yMMMMd().format(course.startDate!)} - ${DateFormat.yMMMMd().format(course.endDate!)} ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }

  Widget buildOngoingDialog(Course course, Student student) {
    return AlertDialog(
      content: Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        // height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    "Ongoing Course Details",
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 360,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12)),
                      child: FutureBuilder(
                                    future:getCourseUrl(course), 
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
                        fit: BoxFit.cover, height: 200, width: 150,
                      );
                                      }
                                      return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/images/logo_ictc.png'), fit: BoxFit.cover, height: 200, width: 150,),
                          SizedBox(height:8,),
                          Text('No image attached.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54))
                        ],
                      ),
                                      );
                                    }
                                  ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Title: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(
                          text: '${course.title}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Cost: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(text:'₱''${course.cost}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Schedule: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(
                          text:
                              '${DateFormat.yMMMMd().format(course.startDate!)} - ${DateFormat.yMMMMd().format(course.endDate!)}',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  FutureBuilder(
                      future: checkIfAttended(student, course),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return RichText(
                        text: TextSpan(
                          style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                          children: [
                            TextSpan(
                              text: 'Attendance Status: ',
                              style: AppTextStyles.displaySmallBlackDialog,
                            ),
                            TextSpan(
                              text: '${snapshot.data! ? "Complete" : "Pending"}',
                            ),
                          ],
                        ),
                      );
                      }),
                      SizedBox(height: 8),
                     FutureBuilder(
                      future: checkIfAttended(student, course),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasData && snapshot.data == true) {
                          return RichText(
                                text: TextSpan(
                                style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              color: Colors.black,// default color
                              ),
                              children: [
                                TextSpan(
                                  text: "Evaluation Link: ",
                                  style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0), // Replace with your desired color
    fontSize: 24, // Example of setting font size
    fontWeight: FontWeight.w500,                     
                                ),
                                ),
                                TextSpan(
                                  text: course.evalink,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 42, 134, 255), // same as default color
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final url = course.evalink;
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return RichText(
                        text: TextSpan(
                          style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                          children: [
                            TextSpan(
                              text: 'Evaluation Link: ',
                              style: AppTextStyles.displaySmallBlackDialog,
                            ),
                            TextSpan(
                              text: 'Please complete the attendance',
                            ),
                          ],
                        ),
                      );

                        }
                      },
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

Widget completedCard(BuildContext context, Student student) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(left: 50),
          child: Text(
            'Completed Courses',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.19,
          width: MediaQuery.of(context).size.width * 0.63,
          margin: EdgeInsets.only(left: 50, right: 10, bottom: 15),
          child: FutureBuilder(
            future: getCompletedCourses(student),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final courseList = snapshot.data!;

              if (courseList.isEmpty) {
                return Center(
                  child: Text("No Completed courses!"),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: courseList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return createCompletedText(courseList[index], student);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget createCompletedText(Course course, Student student) {
    return Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            margin: EdgeInsets.only(top: 10, bottom: 0, left: 5),
            height: 120,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Color.fromARGB(139, 46, 46, 46), width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
            child: InkWell(
              onTap: () async {
                await showDialog<void>(
                    barrierLabel: 'Completed Course Details',
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return buildCompletedDialog(course, student);
                    }
                    //context: context, builder: (context) => buildOngoingDialog(course)
                    );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height:35),
                        Text(
                          course.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height:5),
                        Text(
                          " ${DateFormat.yMMMMd().format(course.startDate!)} - ${DateFormat.yMMMMd().format(course.endDate!)} ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }

  Widget buildCompletedDialog(Course course, Student student) {
    return AlertDialog(
      content: Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        // height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    "Completed Course Details",
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 360,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12)),
                      child: FutureBuilder(
                                    future:getCourseUrl(course), 
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
                        fit: BoxFit.cover, height: 200, width: 150,
                      );
                                      }
                                      return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/images/logo_ictc.png'), fit: BoxFit.cover, height: 200, width: 150,),
                          SizedBox(height:20  ,),
                          Text('No image attached.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54))
                        ],
                      ),
                                      );
                                    }
                                  ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Title: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(
                          text: '${course.title}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Cost: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(text:'₱''${course.cost}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Schedule: ',
                          style: AppTextStyles.displaySmallBlackDialog,
                        ),
                        TextSpan(
                          text:
                              '${DateFormat.yMMMMd().format(course.startDate!)} - ${DateFormat.yMMMMd().format(course.endDate!)}',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  FutureBuilder(
                    future: checkCert(student, course),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return RichText(
                        text: TextSpan(
                          style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                          children: [
                            TextSpan(
                              text: 'Certificate: ',
                              style: AppTextStyles.displaySmallBlackDialog,
                            ),
                            TextSpan(
                              text: '${snapshot.data! ? "Sent" : "Pending"}',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
