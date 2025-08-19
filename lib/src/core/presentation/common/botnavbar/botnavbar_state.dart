import 'package:flutter/foundation.dart';

@immutable
class BotNavBarState {
  final int index;
  const BotNavBarState({this.index = 0});

  BotNavBarState copyWith({int? index}) => BotNavBarState(index: index ?? this.index);
}
