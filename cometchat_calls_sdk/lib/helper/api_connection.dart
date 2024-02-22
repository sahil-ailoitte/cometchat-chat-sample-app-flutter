import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../helper/cometchatcalls_exception.dart';
import '../helper/cometchatcalls_utils.dart';
import '../model/call_log_filter_params.dart';
import '../model/header_obj.dart';
import '../builder/call_app_settings_request.dart';
import '../model/generate_token.dart';

class ApiConnection {
  //API
  final String _tag = "ApiConnection";
  final String _keyHttps = "https://";
  final String _callBaseUrl = "%appId.call-%region.cometchat.io";
  final String _apiVersion = "v3.0";
  final String _urlCallToken = "/call_tokens";
  final String _urlCallLogs = "/calls";

  //Header
  final String _contentType = "Content-Type";
  final String _accept = "Accept";
  final String _authToken = "authToken";
  final String _callToken = "callToken";
  
  static CallAppSettings? callAppSettings;

  ///Generate Token API Call
  void generateToken(
      GenerateToken obj,
      String authToken,
      Function(String onSuccess) onSuccess,
      Function(CometChatCallsException excep) onError
  ) async {
    final response = await createPOST(getApiUrl(_urlCallToken), getDefaultHeaders(authToken, null), null, jsonEncode(obj));
    handleResponse(response, onSuccess, onError);
  }

  ///Get Call Logs List
  void getCallLogList(
      CallLogFilterParams params,
      String authToken,
      Function(String onSuccess) onSuccess,
      Function(CometChatCallsException excep) onError
  ) async {
    final response = await createGET(getApiUrl(_urlCallLogs), getDefaultHeaders(authToken, null), params.toMap());
    handleResponse(response, onSuccess, onError);
  }

  ///Get Call Details
  void getCallDetails(
      String sessionID,
      String authToken,
      Function(String onSuccess) onSuccess,
      Function(CometChatCallsException excep) onError
  ) async {
    final response = await createGET(getApiUrl("$_urlCallLogs/$sessionID"), getDefaultHeaders(authToken, null), null);
    handleResponse(response, onSuccess, onError);
  }


  String getApiUrl(String url) {
    String urlPrefix;
    if (callAppSettings!.host != null) {
      urlPrefix = _keyHttps + callAppSettings!.host! + url;
    } else {
      urlPrefix = "$_keyHttps${_callBaseUrl.replaceAll("%appId", callAppSettings!.appId!).replaceAll("%region", callAppSettings!.region!)}/$_apiVersion$url";
    }
    return urlPrefix;
  }

  Map<String, String> getDefaultHeaders(String? authToken, String? callToken) {
    List<HeaderObj> headerListObj = [];
    headerListObj.add(HeaderObj(_contentType, "application/json"));
    headerListObj.add(HeaderObj(_accept, "application/json"));
    if (authToken != null ) {
      headerListObj.add(HeaderObj(_authToken, authToken));
    }
    if (callToken != null ) {
      headerListObj.add(HeaderObj(_callToken, callToken));
    }
    return Map.fromEntries(headerListObj.map((value) => MapEntry(value.key, value.value)));
  }

  Future<http.Response> createGET(String url, Map<String, String> headers, Map<String, String>? queryParameters) async{
    CometChatCallsUtils.showLog(_tag, "createGET => url: $url --- queryParameters: $queryParameters --- headers: $headers");
    if(await CometChatCallsUtils.checkNetwork()){
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      final response = await http.get(
          uri,
          headers: headers
      );
      return response;
    }
    final noInternetResponse = http.Response("No Internet connection", 503);
    return noInternetResponse;
  }

  Future<http.Response> createPOST(String url, Map<String, String> headers, Map<String, String>? queryParameters, String? request) async{
    CometChatCallsUtils.showLog(_tag, "createPOST => url: $url --- headers: $headers --- body: $request");
    if(await CometChatCallsUtils.checkNetwork()){
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      final response = await http.post(
          uri,
          headers: headers,
          body: request
      );
      return response;
    }
    final noInternetResponse = http.Response("No Internet connection", 503);
    return noInternetResponse;
  }

  void handleResponse(
      Response response,
      Function(String onSuccess) onSuccess,
      Function(CometChatCallsException excep) onError
  ){
    if(response.statusCode == 200){
      onSuccess(response.body);
    }else{
      onError(CometChatCallsException("ERROR", "Api error code: ${response.statusCode}", response.body));
    }
  }
}
