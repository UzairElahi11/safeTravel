import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/screens/UI/user_details/user_data_manager.dart';

import '../../../Utils/app_util.dart';
import '../../../Utils/user_defaults.dart';
import '../add_family_members/add_family_members_viewmodel.dart';
import '../disablity/disability_viewmodel.dart';
import '../payment/payment_view.dart';
import '../user_details/userDetail_viewModel.dart';

class CalendarViewModel extends ChangeNotifier implements TickerProvider {
  DateTime arrivalfocusDay = DateTime.now();
  DateTime? departureFocusDay;
  bool isGovernemnt = true;
  bool isPrivate = false;

  bool isloading = false;

  late TabController _tabController;
  bool switchValue = false;
  final List<String> tabs = ["Arrivals", "Departures"];
  List<Ticker> tickers = [];
  TabController get tabController => _tabController;

  void initializeTabController(int length) {
    _tabController = TabController(length: length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String formateArrivalDate() {
    return DateFormat('yyyy/MM/dd').format(arrivalfocusDay);
  }

  String formateDepartureDate() {
    return DateFormat('yyyy/MM/dd').format(departureFocusDay!);
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    final ticker = Ticker(onTick, debugLabel: 'TickerProvider');
    tickers.add(ticker);
    return ticker;
  }

  //Change the switch button value
  bool changeSwitchValue() {
    switchValue = !switchValue;
    notifyListeners();
    return switchValue;
  }

  static CalendarViewModel of({required bool listen}) {
    return Provider.of(Keys.mainNavigatorKey.currentState!.context,
        listen: listen);
  }

  createBooking(Map<String, dynamic> body) async {
    isloading = true;
    notifyListeners();
    Map<String, dynamic> bodyToBePosted = {
      "emergency_contact": {
        "name": nameController.text.trim(),
        "phone": phoneNumberController.text.trim(),
        "notes": notesController.text.trim()
      },
      "booking": {
        "isGovernment": isGovernemnt ? true : false,
        "arrival": DateFormat('yyyy/MM/dd').format(arrivalfocusDay),
        "departure": DateFormat('yyyy/MM/dd').format(
          departureFocusDay ??
              arrivalfocusDay.add(
                const Duration(days: 1),
              ),
        ),
        "isGovernment": false,
      },
      "family_members": {
        "adults": familyMembersList[0]['numberOfMembers'],
        "childrens": familyMembersList[1]['numberOfMembers'],
        "new_borns": familyMembersList[2]['numberOfMembers'],
        "members": maintingUserDetails
      },
      "lat": UserDataManager.getInstance().lat,
      "long": UserDataManager.getInstance().long,
    };

    log("bsads $bodyToBePosted");

    final val = await UserDefaults.getToken();

    debugPrint("token is $val");

    const String valueUrl = "http://staysafema.com/api/create-booking";

    final dio = Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer $bearerToken";
    // print(formData.toString());
    dio.post(valueUrl, data: bodyToBePosted).then((value) async {
      try {
        if (value.statusCode == 200) {
          // Successful request
          debugPrint('Request successful!');
          debugPrint('Response body: ${value.data}');

          if (value.data['status'] == 1) {
            showDialog(
              context: Keys.mainNavigatorKey.currentState!.context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Police"),
                  content: const Text("Error"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        AppUtil.pop(context: context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );

            await UserDefaults.setIsFormPosted("1");
            Navigator.of(Keys.mainNavigatorKey.currentState!.context)
                .pushReplacement(
              MaterialPageRoute(
                builder: (context) => const PaymentView(),
              ),
            );

            maintingUserDetails.clear();
          }
        } else {
          // Request failed
          debugPrint('Request failed with status: ${value.statusCode}');

          isloading = false;
          notifyListeners();
        }
      } catch (e) {
        debugPrint(e.toString());
        isloading = false;
        notifyListeners();
      } finally {
        isloading = false;
        notifyListeners();
      }
    });
  }
}
