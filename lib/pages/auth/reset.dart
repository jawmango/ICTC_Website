import 'package:ICTC_Website/main.dart';
import 'package:ICTC_Website/pages/auth/login_page.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  late final TextEditingController emailCon, passwordCon, confirmCon;
  final formKey = GlobalKey<FormState>();

  // resetPass() async {
  //   // TODO: sign up backend functionality
    
  // }

  @override
  void initState() {
    emailCon = TextEditingController();
    passwordCon = TextEditingController();
    confirmCon = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 30),
          buildBody(context),
          FooterWidget(),
        ],
      )),
    );
  }

  Widget buildBody(context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 450,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 35, bottom: 30),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/logo_ictc.png"),
                                      height: 100),
                                ),
                                const Text(
                                  "Create an Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                buildForm(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Expanded(child: Divider()),
                                        Text("     or     "),
                                        Expanded(child: Divider()),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            // TextFormField(
            //   controller: emailCon,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return "Enter an email address";
            //     }

            //     if (!EmailValidator.validate(value)) {
            //       return "Enter a valid email address";
            //     }

            //     return null;
            //   },
            //   onChanged: (_) => formKey.currentState!.validate(),
            //   keyboardType: TextInputType.emailAddress,
            //   style: TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w400,
            //       color: Colors.black),
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     prefixIcon: Icon(
            //       Icons.email_rounded,
            //       color: Colors.black54,
            //       size: 20,
            //     ),
            //     labelText: "E-mail",
            //     labelStyle: TextStyle(color: Colors.black54, fontSize: 12),
            //     floatingLabelStyle: TextStyle(
            //       color: Colors.black54,
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 12),
            TextFormField(
              controller: passwordCon,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a password";
                }

                if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }

                return null;
              },
              onChanged: (_) => formKey.currentState!.validate(),
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              obscureText: true,
              obscuringCharacter: '•',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.key_rounded,
                  color: Colors.black54,
                  size: 20,
                ),
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.black54, fontSize: 12),
                floatingLabelStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: confirmCon,
              validator: (value) {
                if (value != passwordCon.text) {
                  return "Passwords do not match";
                }

                return null;
              },
              onChanged: (value) => formKey.currentState!.validate(),
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              // onFieldSubmitted: (_) => state.register(),
              obscureText: true,
              obscuringCharacter: '•',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.password_rounded,
                  color: Colors.black54,
                  size: 20,
                ),
                labelText: "Confirm Password",
                labelStyle: TextStyle(color: Colors.black54, fontSize: 12),
                floatingLabelStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hoverColor: const Color(0xff153faa).withOpacity(0.8),
              // highlightColor: const Color(0xff153faa).withOpacity(0.4),
              // splashColor: const Color(0xff153faa).withOpacity(1),
              onTap: () async{if (formKey.currentState!.validate()) {
          final supabase =
          Supabase.instance.client; // Send password reset request to Supabase
      final UserResponse res = await supabase.auth.updateUser(
        UserAttributes(
          // email: emailCon.text,
          password: passwordCon.text,
        ),
      );
      final User? updatedUser = res.user;

      // Check response and handle accordingly
      // if (response.error != null) {
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text('Error'),
      //       content: Text('Failed to send reset password email'),
      //       actions: <Widget>[
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('OK'),
      //         ),
      //       ],
      //     ),
      //   );
      // } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Password reset email sent successfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  // adding color will hide the splash effect
                  color: const Color(0xff153faa),
                ),
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
