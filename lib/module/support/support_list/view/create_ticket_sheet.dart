import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_wallet/Widgets/default_textfield.dart';
import 'package:genius_wallet/app_helper/extensions.dart';
import 'package:genius_wallet/module/support/support_list/bloc/support_list_event.dart';
import 'package:intl/intl.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/support_list_bloc.dart';

class CreateTicketSheet extends StatelessWidget {
  final SupportListBloc bloc;
  CreateTicketSheet(this.bloc,{super.key});
  TextEditingController ticketSubject = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(20.r),
          topStart: Radius.circular(20.r),
        ),
        color: AppColor.white,
      ),
      padding: REdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: formKey,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.verticalSpace,
                Text(appLanguage(context).open_a_ticket,style: appTheme(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: Dimension.textSemiBold,
                    fontSize: 17.spMin
                ),),
                20.verticalSpace,
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: DefaultTextField(
                    controller: ticketSubject,
                    hint: appLanguage(context).subject,
                    label: appLanguage(context).subject,
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: DefaultButton(
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        backPage();
                        bloc.add(OpenTicket(ticketSubject.text));
                      }
                    },
                    padding: REdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(appLanguage(context).create,
                        style: appTheme(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 17.spMin,
                            fontWeight: Dimension.textSemiBold,
                            color: AppColor.white
                        ),
                      ),
                    ),
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
      ),
    );
  }
}
