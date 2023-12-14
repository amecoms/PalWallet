import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/utils/dimension.dart';
import '../../../../controllers/app_controller/bloc/app_controller_bloc.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  AppControllerBloc? appController;
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> imagePlace = ValueNotifier(false);

  SettingsBloc() : super(SettingsState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<SettingsState> emit) async {
    appController = event.context.read<AppControllerBloc>();
    scrollController.addListener(() {
      imagePlace.value = _horizontalTitlePadding;
    });
    emit(state.clone());
  }
  bool get _horizontalTitlePadding {
    double kCollapsedPadding = Dimension.appbarHeight;
    if (scrollController.hasClients) {
      return ((280 - Dimension.appbarHeight).h - kCollapsedPadding) - scrollController.offset <= 0;
    }
    return false;
  }
}
