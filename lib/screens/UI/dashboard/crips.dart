import 'package:crisp/crisp_view.dart';
import 'package:flutter/material.dart';
import 'package:safe/screens/UI/dashboard/cripViewModel.dart';
import 'package:stacked/stacked.dart';

class CrispScreen extends StatelessWidget {
  const CrispScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CrsipViewModel>.reactive(
      viewModelBuilder: () => CrsipViewModel(),
      onModelReady: (model) {
        model.crispInit();
      },
      builder: (context, viewModel, _) => Scaffold(
        body: SafeArea(
          child: CrispView(
            crispMain: viewModel.crispMain!,
          ),
        ),
      ),
    );
  }
}
