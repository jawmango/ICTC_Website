import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailCon = TextEditingController(),
      passwordCon = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    await Supabase.instance.client.auth
        .signInWithPassword(email: emailCon.text, password: passwordCon.text)
        .then((value) {
      if (value.session?.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Successfully logged in!")));

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid email and/or password!")));
      }
    }).onError((AuthException e, _) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
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
              onChanged: (_) => formKey.currentState!.validate(),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: Colors.black54,
                  size: 20,
                ),
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.black54, fontSize: 12),
                floatingLabelStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            ),
            const SizedBox(height: 12),
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
              onFieldSubmitted: (_) => login(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              obscuringCharacter: '•',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.key,
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
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                    minWidth: 30,
                    onPressed:  () => Navigator.pushNamed(context, '/passwordrecovery'),
                    hoverColor: Colors.transparent,
                    child: const Text(
                      "Forgot your password?",
                      style: TextStyle(
                          color: Color(0xff153faa),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    )),
              ],
            ),
            const SizedBox(height: 1),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hoverColor: const Color(0xff153faa).withOpacity(0.8),
              // highlightColor: const Color(0xff153faa).withOpacity(0.4),
              // splashColor: const Color(0xff153faa).withOpacity(1),
              onTap: login,
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
                  "Log in",
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
