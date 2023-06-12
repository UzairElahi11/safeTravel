import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PawaColor with ChangeNotifier {
  Color pawaBackGroundColor = const Color(0xffF4EEE5);
  Color pawaBackGroundColors = const Color(0xffFFFFFF);
  Color transparentColor = const Color.fromRGBO(0, 0, 0, 0);
  Color backgroundColor = const Color(0xffFF8A00);
  Color textFieldOutlineColor = const Color(0xffDFE0E0);
  Color textFieldBackGroundColor = const Color(0xffF8F9F9);
  Color elevatedButtonBackgroundColor = const Color(0xff1E1E1E);
  Color bottomSheetColor = const Color(0xff39D045);
  Color color00B4B4 = const Color(0xff00B4B4);
  Color textColorLight = const Color(0xff686868);
  Color borderColorTextField = const Color(0xffD9D9D9);
  Color bottomSheetHeaderColor = const Color(0xffECECEC);
  Color redDelete = const Color(0xffEB4335);
  Color lightGray = const Color(0xffA6A6A6);
  Color lightGrayContainerWallet = const Color(0xffF8F8F8);
  Color diverLine = const Color(0xffDBDBDB);
  Color fontLightColor = const Color(0xff7B7B7B);
  Color containerLightGrayColor = const Color(0xff686868);
  Color lightbarColor = const Color(0xffA6A6A6);
  Color lightGreenColor = const Color(0xff2DC47B);
  Color color1E1E1E = const Color(0xff1E1E1E);
  Color color797979 = const Color(0xff797979);
  Color colorFF7A00 = const Color(0xffFF7A00);
  Color color565656 = const Color(0xff565656);
  Color colorFF0000 = const Color(0xffFF0000);
  static const Color cardBgColor = Color(0xff363636);
  static const Color colorB58D67 = Color(0xffB58D67);
  static const Color colorE5D1B2 = Color(0xffE5D1B2);
  static const Color colorF9EED2 = Color(0xffF9EED2);
  static const Color colorFFFFFD = Color(0xffFFFFFD);
  Color color808080 = const Color(0xff808080);
  Color colorC2C2C2 = const Color(0xffC2C2C2);

  PawaColor._() {
    pawaBackGroundColor = const Color(0xffF4EEE5);
  }
  static final PawaColor instance = PawaColor._();
  static PawaColor themeColor(BuildContext context) {
    return Provider.of<PawaColor>(context);
  }
}
