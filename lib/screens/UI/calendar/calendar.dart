
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_check_box.dart';
import 'package:safe/Utils/generics/generic_tabar.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/calendar/calendar_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/calendar/arival_calendar_widget.dart';

class Calendar extends StatelessWidget {
  static const id = "CALENDAR_SCREEN";
  final Map<String, dynamic> body;
  const Calendar({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: ViewModelBuilder<CalendarViewModel>.reactive(
              onViewModelReady: (model) => model.initializeTabController(2),
              viewModelBuilder: () => CalendarViewModel(),
              builder: (context, model, _) {
                return Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    headerWidget(),
                    GenericText(
                      LocaleKeys.dateOfArivalAndDeparture,
                      style: AppStyles.medium24.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: GenericTabBar(
                        selectedLabelColor: AppColors.blackColor,
                        unselectedLabelColor: AppColors.unSelectedColor,
                        labelStyle: AppStyles.medium20.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500),
                        indicatorColor: AppColors.baseColor,
                        controller: model.tabController,
                        labels: [
                          model.tabs[0],
                          model.tabs[1],
                        ],
                        tabChildren: [
                          Card(
                            shadowColor: AppColors.blackColor.withOpacity(0.25),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            elevation: 5.0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const ArrivalCalendar(),
                          ),
                          Card(
                            shadowColor: AppColors.blackColor.withOpacity(0.25),
                            margin: const EdgeInsets.all(8.0),
                            elevation: 6.0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const DepartureCalendat(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    model.isloading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : GenericButton(
                            height: 70.h,
                            onPressed: () async {
                              model.departureFocusDay == null
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: GenericText(
                                          LocaleKeys.selectedDepartureDate,
                                        ),
                                      ),
                                    )
                                  // : await model.createBooking(body);
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return myDialog();
                                      },
                                    );
                            },
                            text: LocaleKeys.next,
                            textStyle: AppStyles.mediumBold16.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    SizedBox(
                      height: 60.h,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget myDialog() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Consumer<CalendarViewModel>(builder: (context, model, _) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Please Choose"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GenericCheckBox(
                      borderSide: const BorderSide(width: 0.4),
                      visualDensity: VisualDensity.compact,
                      value: model.isGovernemnt,
                      onChanged: (value) {
                        setState(() {
                          model.checkBoxGoverment();
                        });

                        model.isPrivate = false;
                        model.isGovernemnt = true;
                        // model.notifyListeners();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Government Hospital"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GenericCheckBox(
                      visualDensity: VisualDensity.compact,
                      value: model.isPrivate,
                      borderSide: const BorderSide(width: 0.4),
                      onChanged: (value) {
                        setState(() {
                          model.privateHospital();
                        });

                        model.isPrivate = true;
                        model.isGovernemnt = false;
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Private Hospital"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: GenericButton(
                              padding: const EdgeInsets.all(10),
                              text: "Cancel",
                              // textColor: Colors.white,
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              onPressed: () {
                                AppUtil.pop(context: context);
                              })),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: GenericButton(
                              padding: const EdgeInsets.all(10),
                              text: "Proceed",
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              // textColor: Colors.white,
                              onPressed: () async {
                                await model.createBooking(body);
                              })),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
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
        // SizedBox(
        //   width: 100.h,
        // ),
        // GenericText(
        //   title,
        //   style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        // )
      ],
    );
  }
}
