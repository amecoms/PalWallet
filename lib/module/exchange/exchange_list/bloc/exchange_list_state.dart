import '../../../../app_helper/enums.dart';
import '../data/exchange_list.dart';

class ExchangeListState {
  ExchangeList? transfers;
  PageState pageState;


  ExchangeListState({this.transfers, this.pageState = PageState.Loading});

  ExchangeListState init() {
    return ExchangeListState();
  }

  ExchangeListState clone({ExchangeList? transfers, PageState? pageState}) {
    return ExchangeListState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
