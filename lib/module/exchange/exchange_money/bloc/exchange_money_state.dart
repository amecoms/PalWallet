import '../../../../app_helper/enums.dart';
import '../data/exchange_data.dart';


class ExchangeMoneyState {
  ExchangeData? exchangeData;
  Wallets? selectedWallets;
  Currencies? selectedToWallets;
  PageState pageState;


  ExchangeMoneyState({this.exchangeData, this.selectedWallets, this.selectedToWallets, this.pageState = PageState.Initial});

  ExchangeMoneyState init() {
    return ExchangeMoneyState();
  }

  ExchangeMoneyState clone({ExchangeData? exchangeData, Wallets? selectedWallets, Currencies? selectedToWallets, PageState? pageState}) {
    return ExchangeMoneyState(
      exchangeData: exchangeData ?? this.exchangeData,
      selectedWallets: selectedWallets ?? this.selectedWallets,
      selectedToWallets: selectedToWallets ?? this.selectedToWallets,
      pageState: pageState ?? this.pageState
    );
  }
}
