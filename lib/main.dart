import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foda_admin/services/get_it.dart';
import 'package:foda_admin/utils/common.dart';

import 'app.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBUqgWpqRJKs80KWetM8Tb6uPyIdre_lZ0",
        authDomain: "casanovo-e6a80.firebaseapp.com",
        databaseURL: "https://casanovo-e6a80.firebaseio.com",
        projectId: "casanovo-e6a80",
        storageBucket: "casanovo-e6a80.appspot.com",
        messagingSenderId: "218014340651",
        appId: "1:218014340651:web:212f7a9ea98cc4f751fc6e",
        measurementId: "G-Q0E3HY4JXT",
      ),
    );

    GetItService.initializeService();
    runApp(const FodaAdmin());
  }, (error, stack) => fodaPrint(error));
}
