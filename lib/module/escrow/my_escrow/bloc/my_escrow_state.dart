import 'package:genius_wallet/module/escrow/my_escrow/data/escrow_list.dart';

import '../../../../app_helper/enums.dart';

class MyEscrowState {
  EscrowList? transfers;
  PageState pageState;


  MyEscrowState({this.transfers, this.pageState = PageState.Loading});

  MyEscrowState init() {
    return MyEscrowState();
  }

  MyEscrowState clone({EscrowList? transfers, PageState? pageState}) {
    return MyEscrowState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
