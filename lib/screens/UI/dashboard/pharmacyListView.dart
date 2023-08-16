import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/model/pharmacy/pharmacyListModel.dart';
import 'package:safe/screens/UI/dashboard/dashboard_viewModel.dart';
import 'package:stacked/stacked.dart';

class PharmacyListView extends StatelessWidget {
  final List<Datum> pharmacyList;

  const PharmacyListView({super.key, required this.pharmacyList});

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
              body: Padding(
                padding: EdgeInsets.only(left: 34.h, right: 34.h, top: 50.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      headerWidgetTop(context),
                      SizedBox(
                        height: 50.h,
                      ),
                      Expanded(child: listpharmacies(context)),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listpharmacies(BuildContext context) {
    return pharmacyList.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      AppUtil.launchUrls(
                          "google.navigation:q=${pharmacyList[index].lat},${pharmacyList[index].long}&mode=d");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.containerBgColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                    const TextSpan(
                                      text: "Name : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: pharmacyList[index].name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ])),
                              SizedBox(
                                height: 10.h,
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                    const TextSpan(
                                      text: "Distance : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: pharmacyList[index]
                                          .distance
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ])),
                              SizedBox(
                                height: 10.h,
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                    const TextSpan(
                                      text: "Address : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: pharmacyList[index].streetAddress,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ])),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  )
                ],
              );
            },
            itemCount: pharmacyList.length);
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
        const GenericText(
          LocaleKeys.pharmacyList,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
