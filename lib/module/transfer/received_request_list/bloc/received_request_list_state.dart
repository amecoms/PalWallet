
import '../../../../app_helper/enums.dart';
import '../data/request_list.dart';

class ReceivedRequestListState {
  RequestList? transfers;
  PageState pageState;


  ReceivedRequestListState({this.transfers, this.pageState = PageState.Loading});

  ReceivedRequestListState init() {
    return ReceivedRequestListState();
  }

  ReceivedRequestListState clone({RequestList? transfers, PageState? pageState}) {
    return ReceivedRequestListState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
