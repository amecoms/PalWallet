import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/circular_progress.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/module/invoice/invoice_list/bloc/invoice_list_bloc.dart';
import 'package:genius_wallet/module/invoice/invoice_list/bloc/invoice_list_event.dart';
import 'package:intl/intl.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/invoice_list_state.dart';
import '../data/invoice_history.dart';

class InvoiceDetailsSheet extends StatefulWidget {
  final InvoiceData data;
  final InvoiceListBloc bloc;

  const InvoiceDetailsSheet(this.data, this.bloc, {super.key});

  @override
  State<InvoiceDetailsSheet> createState() => _InvoiceDetailsSheetState();
}

class _InvoiceDetailsSheetState extends State<InvoiceDetailsSheet> {
  @override
  void initState() {
    widget.bloc.add(GetInvoiceDetails(widget.data.number!));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceListBloc, InvoiceListState>(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  18.verticalSpace,
                  Center(
                    child: Text(
                      widget.data.number ?? '',
                      style: appTheme(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 18.spMin
                      ),
                    ),
                  ),
                  if(state.details != null)
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Text(
                            appLanguage(context).from,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textSemiBold
                            ),
                          ),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  appLanguage(context).address.toUpperCase(),
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                              ),
                              Text(
                                state.details!.response!.fromAddress!.address ?? '',
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ],
                          ),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  appLanguage(context).email.toUpperCase(),
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                              ),
                              Text(
                                state.details!.response!.fromAddress!.email ?? '',
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ],
                          ),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  appLanguage(context).phone_number.toUpperCase(),
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                              ),
                              Text(
                                state.details!.response!.fromAddress!.phone ?? '',
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ],
                          ),
                          8.verticalSpace,
                          Text(
                            appLanguage(context).to,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textSemiBold
                            ),
                          ),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  appLanguage(context).email.toUpperCase(),
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                              ),
                              Text(
                                state.details!.response!.invoice!.email ?? '',
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ],
                          ),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  appLanguage(context).address.toUpperCase(),
                                  style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                                )
                              ),
                              Text(
                                state.details!.response!.invoice!.address ?? '',
                                style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textRegular),
                              )
                            ],
                          ),
                          8.verticalSpace,
                          Divider(thickness: 1,height: 1,color: AppColor.dividerColor,),
                          8.verticalSpace,
                          Text(
                            appLanguage(context).items,
                            style: appTheme(context).textTheme.headlineLarge!.copyWith(
                                fontWeight: Dimension.textSemiBold
                            ),
                          ),
                          8.verticalSpace,
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.details!.response!.invoiceItems!.length,
                            itemBuilder: (context,index){
                              return Card(
                                margin: REdgeInsets.only(bottom: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)
                                ),
                                child: Padding(
                                  padding: REdgeInsets.symmetric(horizontal: 16,vertical: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.details!.response!.invoiceItems![index].name ?? '',
                                          style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium),
                                        )
                                      ),
                                      Text(
                                        '${(state.details!.response!.invoiceItems![index].amount ?? '0').toDouble.toStringAsFixed(1)} ${widget.data.currency!.code}',
                                        style: appTheme(context).textTheme.bodyLarge,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          8.verticalSpace,
                          DefaultButton(
                            onTap: ()=> backPage(),
                            padding: REdgeInsets.symmetric(vertical: 14),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(appLanguage(context).close,
                                style: appTheme(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 17.spMin,
                                    fontWeight: Dimension.textSemiBold,
                                    color: AppColor.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    CircularProgress(height: 0.4.sh, color: AppColor.primary),
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
