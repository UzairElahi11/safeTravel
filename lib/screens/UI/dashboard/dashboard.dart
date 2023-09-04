import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_svg_image.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/dashboard/crips.dart';
import 'package:safe/screens/UI/dashboard/dashboard_viewModel.dart';
import 'package:safe/screens/UI/dashboard/pharmacyListView.dart';
import 'package:safe/screens/UI/editForm/editFormView.dart';
import 'package:safe/screens/UI/login/login.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../payment/payment_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: ViewModelBuilder<DashboardViewModel>.reactive(
          onViewModelReady: (model) {
            model.init();
            model.readSkipValueLocally();
          },
          viewModelBuilder: () => DashboardViewModel(),
          builder: (context, model, _) {
            return Scaffold(
              key: scaffoldKey,
              drawer: Drawer(
                backgroundColor: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300.h,
                      ),
                      ListTile(
                        title: const Text(
                          "Terms and Conditons",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_sharp),
                        onTap: () async {
                          {
                            const url =
                                'https://staysafema.com/page/terms-and-conditions';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceWebView: true,
                              );
                            } else {
                              throw 'Could not launch $url';
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // SizedBox.expand(),

                      ListTile(
                        title: const Text(
                          "Privacy policy",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_sharp),
                        onTap: () async {
                          {
                            const url =
                                'https://staysafema.com/page/privacy-policy';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceWebView: true,
                              );
                            } else {
                              throw 'Could not launch $url';
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      //  SizedBox(height: 10,),
                      SizedBox(
                        height: 350.h,
                      ),
                      ListTile(
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_sharp),
                        onTap: () {
                          showDialog(
                              context: context,
                              // barrierDismissible: false,
                              // useRootNavigator: true,
                              builder: (context) {
                                return settingWidget(model, context);
                              });
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: GenericText(LocaleKeys.staySafeText,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor)),
                leading: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: GenericSvgImage(
                      svgPath: AppImages.menu,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        AppUtil.pushRoute(
                          context: context,
                          route: const ProfileView(),
                        );
                      },
                      child: GenericSvgImage(
                        svgPath: AppImages.user,
                      ),
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 100.h,
                      ),
                      servicesList(model, context),
                      SizedBox(
                        height: 180.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GenericButton(
                              height: 70.h,
                              onPressed: () {
                                AppUtil.pushRoute(
                                    context: context,
                                    route: const CrispScreen());
                              },
                              text: "Chat",
                              textStyle: AppStyles.mediumBold16.copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              try {
                                String phoneNumberCode =
                                    countryCode.replaceAll('+', '');
                                //launchUrlString is method of url_launcher package and //phoneNoController.text is the number from phone number textfield
                                await launchUrlString(
                                    'whatsapp://send?phone=${phoneNumberCode + helplineNumber}&text=${Uri.encodeFull("Stay Safe")}');
                              } catch (e) {
                                debugPrint('Error Launching WhatsApp');
                              }
                            },
                            child: SizedBox(
                                height: 70.h,
                                child: Image.asset(AppImages.whatsApp)),
                          )
                        ],
                      )
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget servicesList(DashboardViewModel model, BuildContext context) {
    return ListView.builder(
      itemCount: model.services.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                if (model.skipvalue == "1") {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const GenericText("Proceed to payment"),
                            actions: [
                              MaterialButton(
                                onPressed: () => AppUtil.pushRoute(
                                  pushReplacement: true,
                                  context: context,
                                  route: const PaymentView(),
                                ),
                                child: const GenericText("Yes"),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const GenericText("No"),
                              )
                            ],
                          ));
                } else {
                  if (index == 0) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const GenericText(
                                  "Are you sure you want government help?"),
                              actions: [
                                // MaterialButton(
                                //   onPressed: () {
                                //     model.callPolice(
                                //         context: context,
                                //         completion: (success) {
                                //           if (success) {
                                //             Navigator.pop(context);
                                //             showDialog(
                                //               context: context,
                                //               builder: (BuildContext context) {
                                //                 return AlertDialog(
                                //                   title: const Text("Police"),
                                //                   content: const Text(
                                //                       "Police is on way at you current location please wait and and be safe"),
                                //                   actions: <Widget>[
                                //                     TextButton(
                                //                       onPressed: () {
                                //                         AppUtil.pop(
                                //                             context: context);
                                //                       },
                                //                       child: const GenericText(
                                //                           'Cancel'),
                                //                     ),
                                //                   ],
                                //                 );
                                //               },
                                //             );
                                //           }
                                //         });
                                //   },
                                //   child: const GenericText("Yes"),
                                // ),
                                // MaterialButton(
                                //   onPressed: () {
                                //     Navigator.pop(context);
                                //   },
                                //   child: const GenericText("No"),
                                // )
                                InkWell(
                                  onTap: () {
                                    model.callPolice(
                                        context: context,
                                        completion: (success) {
                                          if (success) {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Police"),
                                                  content: const Text(
                                                      "Police is on way at you current location please wait and and be safe"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        AppUtil.pop(
                                                            context: context);
                                                      },
                                                      child: const GenericText(
                                                          'Cancel'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        });
                                  },
                                  child: Center(
                                    child: Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 30, horizontal: 30),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      child: const Center(
                                        child: Text(
                                          "Police",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ));
                  }
                  if (index == 1) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const GenericText(
                                  "Do you want to call the Medical Health?"),
                              actions: [
                                // MaterialButton(
                                //   onPressed: () {
                                //     model.callHealth(
                                //         context: context,
                                //         completion: (success) {
                                //           if (success) {
                                //             showDialog(
                                //               context: context,
                                //               builder: (BuildContext context) {
                                //                 return AlertDialog(
                                //                   title: const Text("Health"),
                                //                   content: const Text(
                                //                       "Health is on way at you current location please wait and and be safe"),
                                //                   actions: <Widget>[
                                //                     TextButton(
                                //                       onPressed: () {
                                //                         AppUtil.pop(
                                //                             context: context);
                                //                       },
                                //                       child: const GenericText(
                                //                           'Cancel'),
                                //                     ),
                                //                   ],
                                //                 );
                                //               },
                                //             );
                                //           }
                                //         });
                                //   },
                                //   child: const GenericText("Yes"),
                                // ),
                                // MaterialButton(
                                //   onPressed: () {
                                //     Navigator.pop(context);
                                //   },
                                //   child: const GenericText("No"),
                                // )
                                InkWell(
                                  onTap: () {
                                    model.callHealth(
                                        context: context,
                                        completion: (success) {
                                          if (success) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Health"),
                                                  content: const Text(
                                                      "Health is on way at you current location please wait and and be safe"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        AppUtil.pop(
                                                            context: context);
                                                      },
                                                      child: const GenericText(
                                                          'Cancel'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        });
                                  },
                                  child: Center(
                                    child: Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 40, horizontal: 40),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      child: const Center(
                                        child: Text(
                                          "Ambulance",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ));
                  }
                  if (index == 2) {
                    model.getPharmacyList(
                        context: context,
                        completion: (success) {
                          if (success) {
                            AppUtil.pushRoute(
                                context: context,
                                route: PharmacyListView(
                                    pharmacyList: model.pharmacyList));
                          }
                        });
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 165, 190, 227),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 80,
                            width: 80,
                            child:
                                Image.asset(model.services[index].imagePath!)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RichText(
                              text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                TextSpan(
                                  text: LocaleKeys.pressFor.tr(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: model.services[index].name!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ])),
                        ),
                        // Expanded(
                        //   child: RichText(

                        //     child: Text(
                        //       model.services[index].name!,
                        //       textAlign: TextAlign.left,
                        //       style: const TextStyle(
                        //           fontSize: 18, fontWeight: FontWeight.w400),
                        //     ),
                        //   ),
                        // ),
                        GenericSvgImage(svgPath: AppImages.warning)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20))
          ],
        );
      },
    );
  }

  Widget settingWidget(DashboardViewModel model, BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Logout",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("Are you sure you want to logout"),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              model.logOut(
                context: context,
                completion: (success) {
                  if (success) {
                    UserDefaults.clearLoginToken();
                    UserDefaults.clearUserNameAndEmail();
                    UserDefaults.clearform();
                    UserDefaults.clearPayment();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  }
                },
              );
            },
            child: Center(
                child: Container(
              height: 30,
              width: 150,
              decoration: BoxDecoration(
                color: AppColors.baseColor,
              ),
              child: const Center(
                  child: Text(
                "Proceed",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            )),
          )
        ],
      ),
    );
  }

  Widget topHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
    );
  }
}
