import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

typedef void CallbackButtonTap({String buttonText});

class KeyboardButtons extends StatelessWidget {
  KeyboardButtons({required this.buttons, required this.onTap});

  final String buttons;
  final CallbackButtonTap onTap;

  bool _colorTextButtons() {
    return (buttons == DEL_SIGN ||
        buttons == DECIMAL_POINT_SIGN ||
        buttons == CLEAR_ALL_SIGN ||
        buttons == MODULAR_SIGN ||
        buttons == PLUS_SIGN ||
        buttons == MINUS_SIGN ||
        buttons == MULTIPLICATION_SIGN ||
        buttons == DIVISION_SIGN ||
        buttons == EXCHANGE_CALCULATOR ||
        buttons == PI ||
        buttons == SQUARE_ROOT_SIGN ||
        buttons == POWER_SIGN ||
        buttons == LN_SIGN ||
        buttons == LG_SIGN ||
        buttons == SIN_SIGN ||
        buttons == COS_SIGN ||
        buttons == TAN_SIGN ||
        buttons == RAD_SIGN ||
        buttons == DEG_SIGN ||
        buttons == ARCSIN_SIGN ||
        buttons == ARCCOS_SIGN ||
        buttons == ARCTAN_SIGN ||
        buttons == LN2_SIGN ||
        buttons == E_NUM ||
        buttons == LEFT_QUOTE_SIGN ||
        buttons == RIGHT_QUOTE_SIGN);
  }

  bool _fontSize() {
    return (buttons == LN_SIGN ||
        buttons == LG_SIGN ||
        buttons == SIN_SIGN ||
        buttons == COS_SIGN ||
        buttons == TAN_SIGN ||
        buttons == RAD_SIGN ||
        buttons == DEG_SIGN ||
        buttons == ARCSIN_SIGN ||
        buttons == ARCCOS_SIGN ||
        buttons == ARCTAN_SIGN ||
        buttons == LN2_SIGN ||
        buttons == LEFT_QUOTE_SIGN ||
        buttons == RIGHT_QUOTE_SIGN ||
        buttons == PLUS_SIGN ||
        buttons == MINUS_SIGN ||
        buttons == MULTIPLICATION_SIGN ||
        buttons == DIVISION_SIGN ||
        buttons == EXCHANGE_CALCULATOR);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.1,
      alignment: Alignment.bottomCenter,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: (_colorTextButtons())
              ? Colors.grey.shade200
              : (buttons == EQUAL_SIGN)
                  ? Color(0xFF8CB93D)
                  : null,
          foregroundColor:
              (buttons == EQUAL_SIGN) ? Colors.black : Color(0xFFFFFFFF),
          padding: EdgeInsets.symmetric(vertical: 10.0),
        ),
        child: Text(
          buttons,
          style: TextStyle(
            color: (_colorTextButtons())
                ? Color(0xff000000)
                : (buttons == EQUAL_SIGN)
                    ? Colors.black
                    : Color(0xff000000),
            fontSize: _fontSize() ? 18.sp : 16.sp,
          ),
        ),
        onPressed: () => onTap(buttonText: buttons),
      ),
    );
  }

  bool _isGrayShade100Button() {
    return (buttons == MINUS_SIGN ||
        buttons == MULTIPLICATION_SIGN ||
        buttons == DIVISION_SIGN ||
        buttons == PLUS_SIGN ||
        buttons == EXCHANGE_CALCULATOR);
  }
}
