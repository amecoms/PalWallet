import '../../../../app_helper/enums.dart';
import '../data/withdraw_from.dart';
import '../data/withdraw_method.dart';


class WithdrawMoneyState {
  WithdrawFrom? moneyFrom;
  Wallets? selectedWallets;
  PageState pageState;
  WithdrawMethod? methods;
  Methods? selectedMethods;


  WithdrawMoneyState({this.moneyFrom, this.selectedMethods, this.methods, this.selectedWallets, this.pageState = PageState.Initial});

  WithdrawMoneyState init() {
    return WithdrawMoneyState();
  }

  WithdrawMoneyState clone({WithdrawFrom? moneyFrom, Methods? selectedMethods, WithdrawMethod? methods, Wallets? selectedWallets, PageState? pageState}) {
    return WithdrawMoneyState(
      moneyFrom: moneyFrom ?? this.moneyFrom,
      methods: methods ?? this.methods,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      pageState: pageState ?? this.pageState,
      selectedMethods: selectedMethods ?? this.selectedMethods
    );
  }
}
