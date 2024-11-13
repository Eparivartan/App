import 'dart:async';
import 'package:careercoach/All%20About%20Engg/All%20About%20Engg.dart';
import 'package:careercoach/Dhyan/dhyan.dart';
import 'package:careercoach/Learn%20Assist/Industry%20Seminar.dart';
import 'package:careercoach/My%20Profile/AboutUs.dart';
import 'package:careercoach/My%20Profile/contact.dart';
import 'package:careercoach/Fresher%202%20Industry/Fresh2Indsty.dart';
import 'package:careercoach/Splash_Screen.dart';
import 'package:careercoach/demoregister.dart';
import 'package:careercoach/firebase_options.dart';
import 'package:careercoach/unit_converter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';
import 'All About Engg/Codes And Standards.dart';
import 'All About Engg/Engineering Basics.dart';
import 'All About Engg/Engineering Branches.dart';
import 'All About Engg/Engineering Glossary.dart';
import 'Ask Our Experts/ask_our_experts_query_form.dart';
import 'Calculator/calculator.dart';
import 'College Information/college_information.dart';
import 'Dhyan/contact.dart';
import 'Dhyan/courses.dart';
import 'Dhyan/demo_videos1.dart';
import 'Dhyan/gallery.dart';
import 'Dhyan/reviews.dart';
import 'For Professionals/Professional.dart';
import 'Interview Prep/MockTestMCQ.dart';
import 'Interview Prep/TechQues.dart';
import 'Interview Prep/interviewPrep.dart';
import 'Interview Prep/interviewtype.dart';
import 'Interview Prep/mockTest.dart';
import 'JobOpp.dart';
import 'Learn Assist/External Training Videos.dart';
import 'Learn Assist/Guest Lectures.dart';
import 'Learn Assist/learn_assist.dart';
import 'Learn Assist/question_paper.dart';
import 'Learn Assist/reference _text_books.dart';
import 'My Profile/Profile.dart';
import 'My Profile/my_activity.dart';
import 'My Profile/subscription.dart';
import 'New/Online Courses.dart';
import 'Software_in_use.dart';
import 'package:flutter/services.dart';
import 'Technology_Trends.dart';
import 'calculator.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

late String routeToGo = '/';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // firebase notifications
 


// end of Checking initial message from Firebase

  getToken() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();
    String? token1 = await FirebaseMessaging.instance.getToken();
    setState(() {
      token1 = token1;
    });
    debugPrint("token 1" + token1!);
    debugPrint("settings:" + settings.toString());
  }

  void initState() {
   
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return OverlaySupport.global(
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            // '/': (context) => MockTestScreen(),
            '/Dhyan': (context) => const MyHomePage(),
            '/Courses Offered': (context) => const courses(),
            '/Demo Videos': (context) => const DemoVideo(),
            '/Gallery': (context) => const Gallery(),
            '/Reviews': (context) => const Review(),
            '/Contact Dhyan': (context) => const ContactUs(),
            '/aboutus': (context) => const AboutUs(),
            '/profile': (context) => const MyProfile(),
            '/contactus': (context) => const Contact(),
            '/College_Information': (context) => const CollegeInformation(),
            '/All_About_Engineering': (context) => const AllAboutEngineers(),
            '/GetProfileScreen':(context) =>  GetProfileScreen(),
            '/Engineering_Branches': (context) => EngineeringBranches(
                  mode: 0,
                  index1: '',
                ),
            '/Engineering_Basics': (context) => const EngineeringBasics(),
            '/Engineering_Glossary': (context) => const EngineeringGlossary(),
            '/Codes_and_Standards': (context) => const CodesAndStandards(),
            '/Online_Courses': (context) => const OnlineCourses(),
            '/Interview_Prep': (context) => const InterviewPrep(),
            '/interviewtype': (context) => const InterviewType(),
            '/TechQues': (context) => const TechQuestions(),
            '/MockTest': (context) => const MockTest(),
            '/Softwares_in_Use_n_Commands': (context) => const SoftwareInUse(),
            '/Fresher_2_Industry': (context) => const Fresh2Ind(),
            '/For_Professionals': (context) => const Professionals(),
            '/Learn_Assist': (context) => const LearnAssist(),
            '/ExternalTrainingVideos': (context) =>
                const ExternalTrainingVideos(),
            '/IndustrySeminars': (context) => const IndustrySeminars(),
            '/GuestLectures': (context) => const GuestLecture(),
            '/QuestionPapers': (context) => const Question_Paper(),
            '/ReferenceTextBooks': (context) => const ReferenceTextBooks(),
            '/Ask_Our_Experts': (context) => const ExpertsQuery(),
            '/Job_Oppurtunities': (context) => const JobOppurtunities(),
            '/Technology_Trends': (context) => const TechnologyTrends(),
            '/Unit_Converter': (context) => Converter(),
            // '/Unit_Converter': (context) => UnitConverter(),
            // '/AutoCAD_ViewerEditor' : (context) => const AutoCadEditor(),
            '/Calculator': (context) => ScientificCalculator(),
            '/activity': (context) => const My_Activity(),
            '/subscriptions': (context) => const Subscriptions(),
          },
          //home: AllAboutEngineers(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}

class PushNotification {
  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });
}

class NotificationsBadge extends StatelessWidget {
  final int totalNotifications;
  const NotificationsBadge({Key? key, required this.totalNotifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration:
          const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            '$totalNotifications',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
