import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/screens/UI/login/login.dart';
import 'package:safe/screens/UI/registration/registration_view.dart';
import 'package:safe/screens/controllers/introduction/intro_viewModel.dart';
import 'package:stacked/stacked.dart';

import '../../../Utils/app_images_path.dart';

class IntroView extends StatelessWidget {
  static const id = "/IntroView";
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<IntroViewModel>.reactive(
        viewModelBuilder: () => IntroViewModel(),
        onViewModelReady: (viewModel) {},
        builder: (BuildContext context, IntroViewModel model, Widget? child) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 100.h, horizontal: 34.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    headerWidget(title: "Introduction"),
                    SizedBox(
                      height: 80.h,
                    ),
                    introBody(),
                    SizedBox(
                      height: 50.h,
                    ),
                    nextButton(context),
                    SizedBox(
                      height: 50.h,
                    ),
                    checkBoxRow(model),
                    emailContainer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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

  Widget checkBoxRow(IntroViewModel model) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: model.checkBox,
          onChanged: (bool? check) {
            model.checkBoxHandler(check!);
          },
          activeColor: AppColors.baseColor,
        ),
        Text(
          "I accept Terms & Conditions",
          style: TextStyle(color: AppColors.mediumGreyColor),
        ),
      ],
    );
  }

  Widget nextButton(BuildContext context) {
    return InkWell(
      onTap: () => AppUtil.pushRoute(
        context: context,
        route: const RegistationView(),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.h),
        height: 70.h,
        decoration: BoxDecoration(
            color: AppColors.baseColor,
            borderRadius: BorderRadius.circular(25)),
        child: const Center(
          child: Text(
            "Next",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }

  Widget introBody() {
    return const Text(
      "Exploring the enchanting landscapes and vibrant culture while prioritizing your well-being with robust safety measures. Stay Safe Morocco: Embark on an unforgettable journey through the captivating sights and sounds of Morocco, all while ensuring your safety is our top priority. With stringent health protocols, expert guides, and carefully curated experiences, indulge in the rich history, breathtaking landscapes, and warm hospitality with peace of mind. Immerse yourself in the magic of Morocco while we take care of your well-being every step of the way.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Widget headerWidget({String title = ""}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      // mainAxisAlignment: Mai,
      children: [
        SvgPicture.asset(AppImages.backArrow),
        SizedBox(
          width: 100.h,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
