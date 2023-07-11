import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/editForm/editFormViewModel.dart';
import 'package:stacked/stacked.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/app_text_styles.dart';
import '../../../Utils/generics/generic_button.dart';
import '../../../Utils/generics/generic_check_box.dart';
import '../../../Utils/generics/generic_icon.dart';
import '../../../Utils/generics/generic_text_field.dart';

class ProfileView extends StatelessWidget {
  static const id = '/profileScreen';
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ViewModelBuilder<ProfileViewModel>.reactive(
          onViewModelReady: (model) {
            model.init(context);
          },
          viewModelBuilder: () => ProfileViewModel(),
          builder: (context, model, _) {
            return Padding(
              padding: EdgeInsets.only(left: 34.h, right: 34.h, top: 50.h),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      headerWidgetTop(context),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/edit.svg"),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "Edit",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              model.savingTheListsDataFromDataObject.length,
                          itemBuilder: (context, index) => SizedBox(
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: AppColors.containerBgColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 50.w),
                                        child: Text(
                                          model.firstLetterUpperCase(index),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      GridView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30.w),
                                          physics:
                                              const ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: model
                                              .savingTheListsDataFromDataObject[
                                                  index]
                                              .length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 16 / 4,
                                                  crossAxisCount: 2),
                                          itemBuilder: (context, innerIndex) {
                                            return Row(
                                              children: [
                                                GenericCheckBox(
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  value: model
                                                          .checkboxStates[index]
                                                      [innerIndex],
                                                  onChanged: (value) {
                                                    model.updateCheckboxState(
                                                        index,
                                                        innerIndex,
                                                        value!);
                                                  },
                                                ),
                                                SizedBox(width: 10.w),
                                                Text(model
                                                        .savingTheListsDataFromDataObject[
                                                    index][innerIndex]),
                                              ],
                                            );
                                          }),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.w),
                                        child: GenericButton(
                                          width: 400.w,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                ),
                                                child: ClipRRect(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 40.w),
                                                    height: 200.h,
                                                    width: 400.w,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GenericTextField(
                                                            hintText:
                                                                "Add new items",
                                                            filled: true,
                                                            fillColor: AppColors
                                                                .containerBgColor,
                                                            controller: model
                                                                .addItemsController),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        GenericButton(
                                                          height: 80.h,
                                                          radius: 12.r,
                                                          onPressed: () => model
                                                              .addItem(index),
                                                          color: AppColors
                                                              .baseColor,
                                                          child:
                                                              const GenericText(
                                                            "Add",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                                          textStyle:
                                              AppStyles.medium14.copyWith(
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
                              )),
                      SizedBox(
                        height: 30.h,
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
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 50.w),
                              child: const Text(
                                "Health Reports",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            model.getEditProfileData.isEmpty
                                ? const SizedBox.shrink()
                                : ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: model.getEditProfileData.isEmpty
                                        ? 1
                                        : model
                                            .getEditProfileData['data'][0]
                                                ['health_reports']
                                            .length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 10.h,
                                    ),
                                    itemBuilder: (context, index) => Center(
                                      child: Image.network(
                                        model.getEditProfileData['data'][0]
                                            ['health_reports']['10'],
                                        errorBuilder:
                                            (context, exception, stacTrace) =>
                                                const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GenericButton(
                        height: 80.h,
                        radius: 12.r,
                        onPressed: () => model.updateProfile(),
                        color: AppColors.baseColor,
                        child: const GenericText(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget headerWidgetTop(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              AppUtil.pop(context: context);
            },
            child: SvgPicture.asset(AppImages.backArrow)),
        const Spacer(),
        const GenericText(
          LocaleKeys.profile,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
      ],
    );
  }
}
