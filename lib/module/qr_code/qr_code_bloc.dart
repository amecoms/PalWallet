import 'package:bloc/bloc.dart';
import 'package:genius_wallet/repositories/user_repository.dart';

import 'qr_code_event.dart';
import 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  UserRepository repository = UserRepository();

  QrCodeBloc() : super(QrCodeState().init()) {
    on<InitEvent>(_init);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<QrCodeState> emit) async {
    await repository.getQrCode(
      onSuccess: (data){
        emit(state.clone(qrData: data));
      },
      onError: (data){}
    );
  }
}
