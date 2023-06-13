import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/screens/controllers/introduction/intro_viewModel.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:stacked/stacked.dart';

import '../../../Utils/pawa_images_path.dart';

class Welcome extends StatelessWidget {
  static const id = "/IntroView";
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<IntroViewModel>.reactive(
        viewModelBuilder: () => IntroViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.init();
        },
        builder: (BuildContext context, IntroViewModel model, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(Assets.logoSvg),
              ),
              SizedBox(height: 80.h,),
            ],
          );
        },
      ),
    );
  }
}
