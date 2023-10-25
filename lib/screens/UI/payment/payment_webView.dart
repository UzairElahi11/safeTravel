import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/dynamic_size.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/payment/payment_web_viewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebview extends StatelessWidget {
  final String url;
  PaymentWebview({super.key, required this.url});
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

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
            body: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) {
                log("url on which we are starting the our web view is $url");
              },
              onPageFinished: (url) async {
                if (url.contains(
                    "https://staysafema.com/cmi-payment/payment-success")) {
                  await UserDefaults.setPayment("1");
                  await UserDefaults.setPaymentSkip("0");
                  // ignore: use_build_context_synchronously
                  AppUtil.pushRoute(
                    pushReplacement: true,
                    context: context,
                    route: const DashboardView(),
                  );
                } else if (url.contains(
                    "https://staysafema.com/cmi-payment/payment-failed")) {
                  // ignore: use_build_context_synchronously
                  Keys.mainNavigatorKey.currentState!.pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Payment Failed"),
                  ));
                }
                log("url going to finised is $url");
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.contains("")) {
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
      TextEditingController controller, bool isDismissable) {
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
