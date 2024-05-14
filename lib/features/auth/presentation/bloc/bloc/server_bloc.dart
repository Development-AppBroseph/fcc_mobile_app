import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/shared/config/base_http_client.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  ServerBloc() : super(ServerOnline()) {
    on<CheckServerEvent>(_checkServerState);
  }

  Future<void> _checkServerState(
    CheckServerEvent event,
    Emitter<ServerState> emit,
  ) async {
    final String? response = await BaseHttpClient.get('settings/public/status/',
    );

    if (response!.contains('on')) {
      emit(ServerOnline());
    } else {
      emit(ServerOffline());
    }
  }
}
