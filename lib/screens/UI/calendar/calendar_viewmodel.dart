import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:safe/constants/keys.dart';

class CalendarViewModel extends ChangeNotifier implements TickerProvider {
  DateTime arrivalfocusDay = DateTime.now();
  DateTime departureFocusDay = DateTime.now();

  late TabController _tabController;
  bool switchValue = false;
  final List<String> tabs = [
    "Arrivals",
    "Departures",
  ];
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
}
