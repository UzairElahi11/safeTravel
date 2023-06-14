import 'package:flutter/material.dart';
import 'package:safe/screens/controllers/introduction/intro_viewModel.dart';

import 'package:stacked/stacked.dart';

class IntroView extends StatelessWidget {
  static const id = "/IntroView";
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<IntroViewModel>.reactive(
        viewModelBuilder: () => IntroViewModel(),
        onViewModelReady: (viewModel) {},
        builder: (BuildContext context, IntroViewModel model, Widget? child) {
          return SafeArea(
            child: Container(),
          );
        },
      ),
    );
  }
}
