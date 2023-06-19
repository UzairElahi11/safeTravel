import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/disablity/disability_viewmodel.dart';
import 'package:safe/widgets/generic_check_box.dart';
import 'package:stacked/stacked.dart';
import 'package:safe/widgets/generic_text.dart';

class Disability extends StatelessWidget {
  const Disability({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DisabilityViewModel(),
      builder: (context, model, _) {
        return ListView(
          children: [
            GenericText(
              LocaleKeys.disability,
              style: AppStyles.medium24.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColors.containerBgColor,
                child: GridView.builder(
                  itemCount: model.disabilityTypes.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 2,
                  ),
                  itemBuilder: (context, index) => Row(
                    children: [
                      GenericCheckBox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      SizedBox(width: 10.w),
                      const GenericText("text"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
