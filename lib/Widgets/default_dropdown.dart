import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genius_wallet/app_helper/extensions.dart';

import '../gen/assets.gen.dart';
import '../main.dart';
import '../theme/app_color.dart';
import 'default_textfield.dart';

class DefaultDropDown<T> extends StatelessWidget {
  final DropdownSearchItemAsString<T>? itemAsString;
  final T? selectedItem;
  final List<T> items;
  final DropdownSearchCompareFn<T>? compareFn;
  final String? label,hint;
  final ValueChanged<T?>? onChanged;
  final bool enableValidation;
  final bool labelAsTitle;

  const DefaultDropDown({
    this.itemAsString,
    this.selectedItem,
    this.items = const [],
    this.compareFn,
    this.hint,
    this.label,
    this.onChanged,
    this.enableValidation = true,
    this.labelAsTitle = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Visibility(
          visible: labelAsTitle,
          child: Padding(
            padding: EdgeInsets.only(bottom: 6.r),
            child: Text(
                label ?? '',
                style: appTheme().textTheme.bodyLarge
            ),
          )),
        DropdownSearch<T>(
          dropdownButtonProps: DropdownButtonProps(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            constraints: BoxConstraints(
              maxHeight: 0.5.sh,
            ),
          ),
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            /*menuProps: MenuProps(
              backgroundColor: AppColor.dropdownBackground + AppColor.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r),),
            ),*/
            showSelectedItems: true,
            itemBuilder: (context, item, isSelected) {
              String value = itemAsString!=null ? itemAsString!(item) : item.toString();
              return ListTile(title: Text(value,
                style: appTheme()
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: isSelected ? AppColor.primary : AppColor.textColor, fontSize: 16.sp)
                )
              );
            },
          ),
          items: items,
          selectedItem:  selectedItem,
          itemAsString: itemAsString,
          compareFn: compareFn,
          dropdownDecoratorProps: dropdownDecoration(
            hint: hint ?? label ?? '',
            label: labelAsTitle
                  ? null
                  : label ?? '',
            borderRadius: 8.r
          ),
          onChanged: onChanged,
          validator: enableValidation ? (value) {
            if (value == null) {
              return '${label ?? hint}${appLanguage(context).required}';
            } else {
              return null;
            }
          } : null,
        ),
      ],
    );
  }
}
