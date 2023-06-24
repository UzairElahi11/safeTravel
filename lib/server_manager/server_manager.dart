import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:safe/Utils/url_constants.dart';

import '../Utils/app_util.dart';

typedef ResponseCompletion = void Function(String responseBody, bool success);

class ServerManager {
  static const int timeOutSeconds = 30;

  ServerManager._();
   static void callPostApi(String url, Map<String, String> headers,
      Map<String, dynamic> body, completion(String responseBody, bool success),
      {int timeout = timeOutSeconds}) {
    bool onCallDone = false;
    if (!url.startsWith("https")) {
      HttpClient httpClient = new HttpClient();
      httpClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
//      httpClient.idleTimeout = Duration(seconds: timeout);
//      httpClient.connectionTimeout = Duration(seconds: timeout);

      debugPrint(
          "url: " + url + " \nBody:" + (body == null ? "" : body.toString()));
      //TODO REMOVE THIS LATTER
      print("url: " + url + " \nBody:" + (body == null ? "" : body.toString()));
      try {
        httpClient.postUrl(Uri.parse(url)).then((request) {
          // if (headers != null) {
          //   if (TreatsConstants.hashWithSHASalt) {
          //     String hashWithSHASalt = createSaHA256(
          //         nonce1: json.encode(body) + TreatsConstants.ASR_Key);
          //     debugPrint('HeaderWithAuth' +
          //         hashWithSHASalt +
          //         "salt key" +
          //         TreatsConstants.ASR_Key);
          //     //TODO REMOVE THIS LATTER
          //     print('HeaderWithAuth' +
          //         hashWithSHASalt +
          //         "salt key" +
          //         TreatsConstants.ASR_Key);
          //     headers['requestAuth'] = hashWithSHASalt;
          //   }
          // List<String> keys = headers.keys.toList();
          // for (int i = 0; i < keys.length; i++) {
          //   request.headers.set(keys[i], headers[keys[i]]!);
          // }
          request.add(utf8.encode(json.encode(body)));
          print("---------${request.contentLength.toString()}");
          request.close().then((response) {
            response.transform(utf8.decoder).join().then((responseBody) {
              logResponse(url, {}, headers, responseBody, response.statusCode);

              if (response != null &&
                  response.statusCode == 200 &&
                  responseBody != null) {
                debugPrint("responce from server ${responseBody}");
                //TODO REMOVE THIS LATTER
                print("responce from server ${responseBody}");
                callCompletion(responseBody, true, completion);
                //   if (isResponseCodeForReLoginFromResponse(responseBody)) {
                //     if (Keys.mainNavigatorKey.currentContext != null &&
                //         body.containsKey("context") &&
                //         body["context"] ==
                //             UrlConstants.appServerContextAfterLogin) {}
                //   }
              } else {
                callCompletion(responseBody, false, completion);
              }
            });
          }).catchError((error) {
            if (error != null && error.runtimeType == String) {
              debugPrint("response: " + error ?? "");
              //TODO REMOVE THIS LATTER
              print("response: " + error ?? "");
            }
            print('error callback catch');
            if (onCallDone == false) {
              onCallDone = true;
              callCompletion(null, false, completion);
            }
          }).whenComplete(() {
            print("Api complete");
            // ignore: unnecessary_statements
          });
        }).catchError((error) {
          if (error != null && error.runtimeType == String) {
            debugPrint("response: " + error ?? "");
            //TODO REMOVE THIS LATTER
            print("response: " + error ?? "");
          }
          print('error callback catch');
          if (onCallDone == false) {
            onCallDone = true;
            callCompletion(null, false, completion);
          }
        });
      } catch (e) {
        if (e != null) {}
        callCompletion(null, false, completion);
        debugPrint('catch callback');
      } finally {
//        callCompletion(null, false, completion);
        debugPrint('catch callback finally');
      }
    } else {
      var client = http.Client();
      try {
        client
            .post(Uri.parse(url),
                body: body,
                headers: bearerToken != null
                    ? {
                        // HttpHeaders.contentTypeHeader: "application/json",
                        HttpHeaders.authorizationHeader: "Bearer $bearerToken"
                      }
                    : null)
            .timeout(Duration(seconds: timeout))
            .then((http.Response response) {
          onCallDone = true;
          debugPrint("internal reach");
          log(
              'Response Success $url ${body?.toString()} Header: ${headers?.toString() ?? ""}');
          if (response != null && response.statusCode == 200) {
            log("-------" + response.body.toString());
            callCompletion(response.body, true, completion);
          } else {
            debugPrint(
                "responce error code ${response.statusCode} responce code ${response.body}");
            callCompletion(response.body, false, completion);
          }
        }).catchError((Object error) {
          if (error != null && error.runtimeType == String) {
            debugPrint("response: error " + error.toString());
          }
          print('error callback catch ' + error.toString());
          if (onCallDone == false) {
            onCallDone = true;
            callCompletion(null, false, completion);
          }
        }).whenComplete(() {
          print("Api complete");
          // ignore: unnecessary_statements
          client.close;
        });
      } on Function catch (e, _) {
        if (e != null) {}
        callCompletion(null, false, completion);
        debugPrint('catch callback' + e.toString());
      }
    }
  }

