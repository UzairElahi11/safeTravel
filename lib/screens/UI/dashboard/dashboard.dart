import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/screens/UI/dashboard/dashboard_viewModel.dart';
import 'package:stacked/stacked.dart';


class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: ViewModelBuilder<DashboardViewModel>.reactive(
            onViewModelReady: (model) {
              // model.checkingEmailText();
            },
            viewModelBuilder: () => DashboardViewModel(),
            builder: (context, model, _) {
              return const SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [])
              );
            },
          ),
        ),
      ),
    );
  }
}
