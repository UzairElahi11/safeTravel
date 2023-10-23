import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:safe/Utils/app_util.dart';

class PaymentWebViewModel with ChangeNotifier {

   late InAppWebViewController webViewController;
 InAppWebViewOptions option = InAppWebViewOptions(
    userAgent:  Platform.isIOS
        ? "Mozilla/5.0 (iPad; U; CPU OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari"
        : "Mozilla/5.0 (Linux; Android 10; Infinix X688B Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/96.0.4664.104 Mobile Safari/537.36",
    useShouldOverrideUrlLoading: true,
    javaScriptEnabled: true,
    supportZoom: true,
  );

}