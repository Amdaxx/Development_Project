import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projectx/screens/passcode_screen.dart';
import 'firebase_options.dart';
import 'screens/auth_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings =
      InitializationSettings(iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
  );

  runApp(const App());
}

void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  // Handle notification tap or interaction
  print('Notification received: ${notificationResponse.payload}');
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenses Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground: Colors.black,
          primary: const Color(0xFF00B2E7),
          secondary: const Color(0xFFE064F7),
          tertiary: const Color(0XFFFF8D6C),
          outline: Colors.grey,
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TransactionNotifier(
              child: const PasscodeScreen(),
            );
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

class TransactionNotifier extends StatefulWidget {
  final Widget child;

  const TransactionNotifier({Key? key, required this.child}) : super(key: key);

  @override
  _TransactionNotifierState createState() => _TransactionNotifierState();
}

class _TransactionNotifierState extends State<TransactionNotifier> {
  int transactionCount = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('transactions').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final newTransactionCount = snapshot.data!.docs.length;
          if (newTransactionCount > transactionCount) {
            transactionCount = newTransactionCount;
            showNotification(transactionCount);
          }
        }
        return widget.child;
      },
    );
  }

  Future<void> showNotification(int transactionCount) async {
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(iOS: iOSPlatformChannelSpecifics);
    await Future.delayed(const Duration(seconds: 5)); // Add a delay of 5 seconds
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Transactions',
      'You have $transactionCount new transactions',
      platformChannelSpecifics,
    );
  }
}