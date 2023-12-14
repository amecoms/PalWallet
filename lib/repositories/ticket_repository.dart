import 'dart:io';

import 'package:genius_wallet/module/exchange/exchange_list/data/exchange_list.dart';
import 'package:genius_wallet/module/support/support_details/data/support_messages.dart';

import '../app_helper/api_client.dart';
import '../module/exchange/exchange_money/data/exchange_data.dart' as ED;
import '../module/support/support_list/data/tickets.dart';
import '../utils/url.dart';

class TicketRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future openTicket({String? subject, required Function(Map<String,dynamic> data) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.openTickets,
      method: Method.POST,
      body: {
        'subject': subject
      },
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future getTicketList({String? url, required Function(Tickets) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url ?? URL.tickets,
      onSuccess: (Map<String,dynamic> data) {
        Tickets transfers = Tickets.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future submitReply({
    required String id,
    required Map<String, String> body,
    required List<String> fileKeys,
    required List<File> files,
    required Function(Map<String,dynamic>) onSuccess,
    required Function(Map<String,dynamic>) onError}) async {
    await apiClient.RequestWithFile(
        url: URL.ticketReply+id,
        body: body,
        method: Method.POST,
        fileKey: fileKeys,
        files: files,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(data);
        },
        onError: onError
    );
  }

  Future getMessages({required String ticketNumber, required Function(SupportMessages) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.ticketMessages + ticketNumber,
      onSuccess: (Map<String,dynamic> data) {
        SupportMessages transfers = SupportMessages.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

}