import 'package:ICTC_Website/models/student.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key, required this.student});

  final Student student;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

enum ProfileType { student, professional }

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController firstNameCon,
      lastNameCon,
      conactCon,
      emailCon,
      schoolCon,
      courseCon,
      yearLevelCon,
      officeCon,
      designationCon;

  @override
  void initState() {
    super.initState();

    print("student ${widget.student.id}");

    firstNameCon = TextEditingController(text: widget.student.firstName);
    lastNameCon = TextEditingController(text: widget.student.lastName);
    conactCon = TextEditingController(text: widget.student.contactNumber);
    emailCon = TextEditingController(text: widget.student.email);
    schoolCon = TextEditingController(text: widget.student.school);
    courseCon = TextEditingController(text: widget.student.course);
    yearLevelCon =
        TextEditingController(text: widget.student.yearLevel.toString());
    officeCon = TextEditingController(text: widget.student.office);
    designationCon = TextEditingController(text: widget.student.designation);

    if (widget.student.school != null) {
      _type = ProfileType.student;
    } else if (widget.student.office != null) {
      _type = ProfileType.professional;
    }
  }

  ProfileType? _type;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              prefix: const Row(
                children: [
                  Text("First Name",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              controller: firstNameCon,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
              placeholder: 'e.g. John',
              placeholderStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black45,
              ),
              onChanged: (_) => _formKey.currentState!.validate(),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              prefix: const Row(
                children: [
                  Text("Last Name",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              placeholder: 'e.g. De La Cruz',
              placeholderStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black45,
              ),
              controller: lastNameCon,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
              onChanged: (_) => _formKey.currentState!.validate(),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              prefix: const Row(
                children: [
                  Text("Email",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              controller: emailCon,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter an email address";
                }

                if (!EmailValidator.validate(value)) {
                  return "Enter a valid email address";
                }

                return null;
              },
              onChanged: (_) => _formKey.currentState!.validate(),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              prefix: const Row(
                children: [
                  Text("Contact Number",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              placeholder: 'e.g. 09123456789',
              placeholderStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black45,
              ),
              controller: conactCon,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return 'Please enter your contact number';
              //   }
              //   return null;
              // },
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (_) => _formKey.currentState!.validate(),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       "I am a: ",
          //       style: TextStyle(
          //         color: Colors.black87,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //     Expanded(
          //       child: ListTile(
          //         leading: Radio<ProfileType>(
          //           value: ProfileType.student,
          //           groupValue: _type,
          //           onChanged: (value) {
          //             setState(() {
          //               _type = value;
          //             });
          //           },
          //         ),
          //         title: const Text(
          //           "Student",
          //           style: TextStyle(
          //             color: Colors.black87,
          //             fontSize: 14,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: ListTile(
          //         leading: Radio<ProfileType>(
          //           value: ProfileType.professional,
          //           groupValue: _type,
          //           onChanged: (value) {
          //             setState(() {
          //               _type = value;
          //             });
          //           },
          //         ),
          //         title: const Text(
          //           "Professional",
          //           style: TextStyle(
          //             color: Colors.black87,
          //             fontSize: 14,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 20),
          // buildExtension(),
          SizedBox(height: 20),
          FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: saveProfile,
              child: Text('Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )))
        ],
      ),
    );
  }

  void saveProfile() async {
    final supabase = Supabase.instance.client;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newStudent = Student(
      id: widget.student.id,
      firstName: firstNameCon.text,
      middleName: widget.student.middleName,
      lastName: lastNameCon.text,
      email: emailCon.text,
      contactNumber: conactCon.text,
      uuid: widget.student.uuid,
    );

    if (_type == ProfileType.student) {
      /*
      school: schoolCon.text,
      course: courseCon.text,
      yearLevel: int.parse(yearLevelCon.text),
      */
      newStudent.school = schoolCon.text;
      newStudent.course = courseCon.text;
      newStudent.yearLevel = int.parse(yearLevelCon.text);
    } else if (_type == ProfileType.professional) {
      /*
      office: officeCon.text,
      designation: designationCon.text,
      */
      newStudent.office = officeCon.text;
      newStudent.designation = designationCon.text;
    }
    final uuid = supabase.auth.currentSession!.user.id;

    await supabase.from('student').update(newStudent.toJson()).eq('uuid', uuid);

    Navigator.pop(context, true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  studentExtension() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
          child: CupertinoTextFormFieldRow(
        prefix: const Row(
          children: [
            Text("School",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            SizedBox(width: 12),
          ],
        ),
        placeholder: 'e.g. Ateneo de Naga University',
        placeholderStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black45,
        ),
        controller: schoolCon,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'Please enter name of School';
        //   }
        //   return null;
        // },
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      )),
      Flexible(
          child: CupertinoTextFormFieldRow(
        prefix: const Row(
          children: [
            Text("Course",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            SizedBox(width: 12),
          ],
        ),
        placeholder: 'e.g. BS Information Technology',
        placeholderStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black45,
        ),
        controller: courseCon,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'Please enter course';
        //   }
        //   return null;
        // },
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      )),
      Flexible(
          child: CupertinoTextFormFieldRow(
        prefix: const Row(
          children: [
            Text("Year Level",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            SizedBox(width: 12),
          ],
        ),
        placeholder: 'e.g. 1',
        placeholderStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black45,
        ),
        controller: yearLevelCon,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ))
    ]);
  }

  professionalExtension() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
          child: CupertinoTextFormFieldRow(
        prefix: const Row(
          children: [
            Text("Office",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            SizedBox(width: 12),
          ],
        ),
        placeholder: 'e.g. ICTC',
        placeholderStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black45,
        ),
        controller: officeCon,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'Please enter name of Office';
        //   }
        //   return null;
        // },
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      )),
      Flexible(
          child: CupertinoTextFormFieldRow(
        prefix: const Row(
          children: [
            Text("Designation",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            SizedBox(width: 12),
          ],
        ),
        placeholder: 'e.g. Software Developer',
        placeholderStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black45,
        ),
        controller: designationCon,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'Please enter designation';
        //   }
        //   return null;
        // },
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ))
    ]);
  }

  buildExtension() {
    if (_type == ProfileType.student) {
      return studentExtension();
    } else if (_type == ProfileType.professional) {
      return professionalExtension();
    } else {
      return Container();
    }
  }
}
