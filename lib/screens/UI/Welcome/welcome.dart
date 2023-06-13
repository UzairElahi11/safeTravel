import 'package:flutter/material.dart';
import 'package:safe/screens/controllers/introduction/intro_viewModel.dart';

import 'package:stacked/stacked.dart';

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
          return SafeArea(
            child: Container(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
