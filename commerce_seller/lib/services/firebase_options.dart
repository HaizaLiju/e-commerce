import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid
    ? const FirebaseOptions(
        apiKey: "AIzaSyDMG-QkVPyvdACwK4AY5ZMSjevH51i92U0",
        appId: "1:1050963863918:android:ca22b7894d3b41bc4bb97f",
        messagingSenderId: "1050963863918",
        projectId: "authentication-603e3",
        storageBucket: "authentication-603e3.appspot.com")
    : const FirebaseOptions(
        apiKey: "AIzaSyCwMBUda4lsdwYa4O8OhJBF5mPCpu4eqWo",
        appId: "1:1050963863918:ios:f20558b258a413194bb97f",
        messagingSenderId: "1050963863918",
        projectId: "authentication-603e3",
      );
