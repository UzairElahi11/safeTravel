import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/add_family_members/add_family_members_viewmodel.dart';
import 'package:safe/screens/UI/calendar/calendar.dart';
import 'package:stacked/stacked.dart';

class AddFamilyMembers extends StatelessWidget {
  static const id = "ADD_FAMILY_SCREEN";
  const AddFamilyMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ViewModelBuilder<AddFamilyMembersViewModel>.reactive(
          viewModelBuilder: () => AddFamilyMembersViewModel(),
          builder: (context, model, _) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  headerWidgetTop(context),
                  SizedBox(
                    height: 30.h,
                  ),
                  GenericText(LocaleKeys.addFamilyMembers,
                      style: AppStyles.medium24.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: List.generate(
                      model.familyMembersList.length,
                      (index) => ListTile(
                        minVerticalPadding: 0.0,
                        contentPadding: EdgeInsets.zero,
                        title: GenericText(
                          "${model.familyMembersList[index]['member']}",
                          style: AppStyles.medium20.copyWith(
                            color: AppColors.lightBlackColor,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 400.w,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => model.removeMembers(index),
                                child: Container(
                                  height: 40.h,
                                  width: 100.w,
                                  color: AppColors.iconBgColor,
                                  child:
                                      const Center(child: Icon(Icons.remove)),
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              GenericText(
                                "${model.familyMembersList[index]['numberOfMembers']}",
                                style: AppStyles.medium20.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              GestureDetector(
                                onTap: () => model.addMembers(index,context),
                                child: Container(
                                  height: 40.h,
                                  width: 100.w,
                                  color: AppColors.iconBgColor,
                                  child: const Center(child: Icon(Icons.add)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  GenericButton(
                    height: 70.h,
                    onPressed: () {
                      AppUtil.pushRoute(
                        context: context,
                        route: const Calendar(),
                      );
                    },
                    text: LocaleKeys.next.translatedString(),
                    textStyle: AppStyles.mediumBold16.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
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
            child: SvgPicture.asset(AppImages.backArrow)),
        SizedBox(
          width: 100.h,
        ),
      ],
    );
  }
}
