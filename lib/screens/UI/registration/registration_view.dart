import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/pawa_images_path.dart';
import 'package:safe/screens/controllers/introduction/intro_viewModel.dart';
import 'package:safe/screens/controllers/registration/registration_viewModel.dart';
import 'package:safe/widgets/text_field.dart';

import 'package:stacked/stacked.dart';

class RegistationView extends StatelessWidget {
  static const id = "/RegistationView";
  const RegistationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<RegistrationViewModel>.reactive(
        viewModelBuilder: () => RegistrationViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.init();
        },
        builder:
            (BuildContext context, RegistrationViewModel model, Widget? child) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 34.h),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      headerWidgetTop(context),
                      SizedBox(
                        height: 40.h,
                      ),
                      headerWidget(),
                      SizedBox(
                        height: 40.h,
                       ),
                      Text(
                        "Register",
                        style:
                            TextStyle(fontSize: 18, color: AppColors.baseColor),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Full Name"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldCustom(
                              controllerText: model.fullName,
                              icon: Assets.userLogo,
                              title: "Full Name",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Email"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldCustom(
                              controllerText: model.email,
                              icon: Assets.suffixIcon,
                              title: "Email",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Password"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldCustom(
                              controllerText: model.password,
                              icon: Assets.suffixIconLock,
                              title: "Password",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Confirm Password"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldCustom(
                              controllerText: model.confirmPassword,
                              icon: Assets.suffixIconLock,
                              title: "Confirm Password",
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    // AppUtil.pushRoute(
                                    //     context: context,
                                    //     route:  MainScreen());
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColors.baseColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            // emailContainer(),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget headerWidgetTop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      // mainAxisAlignment: Mai,
      children: [
        InkWell(
            onTap: () {
              AppUtil.pop(context: context);
            },
            child: SvgPicture.asset(Assets.backArrow)),
        SizedBox(
          width: 100.h,
        ),
      ],
    );
  }

  Widget emailContainer() {
    return Center(
        child: Text(
      "info@staysafemorocco.com",
      style: TextStyle(
        color: AppColors.lightGreyColor,
        decoration: TextDecoration.underline,
      ),
    ));
  }

  Widget headerWidget() {
    return const Center(
        child: Text(
      "Stay Safe Morocco",
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    ));
  }
}
