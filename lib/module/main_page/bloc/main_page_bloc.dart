import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app_helper/enums.dart';
import '../../../../module/main_page/data/dashboard.dart';
import '../../../../repositories/main_page_repository.dart';
import '../../../../repositories/user_repository.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../data/auth.dart';
import 'main_page_event.dart';
import 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageRepository repository = MainPageRepository();
  UserRepository userRepository = UserRepository();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  RefreshController refreshController = RefreshController();
  ValueNotifier<bool> amountVisibility = ValueNotifier(false);

  MainPageBloc() : super(MainPageState().init()) {
    on<InitEvent>(_init);
    on<GetDashboard>(_getAuthUser);
    on<UpdateUser>(_updateUser);
  }

  void _init(InitEvent event, Emitter<MainPageState> emit) async {
    add(GetDashboard());
    await userRepository.getSettings(
        onSuccess: (data){
          emit(state.clone(settings: data));
        },
        onError: (data){}
    );
  }

  @override
  Future<void> close() {
    repository.close();
    userRepository.close();
    return super.close();
  }

  Future _getAuthUser(GetDashboard event, Emitter<MainPageState> emit) async {
    await repository.getDashboardData(
        onSuccess: (Dashboard data){
          emit(state.clone(dashboard: data,pageState: PageState.Success));
        },
        onError: (Map<String,dynamic> data){

        }
    );
    refreshController.refreshCompleted();
  }

  FutureOr<void> _updateUser(UpdateUser event, Emitter<MainPageState> emit) {
    emit(state.clone(user: Auth.getAuth()!.response!.user!));
  }

}
