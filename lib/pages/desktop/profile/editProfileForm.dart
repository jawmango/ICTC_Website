import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ICTC_Website/models/student.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

enum ProfileType { student, professional }

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController firstNameController,
      lastNameController,
      contactController,
      emailController;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: widget.student.firstName);
    lastNameController = TextEditingController(text: widget.student.lastName);
    contactController = TextEditingController(text: widget.student.contactNumber);
    emailController = TextEditingController(text: widget.student.email);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Profile Information',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]), // Adjust label font size and color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            style: TextStyle(fontSize: 14, color: Colors.black), // Adjust input text font size and color
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            style: TextStyle(fontSize: 14, color: Colors.black),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            style: TextStyle(fontSize: 14, color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter an email address";
              }

              if (!EmailValidator.validate(value)) {
                return "Enter a valid email address";
              }

              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: contactController,
            decoration: InputDecoration(
              labelText: 'Contact Number',
              labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            style: TextStyle(fontSize: 14, color: Colors.black),
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your contact number';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: saveProfile,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Color(0xff19306B),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
      firstName: firstNameController.text,
      middleName: widget.student.middleName,
      lastName: lastNameController.text,
      email: emailController.text,
      contactNumber: contactController.text,
      uuid: widget.student.uuid,
    );

    final uuid = supabase.auth.currentSession!.user.id;

    await supabase.from('student').update(newStudent.toJson()).eq('uuid', uuid);

    Navigator.pop(context, true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
