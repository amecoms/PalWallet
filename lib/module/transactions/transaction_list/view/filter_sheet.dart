import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/default_button.dart';
import 'package:genius_wallet/Widgets/default_dropdown.dart';
import 'package:genius_wallet/Widgets/default_textfield.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/module/transactions/transaction_list/bloc/transaction_list_event.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/transaction_list_bloc.dart';
import '../bloc/transaction_list_state.dart';

class FilterSheet extends StatefulWidget {
  final TransactionListBloc bloc;
  const FilterSheet(this.bloc,{super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  ValueNotifier<bool> haveId = ValueNotifier(false);
  String? remarks;
  TextEditingController trxId = TextEditingController();
  @override
  void initState() {
    remarks = widget.bloc.state.selectedRemark ?? 'all_remarks';
    trxId.text = widget.bloc.state.trxId ?? '';
    trxId.addListener(() {
      haveId.value = trxId.text.isEmpty ? false : true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionListBloc, TransactionListState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(20.r),
              topStart: Radius.circular(20.r),
            ),
            color: AppColor.white,
          ),
          padding: REdgeInsets.only(bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  16.verticalSpace,
                  Text(
                    appLanguage(context).filter,
                    style: appTheme(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 20.spMin
                    ),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultDropDown<String>(
                          items: ['all_remarks',...state.transfers!.response!.remarkList!],
                          labelAsTitle: true,
                          selectedItem: remarks,
                          label: appLanguage(context).remark,
                          hint: appLanguage(context).remark,
                          itemAsString: (value)=> value.replaceAll('_', ' ').capitalize,
                          onChanged: (value){
                            remarks = value == 'all_remarks' ? null : value;
                          },
                        ),
                        16.verticalSpace,
                        DefaultTextField(
                          controller: trxId,
                          label: appLanguage(context).transaction_id,
                          hint: appLanguage(context).transaction_id,
                          labelAsTitle: true,
                          suffixIcon: ValueListenableBuilder<bool>(
                            valueListenable: haveId,
                            builder: (context, value, child){
                              return Visibility(
                                visible: value,
                                child: InkWell(
                                  onTap: (){
                                    trxId.clear();
                                  },
                                  child: Icon(Icons.cancel,color: AppColor.red,),
                                ),
                              );
                            },
                          ),
                        ),
                        16.verticalSpace,
                        DefaultButton(
                          onTap: (){
                            backPage();
                            widget.bloc.add(ChangeFilter(remarks!= 'all_remarks' ? remarks : '', trxId.text));
                          },
                          child: Center(
                            child: Text(
                              appLanguage(context).apply,
                              style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                fontWeight: Dimension.textSemiBold,
                                fontSize: 17.spMin,
                                color: AppColor.white
                              ),
                            )
                          )
                        )
                      ],
                    ),
                  ),
                  Dimension.bottomSpace
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                    onPressed: () => backPage(),
                    icon: Icon(Icons.close_rounded,
                        color: AppColor.iconColor)),
              )
            ],
          ),
        );
      },
    );
  }
}
