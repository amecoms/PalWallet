import 'package:genius_wallet/module/qr_code/data/qr_data.dart';

import '../../data/auth.dart';

class QrCodeState {
  QrData? qrData;
  Auth? auth = Auth.getAuth();

  QrCodeState({this.qrData});

  QrCodeState init() {
    return QrCodeState();
  }

  QrCodeState clone({QrData? qrData}) {
    return QrCodeState(
      qrData: qrData ?? this.qrData
    );
  }
}
