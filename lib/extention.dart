
import 'package:flutter/material.dart';
import 'data/data.dart';
import 'main.dart';

extension ColorExtension on TaskEntity{
  getColor(){
    switch(this.priority)
    {
      case Priority.high:
        return primaryColor;
      case Priority.normal:
        return const Color(0xffF09819);
      case Priority.low:
        return const Color(0xff3BE1F1);
    }
  }
}