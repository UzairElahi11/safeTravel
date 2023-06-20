import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CalendarViewModel extends ChangeNotifier implements TickerProvider {
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
}
