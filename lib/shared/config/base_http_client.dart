import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:http/http.dart' as http;

class BaseHttpClient {
  static final http.Client client = http.Client();
  static Map<String, String> getDefaultHeader({bool haveToken = true}) {
    final String? token = getToken();
    return token != null && haveToken
        ? <String, String>{
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }
        : <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          };
  }

  static Future<String?> get(
    String api, {
    bool haveToken = true,
    Map<String, String>? headers,
  }) async {
    Uri url = Uri.parse(baseUrl + api);
    http.Response response = await client.get(
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

  static Future<Response> getBody(
    String api, {
    bool haveToken = true,
    Map<String, String>? headers,
  }) async {
    Uri url = Uri.parse(baseUrl + api);
    http.Response response = await client.get(
      url,
      headers: headers ?? getDefaultHeader(haveToken: haveToken),
    );
    return response;
  }

  static Future<Response> postBody(
    String api,
    dynamic object, {
    bool haveToken = true,
    Map<String, String>? headers,
  }) async {
    Uri url = Uri.parse(baseUrl + api);
    String payload = jsonEncode(object);
    http.Response response = await client.post(
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
    Uri url = Uri.parse('$baseUrl api/v1/users/token/refresh/');
    final Box box = Hive.box(
      HiveStrings.userBox,
    );
    if (!box.containsKey(
      HiveStrings.refreshToken,
    )) return;
    http.Response response = await client.post(
      url,
      headers: getDefaultHeader(),
      body: jsonEncode(
        <String, dynamic>{
          'refresh': box.get(
            HiveStrings.refreshToken,
          ),
        },
      ),
    );
    if (response.statusCode < 300) {
      final dynamic token = jsonDecode(
        utf8.decode(
          response.bodyBytes,
        ),
      )['access'];
      final dynamic refresh = jsonDecode(
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
    Uri url = Uri.parse(baseUrl + api);
    String payload = jsonEncode(object);
    http.Response response = await client.post(
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
    Uri url = Uri.parse(baseUrl + api);
    String payload = json.encode(object);

    http.Response response = await client.put(
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
    Uri url = Uri.parse(baseUrl + api);
    String payload = json.encode(object);

    http.Response response = await client.put(
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
    Uri url = Uri.parse(baseUrl + api);
    String payload = json.encode(object);

    http.Response response = await client.patch(
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
    Uri url = Uri.parse(baseUrl + api);

    http.Response response = await client.delete(
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
