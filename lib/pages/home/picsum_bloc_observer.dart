import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PicsumBlocObserver extends BlocObserver{
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint("onEvent ==> $event");
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint("onError ==> $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint("onTransition ==> $transition");
    super.onTransition(bloc, transition);
  }
}