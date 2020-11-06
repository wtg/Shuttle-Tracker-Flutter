import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ColorCubit extends Cubit<Map<int, Color>> {
  ColorCubit() : super({});

  void setColor(Map<int, Color> colorMap) => emit(colorMap);
}
