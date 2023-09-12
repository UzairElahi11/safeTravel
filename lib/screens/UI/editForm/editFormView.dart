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
                      model.getEditProfileData['data'] == null
                          ? const SizedBox()
                          : Center(
                              child: Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      model.imageFile == null
                                          ? model.getEditProfileData['data'][0]
                                                      ['picture'] !=
                                                  null
                                              ? CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: NetworkImage(
                                                    model.getEditProfileData[
                                                                'data'][0]
                                                            ['picture'] ??
                                                        const Icon(
                                                            Icons.person),
                                                  ))
                                              : GestureDetector(
                                                onTap: model.selectImage,
                                                child: CircleAvatar(
                                                    radius: 40,
                                                    backgroundColor:
                                                        Colors.grey[300]!,
                                                    child: const Icon(Icons
                                                        .camera_alt_outlined),
                                                  ),
                                              )
                                          : CircleAvatar(
                                              radius: 40,
                                              backgroundImage:
                                                  FileImage(model.imageFile!),
                                            ),
                                      model.getEditProfileData['data'][0]
                                                  ['picture'] !=
                                              null
                                          ? Positioned(
                                              top: 0,
                                              right: 0,
                                              child: InkWell(
                                                onTap: model.selectImage,
                                                child: CircleAvatar(
                                                  radius: 12,
                                                  child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      color:
                                                          AppColors.color232323,
                                                      size: 15),
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: GenericText(
                                model.getEditProfileData.isNotEmpty
                                    ? "${model.getEditProfileData['data'][0]['first_name']} ${model.getEditProfileData['data'][0]['last_name']}"
                                    : "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                            Center(
                              child: GenericText(
                                model.getEditProfileData['data'][0]['email'] ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 5),
                              ),
                            ),
                            Center(
                              child: GenericText(
                                model.getEditProfileData['data'][0]['phone'] ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: model
                                        .savingTheListsDataFromDataObject
                                        .isEmpty
                                    ? 0
                                    : model.savingTheListsDataFromDataObject
                                            .length -
                                        1,
                                itemBuilder: (context, index) => SizedBox(
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                              padding:
                                                  EdgeInsets.only(left: 50.w),
                                              child: Text(
                                                model.firstLetterUpperCase(
                                                    index),
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
                                                        childAspectRatio:
                                                            16 / 9,
                                                        crossAxisCount: 2),
                                                itemBuilder:
                                                    (context, innerIndex) {
                                                  return Row(
                                                    children: [
                                                      GenericCheckBox(
                                                        visualDensity:
                                                            VisualDensity
                                                                .compact,
                                                        value: model
                                                                .checkboxStates[
                                                            index][innerIndex],
                                                        onChanged: (value) {
                                                          model
                                                              .updateCheckboxState(
                                                                  index,
                                                                  innerIndex,
                                                                  value!);
                                                        },
                                                      ),
                                                      SizedBox(width: 10.w),
                                                      Expanded(
                                                        child: Text(
                                                          model.savingTheListsDataFromDataObject[
                                                                  index]
                                                              [innerIndex],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
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
                                                    builder: (context) =>
                                                        Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
                                                      ),
                                                      child: ClipRRect(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40.w),
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
                                                                  fillColor:
                                                                      AppColors
                                                                          .containerBgColor,
                                                                  controller: model
                                                                      .addItemsController),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              GenericButton(
                                                                height: 80.h,
                                                                radius: 12.r,
                                                                onPressed: () =>
                                                                    model.addItem(
                                                                        index),
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      model.getEditProfileData['data'][0]['health_reports'] ==
                                  null ||
                              model.getEditProfileData['data'][0]
                                      ['health_reports'] ==
                                  []
                          ? Padding(
                              padding: EdgeInsets.only(left: 50.w),
                              child: const Text(
                                "Health Reports",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: 10.h,
                      ),
                      model.getEditProfileData['data'][0]['health_reports'] ==
                              null
                          ? const SizedBox()
                          : ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 20,
                                  ),
                              shrinkWrap: true,
                              itemCount: model
                                  .getEditProfileData['data'][0]
                                      ['health_reports']
                                  .length,
                              itemBuilder: (context, index) {
                                final reportNumber =
                                    model.imagesList.keys.elementAt(index);
                                final reportUrl =
                                    model.imagesList[reportNumber];
                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          reportUrl,
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        model.removeData(reportNumber);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                );
                              }),
                      const SizedBox(
                        height: 20,
                      ),
                      model.reports.isNotEmpty
                          ? ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          model.reports[index]!,
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        model.removeLocalImages(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (index, context) =>
                                  const SizedBox(
                                height: 20,
                              ),
                              itemCount: model.reports.length,
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: 30.h,
                      ),
                      GenericButton(
                        height: 70.h,
                        width: double.infinity,
                        text: LocaleKeys.addHealthReport,
                        leading: Icon(Icons.add, color: AppColors.whiteColor),
                        textStyle: AppStyles.mediumBold16.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                        onPressed: () => model.selectImageReport(),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      model.getEditProfileData.isEmpty ||
                              model.getEditProfileData['data'].isEmpty
                          ? const SizedBox()
                          : GenericButton(
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
