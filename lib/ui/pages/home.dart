import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instamatch/bloc/authentication/authentication_bloc.dart';
import 'package:instamatch/bloc/authentication/authentication_event.dart';
import 'package:instamatch/repositories/userRepository.dart';
import 'package:instamatch/bloc/authentication/authentication_state.dart';
import 'package:instamatch/ui/pages/signUp.dart';
import 'package:instamatch/ui/widgets/tabs.dart';
import 'splash.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);

    _authenticationBloc.add(AppStarted());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return Splash();
            } else
              return SignUp(userRepository: _userRepository);
          },
        ),
      ),
    );
  }
}
