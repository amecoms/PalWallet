import '../../../../app_helper/enums.dart';
import '../data/tickets.dart';

class SupportListState {
  Tickets? tickets;
  PageState pageState;


  SupportListState({this.tickets, this.pageState = PageState.Loading});

  SupportListState init() {
    return SupportListState();
  }

  SupportListState clone({Tickets? tickets, PageState? pageState}) {
    return SupportListState(
      pageState: pageState ?? this.pageState,
      tickets: tickets ?? this.tickets
    );
  }
}
