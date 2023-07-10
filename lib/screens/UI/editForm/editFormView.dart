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
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(left: 34.h, right: 34.h, top: 50.h),
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

                          SizedBox(height: 10.h,),
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
