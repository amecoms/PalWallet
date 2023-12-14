import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/default_appbar.dart';
import 'package:genius_wallet/Widgets/default_button.dart';
import 'package:genius_wallet/Widgets/default_dropdown.dart';
import 'package:genius_wallet/Widgets/default_textfield.dart';
import 'package:genius_wallet/app_helper/enums.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/app_helper/validator.dart';
import 'package:genius_wallet/main.dart';
import 'package:genius_wallet/module/deposit/deposit_money/data/gateways.dart';
import 'package:genius_wallet/module/invoice/create_invoice/data/invoice_currency.dart';
import 'package:genius_wallet/routes/app_pages.dart';
import 'package:genius_wallet/theme/app_color.dart';
import 'package:genius_wallet/utils/dimension.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../bloc/create_invoice_bloc.dart';
import '../bloc/create_invoice_event.dart';
import '../bloc/create_invoice_state.dart';

class CreateInvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreateInvoiceBloc()..add(InitEvent(context)),
      child: BlocBuilder<CreateInvoiceBloc, CreateInvoiceState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, CreateInvoiceState state) {
    final bloc = BlocProvider.of<CreateInvoiceBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).create_invoice
      ),
      body: Form(
        key: bloc.formKey,
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              DefaultTextField(
                controller: bloc.invoiceTo,
                label: appLanguage(context).invoice_to,
                hint: appLanguage(context).invoice_to,
                labelAsTitle: true,
              ),
              16.verticalSpace,
              DefaultTextField(
                controller: bloc.recipientEmail,
                label: appLanguage(context).recipient_email,
                hint: appLanguage(context).recipient_email,
                labelAsTitle: true,
                textInputType: TextInputType.emailAddress,
                validator: Validator.emailValidator,
              ),
              16.verticalSpace,
              DefaultTextField(
                controller: bloc.address,
                label: appLanguage(context).address,
                hint: appLanguage(context).address,
                labelAsTitle: true,
              ),
              16.verticalSpace,
              if(state.moneyFrom != null)
                DefaultDropDown<Currencies>(
                  items: state.moneyFrom!.response!.currencies!,
                  compareFn: (a,b)=> a.id == b.id,
                  itemAsString: (a)=> a.code!,
                  selectedItem: state.selectedWallets,
                  label: appLanguage(context).select_wallet,
                  hint: appLanguage(context).select,
                  labelAsTitle: true,
                  onChanged: (value)=> bloc.add(ChangeWallets(value)),
                ),
              16.verticalSpace,
              Text(appLanguage(context).items,style: appTheme(context).textTheme.headlineLarge,),
              8.verticalSpace,
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bloc.itemAmounts.length,
                itemBuilder: (ctx, index){
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColor.dividerColor),
                          color: AppColor.textFieldBackground
                        ),
                        padding: REdgeInsets.all(16),
                        margin: REdgeInsets.only(bottom: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DefaultTextField(
                              controller: bloc.itemNames[index],
                              label: appLanguage(context).item_name,
                              hint: appLanguage(context).item_name,
                              backgroundColor: AppColor.background,
                              labelAsTitle: true,
                            ),
                            8.verticalSpace,
                            DefaultTextField(
                              controller: bloc.itemAmounts[index],
                              label: appLanguage(context).amount,
                              hint: appLanguage(context).amount,
                              backgroundColor: AppColor.background,
                              labelAsTitle: true,
                              textInputType: const TextInputType.numberWithOptions(decimal: true,),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ],
                        ),
                      ),
                      if(index != 0)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: ()=> bloc.add(ChangeItems(removeIndex: index)),
                            icon: Icon(Icons.cancel,color: AppColor.red,),
                          ),
                        )
                    ],
                  );
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: bloc.totalAmount,
                builder: (context, value, child){
                  return Text(
                    '${appLanguage(context).total_amount.capitalize}: $value ${state.selectedWallets?.code ?? ''}',
                    style: appTheme(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: Dimension.textMedium
                    ),
                  );
                }
              ),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultButton(
                    onTap: ()=> bloc.add(ChangeItems()),
                    padding: REdgeInsets.symmetric(horizontal: 16,vertical:12),
                    buttonType: ButtonType.BORDER,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add,color: AppColor.primary,),
                        4.horizontalSpace,
                        Text(
                          appLanguage(context).add_item,
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: Dimension.textRegular,
                              color: AppColor.primary
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
              if(state.isEdit)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            onTap: ()=> bloc.add(SendEmail()),
                            enable: state.moneyFrom != null,
                            isLoading: state.sendEmailState == PageState.Loading,
                            backgroundColor: Colors.blue,
                            child: Center(
                              child: Text(
                                appLanguage(context).send_to_email,
                                style: appTheme(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16.spMin,
                                    color: AppColor.white
                                ),
                              ),
                            )
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: DefaultButton(
                            onTap: ()=> bloc.add(CancelInvoice()),
                            enable: state.moneyFrom != null,
                            isLoading: state.cancelInvoiceState == PageState.Loading,
                            backgroundColor: AppColor.red,
                            child: Center(
                              child: Text(
                                appLanguage(context).cancel_invoice,
                                style: appTheme(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16.spMin,
                                    color: AppColor.white
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              24.verticalSpace,
              DefaultButton(
                onTap: ()=> bloc.add(SubmitTransfer()),
                enable: state.moneyFrom != null,
                isLoading: state.pageState == PageState.Loading,
                child: Center(
                  child: Text(
                    state.isEdit ? appLanguage(context).update : appLanguage(context).create_invoice,
                    style: appTheme(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.spMin,
                      color: AppColor.white
                    ),
                  ),
                )
              ),
              Dimension.bottomSpace
            ],
          ),
        ),
      ),
    );
  }

}

