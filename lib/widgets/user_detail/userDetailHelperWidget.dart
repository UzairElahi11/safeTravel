import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/Utils/generics/generic_text_field.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/user_details/userDetail_viewModel.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_text_styles.dart';
import '../../Utils/generics/generic_button.dart';
import '../../Utils/generics/generic_check_box.dart';
import '../../Utils/generics/generic_icon.dart';

class UserDetailHeathCondition extends StatelessWidget {
  final UserDetailsViewModel model;
  final bool isFromLogin;
  const UserDetailHeathCondition(
      {super.key, required this.model, required this.isFromLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.totalNumberOfListInDataObject,
            itemBuilder: (context, index1) {
              model.listItems = model.listData?[index1] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.listNames.isNotEmpty ? model.listNames[index1] : "",
                    style: AppStyles.medium14
                        .copyWith(color: AppColors.blackColor),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppColors.containerBgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            shrinkWrap: true,
                            itemCount: model.listItems.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 16 / 4,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  GenericCheckBox(
                                    visualDensity: VisualDensity.compact,
                                    value: model.getBoolValue(index , index1),
                                    onChanged: (value) {
                                      model.checkboxes(index, index1);
                                    },
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(model.listItems[index]),
                                ],
                              );
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: GenericButton(
                            width: 400.w,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: ClipRRect(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w),
                                      height: 200.h,
                                      width: 400.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GenericTextField(
                                              hintText: "Add new items",
                                              filled: true,
                                              fillColor:
                                                  AppColors.containerBgColor,
                                              controller:
                                                  model.addItemsController),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          GenericButton(
                                            height: 80.h,
                                            radius: 12.r,
                                            onPressed: () =>
                                                model.addItem(index1),
                                            color: AppColors.baseColor,
                                            child: const GenericText(
                                              "Add",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            leading: GenericIcon(
                              icon: Icons.add,
                              color: AppColors.whiteColor,
                            ),
                            text: LocaleKeys.add,
                            borderRadius: 8,
                            textStyle: AppStyles.medium14.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
        model.reports.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: model.reports.length,
                controller: model.scrollController,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    height: 450.h,
                    width: 450.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.file(
                      model.reports[index]!,
                    ),
                  );
                },
              )
            : const SizedBox(),
        SizedBox(
          height: 20.h,
        ),
        GenericButton(
          height: 70.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 450.w),
          text: LocaleKeys.addPicture,
          leading: Icon(Icons.add, color: AppColors.whiteColor),
          textStyle: AppStyles.mediumBold16.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w400,
          ),
          onPressed: () => model.selectImageReport(),
        ),
        SizedBox(
          height: 20.h,
        ),
        GenericButton(
          height: 70.h,
          width: double.infinity,
          text: LocaleKeys.next,
          textStyle: AppStyles.mediumBold16.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w400,
          ),
          onPressed: () => model.navigate(context, isFromLogin),
        ),
      ],
    );
  }
}
