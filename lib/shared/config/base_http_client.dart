import 'dart:convert';
import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../constants/hive.dart';
import '../constants/urls.dart';
import 'utils/get_token.dart';

class BaseHttpClient {
  static final client = http.Client();
  static Map<String, String> getDefaultHeader({bool haveToken = true}) {
    final token = getToken();
    return token != null && haveToken
        ? {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }
        : {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          };
  }

  static Future<String?> get(String api,
      {bool haveToken = true, Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(
      url,
      headers: headers ??
          getDefaultHeader(
            haveToken: haveToken,
          ),
    );
    if (response.statusCode < 300) {
      return utf8.decode(
        response.bodyBytes,
      );
    } else {
      if (jsonDecode(utf8.decode(
            response.bodyBytes,
          ))['code'] ==
          'token_not_valid') {
        await refreshToken();
        if (getToken() != null) {
          return await get(
            api,
            headers: headers,
          );
        }
      }
      log(
        'BaseClient.get in $api: ${utf8.decode(
          response.bodyBytes,
        )}',
      );
    }
    return null;
  }

  static Future<Response> getBody(String api,
      {bool haveToken = true, Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(
      url,
      headers: headers ?? getDefaultHeader(haveToken: haveToken),
    );
    return response;
  }

  static Future<Response> postBody(String api, dynamic object,
      {bool haveToken = true, Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + api);
    var payload = jsonEncode(object);
    var response = await client.post(
      url,
      body: payload,
      headers: headers ??
          getDefaultHeader(
            haveToken: haveToken,
          ),
    );
    return response;
  }

  static Future<dynamic> refreshToken() async {
    var url = Uri.parse('http://167.99.246.103:8081/api/v1/users/token/refresh/');
    final box = Hive.box(
      HiveStrings.userBox,
    );
    if (!box.containsKey(
      HiveStrings.refreshToken,
    )) return;
    var response = await client.post(
      url,
      headers: getDefaultHeader(),
      body: jsonEncode(
        {
          'refresh': box.get(
            HiveStrings.refreshToken,
          ),
        },
      ),
    );
    if (response.statusCode < 300) {
      final token = jsonDecode(
        utf8.decode(
          response.bodyBytes,
        ),
      )['access'];
      final refresh = jsonDecode(
        utf8.decode(
          response.bodyBytes,
        ),
      )['refresh'];
      box.put(
        HiveStrings.token,
        token,
      );
      box.put(
        HiveStrings.refreshToken,
        refresh,
      );
    } else {
      box.put(HiveStrings.token, null);
      box.put(HiveStrings.refreshToken, null);
      log(
        'BaseClient.refreshToken in: ${utf8.decode(
          response.bodyBytes,
        )}',
      );
    }
  }

  static Future<Response?> post(
    String api,
    dynamic object, {
    bool haveToken = true,
    Map<String, String>? headers,
    Function? onError,
  }) async {
    var url = Uri.parse(baseUrl + api);
    var payload = jsonEncode(object);
    var response = await client.post(
      url,
      body: payload,
      headers: headers ?? getDefaultHeader(haveToken: haveToken),
    );
    log(response.body.toString());
    if (response.statusCode < 300) {
      return response;
    } else {
      if (onError != null) onError(response);
      if (jsonDecode(
            utf8.decode(
              response.bodyBytes,
            ),
          )['code'] ==
          'token_not_valid') {
        await refreshToken();
        if (getToken() != null) {
          return await post(
            api,
            object,
            headers: headers,
            onError: onError,
          );
        }
      }
      log(
        'BaseClient.post: ${utf8.decode(
          response.bodyBytes,
        )}',
      );
    }
    return null;
  }

  ///PUT Request
  static Future<String?> put(
    String api,
    dynamic object, {
    bool haveToken = true,
    Map<String, String>? headers,
  }) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);

    var response = await client.put(
      url,
      body: payload,
      headers: headers ?? getDefaultHeader(haveToken: haveToken),
    );
    if (response.statusCode < 300) {
      return utf8.decode(
        response.bodyBytes,
      );
    } else {
      if (jsonDecode(
            utf8.decode(
              response.bodyBytes,
            ),
          )['code'] ==
          'token_not_valid') {
        await refreshToken();
        if (getToken() != null) {
          return await put(
            api,
            object,
            headers: headers,
          );
        }
      }
      log(
        'BaseClient.put: ${utf8.decode(
          response.bodyBytes,
        )}',
      );
    }
    return null;
  }

  ///PUT Request
  static Future<Response?> putResponse(
    String api,
    dynamic object, {
    bool haveToken = true,
    Map<String, String>? headers,
    Function? onError,
  }) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);

    var response = await client.put(
      url,
      body: payload,
      headers: headers ?? getDefaultHeader(haveToken: haveToken),
    );
    if (response.statusCode < 300) {
      return response;
    } else {
      if (onError != null) onError(response);
      if (jsonDecode(
            utf8.decode(
              response.bodyBytes,
            ),
          )['code'] ==
          'token_not_valid') {
        await refreshToken();
        if (getToken() != null) {
          return await putResponse(
            api,
            object,
            headers: headers,
          );
        }
      }
      log(
        'BaseClient.put: ${utf8.decode(
          response.bodyBytes,
        )}',
      );
    }
    return null;
  }

  static Future<dynamic> patch(
    String api,
    dynamic object, {
    bool haveToken = true,
    Map<String, String>? headers,
  }) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);

    var response = await client.patch(
      url,
      body: payload,
      headers: headers ?? getDefaultHeader(haveToken: haveToken),
    );
    if (response.statusCode < 300) {
      return utf8.decode(
        response.bodyBytes,
      );
    } else {
      if (jsonDecode(
            utf8.decode(
              response.bodyBytes,
            ),
          )['code'] ==
          'token_not_valid') {
        await refreshToken();
        if (getToken() != null) {
          return await patch(
            api,
            object,
            headers: headers,
          );
        }
      }
      log(
        'BaseClient.patch: ${utf8.decode(
          response.bodyBytes,
        )}',
      );
    }
  }

  static Future<dynamic> delete(
    String api, {
    bool haveToken = true,
    Map<String, String>? headers,
  }) async {
    var url = Uri.parse(baseUrl + api);

    var response = await client.delete(
      url,
      headers: headers ?? getDefaultHeader(haveToken: haveToken),
    );
    if (response.statusCode < 300) {
      return utf8.decode(
        response.bodyBytes,
      );
    } else {
      if (jsonDecode(
            utf8.decode(
              response.bodyBytes,
            ),
          )['code'] ==
          'token_not_valid') {
        await refreshToken();
        if (getToken() != null) {
          return await delete(
            api,
            headers: headers,
          );
        }
      }
      log(
        'BaseClient.delete: ${utf8.decode(
          response.bodyBytes,
        )}',
      );
    }
  }
}
