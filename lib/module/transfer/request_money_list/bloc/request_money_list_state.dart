
import '../../../../app_helper/enums.dart';
import '../data/request_list.dart';

class RequestMoneyListState {
  RequestList? transfers;
  PageState pageState;


  RequestMoneyListState({this.transfers, this.pageState = PageState.Loading});

  RequestMoneyListState init() {
    return RequestMoneyListState();
  }

  RequestMoneyListState clone({RequestList? transfers, PageState? pageState}) {
    return RequestMoneyListState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
