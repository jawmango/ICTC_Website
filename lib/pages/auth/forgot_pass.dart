import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(600, 80, 600, 0),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 35, bottom: 30),
                    child: Image(
                        image: AssetImage(
                            "assets/images/logo_ictc.png"),
                        height: 100),
                  ),
                  const Text(
                      "Reset Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _emailController,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Use a regex for basic email validation
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              final supabase = Supabase.instance.client;
                              await supabase.auth.resetPasswordForEmail(
                                  _emailController.text.trim());

                              setState(() {
                                _isLoading = false;
                              });

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Success'),
                                  content:
                                      Text('Password reset email sent successfully'),
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
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color(0xff153faa)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(350, 50)),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          )
                        : Text(
                            'Send Reset Email',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
            // if (_isLoading)
            //   Center(
            //     child: CircularProgressIndicator(),
            //   ),
          ],
        ),
      ),
    );
  }
}