  static void callCompletion(
      String? responseBody, bool success, ResponseCompletion completion) {
    if (responseBody != null && responseBody.runtimeType == String) {
    } else {
      debugPrint("Invalid response");
    }
    if (completion != null) {
      completion(responseBody!, success);
    }
  }

  static void getApiCalling(
      String url,
      Map<String, String> headers,
      Map<String, dynamic> body,
      Function(String responseBody, bool success) completion,
      {int timeout = timeOutSeconds}) {
    bool onCallDone = false;
    if (!url.startsWith("https")) {
      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
//      httpClient.idleTimeout = Duration(seconds: timeout);
//      httpClient.connectionTimeout = Duration(seconds: timeout);

      debugPrint("url: $url \nBody:$body : body.toString()");

      try {
        httpClient.postUrl(Uri.parse(url)).then((request) {
          request.add(utf8.encode(json.encode(body)));
          request.close().then((response) {
            response.transform(utf8.decoder).join().then((responseBody) {
              logResponse(url, {}, headers, responseBody, response.statusCode);

              if (response.statusCode == 200) {
                debugPrint("responce from server $responseBody");

                callCompletion(responseBody, true, completion);
              } else {
                callCompletion(responseBody, false, completion);
              }
            });
          }).catchError((error) {
            if (error != null && error.runtimeType == String) {
              debugPrint('response:   $error');
            }
            if (onCallDone == false) {
              onCallDone = true;
              callCompletion(null, false, completion);
            }
          }).whenComplete(() {});
        }).catchError((error) {
          if (error != null && error.runtimeType == String) {
            debugPrint("response:  $error");
          }
          if (onCallDone == false) {
            onCallDone = true;
            callCompletion(null, false, completion);
          }
        });
      } catch (e) {
        callCompletion(null, false, completion);
        debugPrint('catch callback');
      } finally {
        debugPrint('catch callback finally');
      }
    } else {
      var client = http.Client();
      try {
        client
            .get(Uri.parse(url), headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${bearerToken!}"
            })
            .timeout(Duration(seconds: timeout))
            .then((http.Response response) {
              onCallDone = true;
              log("internal reach");
              log('Response Success $url ${body.toString()} Header: ${headers.toString()}');
              if (response.statusCode == 200) {
                log("-------${response.body}");
                callCompletion(response.body, true, completion);
              } else {
                debugPrint(
                    "responce error code ${response.statusCode} responce code ${response.body}");
                callCompletion(response.body, false, completion);
              }
            })
            .catchError((Object error) {
              if (error.runtimeType == String) {
                debugPrint("response: error $error");
              }
              if (onCallDone == false) {
                onCallDone = true;
                callCompletion(null, false, completion);
              }
            })
            .whenComplete(() {
              client.close;
            });
      } on Function catch (e, _) {
        callCompletion(null, false, completion);
        debugPrint('catch callback$e');
      }
    }
  }

  static void logResponse(String url, Map<String, dynamic> body,
      Map<String, String> headers, String? responseBody, int? responseCode) {
    try {
      bool success = responseCode == 200;
      if (success) {
        debugPrint("\n✅✅✅ ------- Success Response Start ------- ✅✅✅ \n");
      } else {
        debugPrint("\n❌❌❌❌ ------- Failure Response Start ------- ❌❌❌❌\n\n");
      }
      debugPrint('Url::: $url');
      debugPrint('Headers::: ${headers.toString()}');
      debugPrint('Body::: $body');
      try {
        debugPrint(
            'API Response Code::: ${(responseCodeFromResponse(responseBody!) ?? "")}');
      } catch (e) {
        log(
          e.toString(),
        );
      }
      debugPrint('Response Code::: ${(responseCode?.toString() ?? "")}');
      debugPrint('Response::: ${responseBody!}');
      if (success) {
        debugPrint("\n✅✅✅ ------- Success Response End ------- ✅✅✅ \n");
      } else {
        debugPrint("\n❌❌❌❌ ------- Failure Response End ------- ❌❌❌❌\n\n");
      }
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }

  static String? responseCodeFromResponse(String responseBody) {
    try {
      dynamic content = AppUtil.decodeString(responseBody);
      if (content is Map) {
        return responseCode(content);
      }
    } on Exception {
      // TODO
    }
    return null;
  }

  static String? responseCode(Map<dynamic, dynamic> json) {
    String responseCode = "empty";
    try {
      if (json.isNotEmpty) {
        responseCode = json['responseCode'];
      }
      debugPrint("Response code :: $responseCode");
    } on Exception {
      // TODO
    }
    return null;
  }

  static void register(String email, String password, String name, ResponseCompletion completion) {
    Map<String, dynamic> json = {
      "email": email,
      "password": password,
      "name": name,
    };
     callPostApi(UrlConstants.registration, _defaultHeader(), json, completion);
  }

  // social login
  static void socialLogin(String email,String token,String providerName, ResponseCompletion completion) {
    Map<String, dynamic> json = {
      "email": email,
      "token": token,
      "provider_name": providerName
    };
     callPostApi(UrlConstants.socialLogin, _defaultHeader(), json, completion);
  }

  static void login(
      String email, String password, ResponseCompletion completion) {
    Map<String, dynamic> json = {"email": email, "password": password};
     callPostApi(UrlConstants.login, _defaultHeader(), json, completion);
  }

  static void checkuser(String email, ResponseCompletion completion) {
    Map<String, dynamic> json = {"email": email};
    // callPostApi(UrlConstants.checkLogin, _defaultHeader(), json, completion);
  }

  static void logout(ResponseCompletion completion) {
    Map<String, dynamic> json = {};
     getApiCalling(UrlConstants.logout, _defaultHeader(), json, completion);
  }

  static void getAllStation(ResponseCompletion completion) {
    Map<String, dynamic> json = {};
    // getApiCalling(
    //     UrlConstants.getAllStations, _defaultHeader(), json, completion
    //     );
  }

  static void getRequestStation(
    String stationId,
    ResponseCompletion completion,
  ) {
    Map<String, dynamic> json = {};
    // getApiCalling("${UrlConstants.powerBankRequest}?station_id=$stationId",
    //     _defaultHeader(), json, completion);
  }

  static void getUserInfo(
    ResponseCompletion completion,
  ) {
    Map<String, dynamic> json = {};
    // getApiCalling(UrlConstants.getUserInfo, _defaultHeader(), json, completion);
  }

  static void getSearch(
    String text,
    ResponseCompletion completion,
  ) {
    Map<String, dynamic> json = {};
    // getApiCalling("${UrlConstants.search}?search=$text", _defaultHeader(), json,
    //     completion);
  }

  static void updateProfile(
      String email, String name, String phone, ResponseCompletion completion) {
    Map<String, dynamic> json = {"email": email, "phone": phone, "name": name};
    // callPostApi(UrlConstants.updateProfile, _defaultHeader(), json, completion);
  }

  static void reportIssue(
      String deviceId, String message, ResponseCompletion completion) {
    Map<String, dynamic> json = {"device_id": deviceId, "error": message};
    // callPostApi(UrlConstants.reportProblem, _defaultHeader(), json, completion);
  }

  static _defaultHeader() {
    Map<String, String> requestHeaders = {};

    return requestHeaders;
  }

  static void getRentalAcitivity(
    ResponseCompletion completion,
  ) {
    Map<String, dynamic> json = {};
    // getApiCalling(
    //     UrlConstants.rentalActivity, _defaultHeader(), json, completion);
  }

  static void getWalletInfo(
    ResponseCompletion completion,
  ) {
    Map<String, dynamic> json = {};
    // getApiCalling(UrlConstants.getWallet, _defaultHeader(), json, completion);
  }

  static void deleteAccount(
    ResponseCompletion completion,
  ) {
    Map<String, dynamic> json = {};
    // getApiCalling(
    //     UrlConstants.deleteAccount, _defaultHeader(), json, completion);
  }

  static void getSubscription(
    ResponseCompletion completion,
  ) {
    Map<String, dynamic> json = {};
    // getApiCalling(
    //     UrlConstants.getSubscription, _defaultHeader(), json, completion);
  }

  static void setSubScription(
      String paymentMethodId, String planId, ResponseCompletion completion) {
    Map<String, dynamic> json = {
      "payment_method_id": paymentMethodId,
      "price_id": planId
    };
    // callPostApi(
    //     UrlConstants.setSubScription, _defaultHeader(), json, completion);
  }

  static void getPromoCode(
    ResponseCompletion completion,
  ) {
    Map<String, dynamic> json = {};
    // getApiCalling(
    //     UrlConstants.getReferalCode, _defaultHeader(), json, completion);
  }

  static void activateReferalCode(String code, ResponseCompletion completion) {
    Map<String, dynamic> json = {"code": code};
    // callPostApi(
    //     UrlConstants.activateReferalCode, _defaultHeader(), json, completion);
  }
}
