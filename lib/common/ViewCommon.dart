import 'package:flutter/material.dart';
var screenData;
void loadScrenData(BuildContext context) {
    /// 画面はばを取得
    screenData = MediaQuery.of(context).size;
}

/// 画面横の比率
double relativeWidth(double size) {
    // var screenData = MediaQuery.of(context).size;
    double screenWidth = screenData.width;
    return screenWidth * size * 0.01;
    // return 600 * size * 0.01;
}

/// 画面縦の比率
double relativeHeight(double size) {
    // var screenData = MediaQuery.of(context).size;
    double screenHeight = screenData.height;
    return screenHeight * size * 0.01;
    // return 800 * size * 0.01;
}
