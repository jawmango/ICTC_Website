import 'package:ICTC_Website/models/register.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ICTC_Website/models/course.dart';
import 'package:ICTC_Website/models/student.dart';
import 'package:ICTC_Website/pages/desktop/profile/editProfileForm.dart';
import 'package:ICTC_Website/widgets/dialogWidget.dart';
import 'package:ICTC_Website/widgets/regisConfirm.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:html_unescape/html_unescape.dart';

class PreRegisterPage extends StatefulWidget {
  const PreRegisterPage({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  State<PreRegisterPage> createState() => _PreRegisterPageState();
}

class _PreRegisterPageState extends State<PreRegisterPage> {
  late Future<String?> courseUrl = getCourseUrl();
  bool _isLoggedIn = false;

  Future<String?> getCourseUrl() async {
    try {
      final url = await Supabase.instance.client.storage
          .from('images')
          .createSignedUrl(
              '${widget.course.id}/image.png',
              60);
      return url;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  void checkLoggedIn() {
    // Check if the user is logged in
    final supabase = Supabase.instance.client;
    if (supabase.auth.currentSession?.user != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  Future<bool> isRegistered() async {
    final uuid = Supabase.instance.client.auth.currentSession?.user.id;
    final studentId = await Supabase.instance.client
        .from('student')
        .select('id')
        .eq('uuid', uuid ?? "")
        .single()
        .withConverter((data) => data['id'] as int);
    final query = await Supabase.instance.client
        .from('registration')
        .select()
        .eq('course_id', widget.course.id!)
        .eq('student_id', studentId)
        .limit(1)
        .maybeSingle();

    print(query);

    return query != null && query.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBox(context),
            FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
            ),
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
                      Image(image: AssetImage('assets/images/logo_ictc.png'), fit: BoxFit.cover, height: 200, width: 150,),
                      SizedBox(height:20  ,),
                      Text('No image attached.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54))
                    ],
                  ),
                );
              }
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.3,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                //color: Color(0xFFF2F2F2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.course.title}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                          '₱ ${widget.course.cost}',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w600),
                        ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Venue: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '${widget.course.venue}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
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
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Duration: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '${widget.course.duration}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                children: [
                   Text(
                      "Trainer: ",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                           ),
                          );
                  }
                              },
                            ),
                ],
              ),
                    Text(
                      '${HtmlUnescape().convert(widget.course.description ?? "No description provided.")}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 25),
                    registerButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerButton(context) {
    return FutureBuilder(
      future: isRegistered(),
      builder: (context, snapshot) {
        print(snapshot.data);
        print(_isLoggedIn);
        return FilledButton(
          style: ButtonStyle(
              backgroundColor: snapshot.data == true
                  ? MaterialStateProperty.all(Colors.grey)
                  : MaterialStateProperty.all(Colors.green)),
          onPressed: snapshot.data == true
              ? null
              : () async {
                  if (_isLoggedIn) {
                    final result = await showDialog(
                        barrierLabel: 'Register',
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              registerDialog(context),
                            ],
                          );
                        });
                    print(result);
                  } else {
                    await showDialog(
                        barrierLabel: 'Pre-Register',
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return FormDialog();
                        });
                  }

                  checkLoggedIn();
                },
          child: snapshot.data == null && _isLoggedIn == false
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: snapshot.data == null && _isLoggedIn == true
                      ? CircularProgressIndicator()
                      : Text(
                          'Pre-register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                )
              : Text(
                  snapshot.data == true && snapshot.data != null
                      ? 'Already preregistered'
                      : 'Pre-register',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
        );
      },
    );
  }

  Widget registerDialog(context) {
    final uuid = Supabase.instance.client.auth.currentSession?.user.id;

    return Container(
      // width: MediaQuery.of(context).size.width * 0.3,
      // height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            future: Supabase.instance.client
                .from('student')
                .select()
                .eq('uuid', uuid ?? "")
                .single()
                .withConverter((data) => Student.fromJson(data)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                final student = snapshot.data!;

                // if (student.school == null && student.office == null) {
                //   return AlertDialog(
                //       content: Container(
                //           width: MediaQuery.of(context).size.width * 0.3,
                //           height: MediaQuery.of(context).size.height * 0.5,
                //           child: SingleChildScrollView(
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 ProfileForm(student: student),
                //               ],
                //             ),
                //           )));
                // }

                return AlertDialog(
                    titlePadding: EdgeInsets.fromLTRB(0, 32, 0, 0),
                    title: Center(
                        child: Text(
                      'Confirm Registration',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    )),
                    actionsPadding: EdgeInsets.only(bottom: 0),
                    contentPadding:
                        EdgeInsets.only(top: 0, right: 40, left: 40, bottom: 0),
                    content: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ConfirmDialog(course: widget.course, student: student),
                        ],
                      ),
                    ));
              }

              return Text('Error');
            },
          ),
        ],
      ),
    );
  }
}
