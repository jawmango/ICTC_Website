import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:ICTC_Website/widgets/forms/loginFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final TextEditingController emailCon = TextEditingController(),
  //     passwordCon = TextEditingController();
  // final formKey = GlobalKey<FormState>();

  // Future<void> login() async {
  //   await Supabase.instance.client.auth
  //       .signInWithPassword(email: emailCon.text, password: passwordCon.text)
  //       .then((value) {
  //     if (value.session?.user != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Successfully logged in!")));

  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => MainApp(),
  //           ));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Invalid email and/or password!")));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/images/svg_logo.svg';
    Widget getSVGImage(String assetName) {
      final Widget companyLogo =
          SvgPicture.asset(assetName, semanticsLabel: 'Ateneo ICTC Logo');
      return companyLogo;
    }

    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ads
              // Column(
              //   children: [
              //     buildAds(context),
              //   ],
              // ),
              // Signin
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildBody(context),
                ],
              ),
            ],
          ),
          FooterWidget(),
        ],
      )),
    );
  }

Widget buildAds(context) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.4,
      // height: MediaQuery.sizeOf(context).height * 0.8,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).height * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/ads1.jpg',
                        fit: BoxFit.cover,
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
  );
}

Widget buildBody(context) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.4,
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 35, bottom: 30),
                    child: Image(
                        image: AssetImage("assets/images/logo_ictc.png"),
                        height: 100),
                  ),
                  const Text(
                    "Log in to Ateneo ICTC",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: LoginWidget()),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  // Form buildForm() {
  //   return Form(
  //       key: formKey,
  //       child: Column(
  //         children: [
  //           TextFormField(
  //             controller: emailCon,
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return "Enter an email address";
  //               }

  //               if (!EmailValidator.validate(value)) {
  //                 return "Enter a valid email address";
  //               }

  //               return null;
  //             },
  //             onChanged: (_) => formKey.currentState!.validate(),
  //             keyboardType: TextInputType.emailAddress,
  //             style: TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w400,
  //                 color: Colors.black),
  //             decoration: const InputDecoration(
  //               border: OutlineInputBorder(),
  //               prefixIcon: Icon(
  //                 Icons.email_rounded,
  //                 color: Colors.black54,
  //                 size: 20,
  //               ),
  //               labelText: "Email",
  //               labelStyle: TextStyle(color: Colors.black54, fontSize: 12),
  //               floatingLabelStyle: TextStyle(
  //                 color: Colors.black54,
  //                 fontSize: 16,
  //               ),
  //               contentPadding:
  //                   EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           TextFormField(
  //             controller: passwordCon,
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return "Enter a password";
  //               }

  //               if (value.length < 6) {
  //                 return "Password must be at least 6 characters";
  //               }

  //               return null;
  //             },
  //             onChanged: (_) => formKey.currentState!.validate(),
  //             onFieldSubmitted: (_) => login(),
  //             style: TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w400,
  //                 color: Colors.black),
  //             keyboardType: TextInputType.visiblePassword,
  //             obscureText: true,
  //             obscuringCharacter: '•',
  //             decoration: const InputDecoration(
  //               border: OutlineInputBorder(),
  //               prefixIcon: Icon(
  //                 Icons.key,
  //                 color: Colors.black54,
  //                 size: 20,
  //               ),
  //               labelText: "Password",
  //               labelStyle: TextStyle(color: Colors.black54, fontSize: 12),
  //               floatingLabelStyle: TextStyle(
  //                 color: Colors.black54,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               MaterialButton(
  //                   minWidth: 30,
  //                   onPressed: null,
  //                   hoverColor: Colors.transparent,
  //                   child: const Text(
  //                     "Forgot your password?",
  //                     style: TextStyle(
  //                         color: Color(0xff153faa),
  //                         fontWeight: FontWeight.w400,
  //                         decoration: TextDecoration.underline),
  //                   )),
  //             ],
  //           ),
  //           const SizedBox(height: 12),
  //           InkWell(
  //             customBorder: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             // hoverColor: const Color(0xff153faa).withOpacity(0.8),
  //             // highlightColor: const Color(0xff153faa).withOpacity(0.4),
  //             // splashColor: const Color(0xff153faa).withOpacity(1),
  //             onTap: login,
  //             child: Container(
  //               alignment: Alignment.center,
  //               padding: const EdgeInsets.symmetric(vertical: 8),
  //               width: 350,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(35),
  //                 // adding color will hide the splash effect
  //                 color: const Color(0xff153faa),
  //               ),
  //               child: const Text(
  //                 "Log in",
  //                 style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ));
  //}
}
