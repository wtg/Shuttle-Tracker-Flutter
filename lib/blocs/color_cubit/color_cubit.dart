import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(ColorInitial());
}
