import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/screens/UI/user_details/userDetail_viewModel.dart';
import 'package:safe/widgets/user_detail/userDetailHelperWidget.dart';
import 'package:safe/widgets/user_detail/user_info_helperWidget.dart';
import 'package:stacked/stacked.dart';

class UserDetailsView extends StatelessWidget {
  static const id = "UserDetail_screen";
  final bool isFromLogin;
  const UserDetailsView({super.key,required this.isFromLogin});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserDetailsViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          // backgroundColor: AppColors.bgDetailColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: ListView(
              controller: model.scrollController,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                GenericText(
                  LocaleKeys.disability,
                  style: AppStyles.medium24.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UserInformationDtails(model: model),
                SizedBox(
                  height: 20.h,
                ),
                GenericText(
                  "Health Condition",
                  style:
                      AppStyles.medium14.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                UserDetailHeathCondition(
                  model: model,
                  isFromLogin:isFromLogin
                ),

                // EmergencyContactCard(model: model),

                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
