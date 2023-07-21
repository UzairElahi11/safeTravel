import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_svg_image.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/dashboard/crips.dart';
import 'package:safe/screens/UI/dashboard/dashboard_viewModel.dart';
import 'package:safe/screens/UI/dashboard/pharmacyListView.dart';
import 'package:safe/screens/UI/editForm/editFormView.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: ViewModelBuilder<DashboardViewModel>.reactive(
          onViewModelReady: (model) {
            // model.checkingEmailText();
            model.init();
          },
          viewModelBuilder: () => DashboardViewModel(),
          builder: (context, model, _) {
            return Scaffold(
              key: _scaffoldKey,
              drawer: Drawer(
                backgroundColor: Colors.white,
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text("Terms and Conditons"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text("Privacy policy"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text("Logout"),
                      onTap: () {},
                    )
                  ],
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
                      _scaffoldKey.currentState?.openDrawer();
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
                        height: 100.h,
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
                if (index == 0) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const GenericText(
                                "Do you want to call the police?"),
                            actions: [
                              MaterialButton(
                                onPressed: () {
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
                }
                if (index == 1) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const GenericText(
                                "Do you want to call the Medical Health?"),
                            actions: [
                              MaterialButton(
                                onPressed: () {
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
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.containerBgColor,
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
                          child: Text(
                            model.services[index].name!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
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

  Widget topHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
    );
  }
}
