import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shuttles_state.dart';

class ShuttlesCubit extends Cubit<ShuttlesState> {
  
  ShuttlesCubit() : super(ShuttlesInitial());


}
