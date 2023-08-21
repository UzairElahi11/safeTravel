import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/controllers/introduction/into_viewmodel.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:stacked/stacked.dart';
import 'package:safe/Utils/app_images_path.dart';

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      headerWidget(title: LocaleKeys.introductions),
                      SizedBox(
                        height: 80.h,
                      ),
                      introBody(),
                      SizedBox(
                        height: 50.h,
                      ),
                      nextButton(context, model),
                      SizedBox(
                        height: 50.h,
                      ),
                      checkBoxRow(model),
                      emailContainer(),
                    ],
                  ),
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
        child: GenericText(
      LocaleKeys.emailAddress,
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
        GenericText(
          LocaleKeys.acceptTC,
          style: TextStyle(color: AppColors.mediumGreyColor),
        ),
      ],
    );
  }

  Widget nextButton(BuildContext context, IntroViewModel model) {
    return InkWell(
      onTap: !model.checkBox
          ? null
          : () => model.acceptConditionAndMoveNext(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.h),
        height: 70.h,
        decoration: BoxDecoration(
          color: !model.checkBox ? Colors.grey : AppColors.baseColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: GenericText(
            LocaleKeys.next,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }

  Widget introBody() {
    return const GenericText(
      LocaleKeys.introDetailsMessage,
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
      children: [
        GestureDetector(
            onTap: () =>
                Navigator.pop(Keys.mainNavigatorKey.currentState!.context),
            child: SvgPicture.asset(AppImages.backArrow)),
        SizedBox(
          width: 100.h,
        ),
        GenericText(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
