import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_wallet/Widgets/get_image.dart';
import 'package:genius_wallet/app_helper/helper.dart';
import 'package:genius_wallet/module/escrow/escrow_dispute/data/escrow_dispute.dart';
import 'package:genius_wallet/repositories/escrow_repository.dart';
import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import '../../../../utils/app_constant.dart';
import 'escrow_dispute_event.dart';
import 'escrow_dispute_state.dart';


class EscrowDisputeBloc extends Bloc<EscrowDisputeEvent, EscrowDisputeState> {
  EscrowRepository repository = EscrowRepository();
  ScrollController scrollController = ScrollController();
  TextEditingController message = TextEditingController();

  EscrowDisputeBloc() : super(EscrowDisputeState().init()) {
    on<InitEvent>(_init);
    on<SendMessageEvent>(_sendMessage);
    on<GetReply>(_getReply);
    on<AttachFile>(_attachFile);
    on<DownloadFile>(_downloadFile);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<EscrowDisputeState> emit) async {
    emit(state.clone(
        channelId: settings(event.context).arguments as String
    ));
    add(GetReply());
  }

  FutureOr<void> _sendMessage(SendMessageEvent event, Emitter<EscrowDisputeState> emit) async {
    if(message.text.isEmpty) return;
    emit(state.clone(pageState: PageState.Loading));

    Map<String,String> body={
      AppConstant.message:message.text,
    };
    await repository.submitDispute(
        id: state.channelId!,
        body: body,
        files: state.messageFile!=null ? [state.messageFile!] : [],
        fileKeys: state.messageFile!=null ? ['file'] : [],
        onSuccess: (data) {
          message.clear();
          state.messageFile = null;
          state.messages!.response!.messages!.add(Messages.fromJson(data['response']['message']));
        },
        onError: (data){

        }
    );
    emit(state.clone(pageState: PageState.Success));
    _scrollDown();
  }

  FutureOr<void> _getReply(GetReply event, Emitter<EscrowDisputeState> emit) async {
    await repository.getEscrowDispute(
        id: state.channelId!,
        onSuccess: (data) {
          //data.response!.messages = data.response!.messages!.reversed.map((e) => e).toList();
          emit(state.clone(messages: data,pageState: PageState.Success));
        },
        onError: (data){
          emit(
            state.clone(
              pageState: PageState.Error,
            ),
          );
        }
    );
    _scrollDown(isJump: true);
  }

  FutureOr<void> _attachFile(AttachFile event, Emitter<EscrowDisputeState> emit) async {
    File? image = await getImage();
    if(image!=null){
      emit(state.clone(messageFile: image));
    }
  }

  void _scrollDown({bool isJump = false}) {
    if(scrollController.hasClients) {
      Timer(const Duration(milliseconds: 300),(){
        if(isJump){
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        } else {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 300),
          );
        }
      });
    }
  }

  FutureOr<void> _downloadFile(DownloadFile event, Emitter<EscrowDisputeState> emit) async {
    Helper.goBrowser(event.url);
  }
}
