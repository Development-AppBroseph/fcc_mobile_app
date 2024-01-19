import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/fcc_settings/data/datasources/content_types.dart';
import 'package:fcc_app_front/shared/config/base_http_client.dart';
part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(const ContentState(<ContentTypeEnum, String>{}));
  dynamic load() async {
    Map<ContentTypeEnum, String> contents = <ContentTypeEnum, String>{};
    for (ContentTypeEnum type in ContentTypeEnum.values) {
      try {
        final String? content = await BaseHttpClient.get(
          'api/v1/content/${contentList[type.name]}/',
          haveToken: false,
        );
        if (content != null) {
          contents.addEntries(
            <MapEntry<ContentTypeEnum, String>>[
              MapEntry(
                type,
                jsonDecode(content)['text'],
              ),
            ],
          );
        }
      } catch (e) {
        log("Couldn't get the content ${type.name}: $e");
      }
    }
    emit(
      ContentState(contents),
    );
  }

  static Future<String> getData(ContentTypeEnum type) async {
    try {
      final String? content = await BaseHttpClient.get(
        'api/v1/content/${contentList[type.name]}/',
        haveToken: false,
      );
      if (content != null) {
        return jsonDecode(content)['text'];
      }
    } catch (e) {
      log("Couldn't get the content ${type.name}: $e");
    }
    return '';
  }

  Future<String> getContent(ContentTypeEnum type) async {
    return super.state.contents[type] ?? await getData(type);
  }
}
