import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instamatch/bloc/blocDelegate.dart';
import 'package:instamatch/ui/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instamatch/ui/pages/splash.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(App());
}

//TODO: EXTRA FIREBASE CODES!
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Splash();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Home();
        }
        return Splash();
      },
    );
  }
}