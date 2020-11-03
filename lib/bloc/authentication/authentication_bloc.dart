import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:instamatch/bloc/authentication/authentication_state.dart';
import 'package:instamatch/repositories/userRepository.dart';
import 'authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository}):assert(userRepository != null),
        _userRepository = userRepository;



  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted){
      yield* _mapStarted();
    } else if (event is LoggedIn) {
      yield* _mapLoggingIn();
    } else if (event is LoggedOut) {
      yield* _mapLoggingOut();
    }
  }

  Stream<AuthenticationState> _mapLoggingIn() async* {
    final isFirstTime = await _userRepository.isFirstTime(await _userRepository.getUser());

    if(!isFirstTime){
      yield AuthenticatedButNotSet(await _userRepository.getUser());
    } else{
      yield Authenticated(await _userRepository.getUser());
    }
  }

  Stream<AuthenticationState> _mapStarted() async* {
    try{
      final isSignedIn = await _userRepository.isSignedIn();
      if(isSignedIn) {
        final uid = await _userRepository.getUser();
        final isFirstTime = await _userRepository.isFirstTime(uid);

        if(!isFirstTime) {
          yield AuthenticatedButNotSet(uid);
        } else {
          yield Authenticated(uid);
        }
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
      print(_);
    }
  }

  Stream<AuthenticationState> _mapLoggingOut() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}

