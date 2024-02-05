import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('Bloc ${bloc.runtimeType} emitted event $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('Bloc ${bloc.runtimeType} state changed to $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('Bloc ${bloc.runtimeType} transitioned to $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('Error in Bloc ${bloc.runtimeType}: $error\n$stackTrace');
  }
}
