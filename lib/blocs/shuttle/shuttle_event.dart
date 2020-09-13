part of 'shuttle_bloc.dart';

abstract class ShuttleEvent extends Equatable {
  final BuildContext context;
  final dynamic animatedMapMove;
  final ThemeData theme;
  final OnTapEtaBloc bloc;
  const ShuttleEvent(
      {@required this.animatedMapMove,
      @required this.theme,
      @required this.bloc,
      @required this.context});
}

class GetMapPageData extends ShuttleEvent {
  const GetMapPageData(
      {@required context,
      @required animatedMapMove,
      @required theme,
      @required bloc})
      : super(
            context: context,
            animatedMapMove: animatedMapMove,
            theme: theme,
            bloc: bloc);

  @override
  List<Object> get props => [context, animatedMapMove, theme, bloc];
}

class GetRoutesPageData extends ShuttleEvent {
  const GetRoutesPageData();

  @override
  List<Object> get props => [context, animatedMapMove, theme, bloc];
}
