import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_svg_image.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/dashboard/dashboard_viewModel.dart';
import 'package:safe/widgets/dialogBoxAddNewPerson.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ViewModelBuilder<DashboardViewModel>.reactive(
          onViewModelReady: (model) {
            // model.checkingEmailText();
            model.init();
          },
          viewModelBuilder: () => DashboardViewModel(),
          builder: (context, model, _) {
            return Scaffold(
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
                    onTap: () {},
                    child: GenericSvgImage(
                      svgPath: AppImages.menu,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                        onTap: () {},
                        child: GestureDetector(
                          onTap: () {},
                          child: GenericSvgImage(
                            svgPath: AppImages.user,
                          ),
                        )),
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
                              onPressed: () {},
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
                          SizedBox(
                              height: 70.h,
                              child: Image.asset(AppImages.whatsApp))
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
                  model.callPolice(
                      context: context,
                      completion: (success) {
                        if (success) {
                        showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(
          cancelCallBack: () {
            AppUtil.pop(context: context);
          },
          proceedCallBack: () {
         
          },
        );
      },
    );
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