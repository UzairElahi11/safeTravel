
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/dynamic_size.dart';
import 'package:safe/screens/UI/payment/payment_web_viewModel.dart';

import 'package:stacked/stacked.dart';


class PaymentWebview extends StatelessWidget {
  final String url;
    PaymentWebview({super.key,required this.url});
     final Completer<WebViewController> _controller = Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentWebViewModel>.reactive(
        viewModelBuilder: () => PaymentWebViewModel(),
        onModelReady: (viewModel) {
          //viewModel.init(context);
        },
        builder:
            (BuildContext context, PaymentWebViewModel model, Widget? child) {
          return Scaffold(
            body:  WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains("https://pawasharing.com/")) {
             
              Navigator.of(context).pop(true);
            }
           
            return NavigationDecision.navigate;
          },
        ),
        //     InAppWebView(
        //       initialUrlRequest: URLRequest(
        //        url: Uri.parse(url)),
        //         initialOptions: InAppWebViewGroupOptions(crossPlatform: model.option),
        //      onWebViewCreated: (InAppWebViewController controller) {
        //       model.webViewController = controller;
        //      AppUtil.showLoader(context: context);
        //       },
        //        onLoadStart: (controller, url) {},
        // onReceivedServerTrustAuthRequest: (controller, challenge) async {
        //   return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
        // },
        // onLoadStop: (controller, url) async {
        //   AppUtil.dismissLoader(context:context);
        // },
        // onLoadError: (controller, url, code, message) {
        //   AppUtil.dismissLoader(context:context);
        // },
        //     ),
       
            );
         
        });
  }

  Widget profileDetails(String lable, String hintText, BuildContext context,
      TextEditingController controller,bool isDismissable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: DynamicSize.height(0.03, context),
        ),
        Text(
          lable,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: DynamicSize.width(0.002, context),
              right: DynamicSize.width(0.002, context)),
          child: TextField(
            
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: Color(0xffA6A6A6),
                )),
          ),
        )
      ],
    );
  }
}
