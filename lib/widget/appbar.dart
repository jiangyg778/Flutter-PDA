import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///自定义顶部appBar
appBar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    //让title居左
    centerTitle: true,
    titleSpacing: 0,
    leading: BackButton(),
    title: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
  );
}
