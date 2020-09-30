import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/fusion/fusion_socket.dart';

part 'fusion_state.dart';

class FusionCubit extends Cubit<FusionSocket> {
  final FusionSocket fusionSocket;
  FusionCubit({@required this.fusionSocket}) : super(fusionSocket);
}
