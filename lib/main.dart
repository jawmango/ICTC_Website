import 'package:ICTC_Website/pages/auth/forgot_pass.dart';
import 'package:ICTC_Website/pages/auth/login_page.dart';
import 'package:ICTC_Website/pages/auth/reset.dart';
import 'package:ICTC_Website/pages/auth/signup_page.dart';
import 'package:ICTC_Website/pages/desktop/about.dart';
import 'package:ICTC_Website/pages/desktop/home.dart';
import 'package:ICTC_Website/pages/desktop/morePrograms.dart';
import 'package:ICTC_Website/pages/desktop/profile/profile_page.dart';
import 'package:ICTC_Website/pages/mobile/home.dart';
import 'package:ICTC_Website/pages/desktop/programs/google_certified_educators.dart';
import 'package:ICTC_Website/pages/desktop/programs/microcredentials.dart';
import 'package:ICTC_Website/pages/desktop/programs/skillup.dart';
import 'package:ICTC_Website/supabase_options.dart';
import 'package:ICTC_Website/widgets/programPage.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseOptions.SUPABASE_URL,
    anonKey: SupabaseOptions.SUPABASE_ANON_KEY,
    debug: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ateneo ICTC',
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
          fontFamily: "Montserrat",
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff19306B),
              onPrimary: Color(0xFF19306B),
              onSecondary: Colors.white,
              onPrimaryContainer: const Color(0xff19306B),
              onSecondaryContainer: Colors.white),
          textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 64, fontWeight: FontWeight.w800, color: Colors.white),
            titleLarge: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w800,
                color: Color(0xffF9CE69)),
            labelMedium: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
            displayMedium: TextStyle(
                fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white),
            titleMedium: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Color(0xffF9CE69)),
            labelSmall: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
            bodyLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Color(0xff19306B)),
            bodyMedium: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          useMaterial3: true,
        ),

        routes: {
          '/': (context) => const HomeDesktopPage(),
          '/home': (context) => const HomeDesktopPage(),
          '/signup': (context) => const SignupPage(),
          '/login': (context) => const LoginPage(),
          '/about': (context) => const AboutPage(),
          '/profile': (context) => const ProfilePage(),
          '/programs': (context) => const ProgramPages(),
          '/microcredentials': (context) => const MicrocredentialsPage(),
          '/skillup': (context) => const SkillUpPage(),
          '/google_certified_educators': (context) =>
              const GoogleCertifiedEducatorsPage(),
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (BuildContext context) => HomeDesktopPage(),
      mobile: (BuildContext context) => HomeDesktopPage(),
      // tablet: (BuildContext context) => Container(color:Colors.yellow),
      // watch: (BuildContext context) => Container(color:Colors.purple),
    );
  }
}
