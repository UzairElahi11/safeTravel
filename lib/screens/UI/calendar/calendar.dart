import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_tabar.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/screens/UI/calendar/calendar_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/calendar/arival_calendar_widget.dart';

class Calendar extends StatelessWidget {
  static const id = "CALENDAR_SCREEN";
  const Calendar({super.key});

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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
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
                      GenericTabBar(
                        height: MediaQuery.of(context).size.height*0.57,
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
                            margin: const EdgeInsets.all(8.0),
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
                            child: const ArrivalCalendar(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          Switch.adaptive(
                            thumbColor:
                                MaterialStateProperty.all(AppColors.whiteColor),
                            activeColor: AppColors.baseColor,
                            value: model.switchValue,
                            onChanged: (value) {
                              model.changeSwitchValue();
                            },
                          ),
                          Expanded(
                            child: GenericText(
                              LocaleKeys.sendLocationInEmergency,
                              style: AppStyles.medium14.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      GenericButton(
                        height: 70.h,
                        onPressed: () {},
                        text: LocaleKeys.next,
                        textStyle: AppStyles.mediumBold16.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // SizedBox(
                      //   height: 60.h,
                      // ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
