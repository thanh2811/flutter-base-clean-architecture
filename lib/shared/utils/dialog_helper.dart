import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/constant/enum.dart';
import '../../data/model/public_api/location.dart';
import '../../data/resources/resources.dart';
import '../../main.dart';
import '../widgets/button/primary_button.dart';
import '../widgets/something/loading.dart';
import '../widgets/text_field/primary_search_text_field.dart';

Dialog getAddressDialog({required List<dynamic> data}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      height: 400,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: data.isNotEmpty
          ? data.isEmpty
              ? AddressDialogUi(data: data)
              : const Loading(
                  size: 30,
                )
          : const Loading(
              size: 30,
            ),
    ),
  );
}

// ignore: must_be_immutable
class AddressDialogUi extends StatefulWidget {
  AddressDialogUi({
    Key? key,
    required this.data,
  }) : super(key: key);

  List<dynamic> data;

  @override
  State<AddressDialogUi> createState() => _AddressDialogUiState();
}

class _AddressDialogUiState extends State<AddressDialogUi> {
  TextEditingController controller = TextEditingController();
  late List<dynamic> tmpData;

  @override
  void initState() {
    tmpData = List.from(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    search(String? value) {
      // log(tmpData.toString());
      setState(() {
        tmpData.clear();
        tmpData.addAll(
          widget.data
              .where((element) => (element is Province ||
                      element is District ||
                      element is Ward)
                  ? element.name
                          ?.toString()
                          .toLowerCase()
                          .contains(value.toString().toLowerCase()) ??
                      false
                  : false)
              .toList(),
        );
      });
    }

    return Column(
      children: [
        PrimarySearchTextField(
          label: 'Tìm kiếm',
          controller: controller,
          onChanged: (value) => search(value),
          debounce: 0,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: tmpData.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () => Navigator.pop(context, tmpData[index]),
              title: Text(
                tmpData[index] is Province
                    ? tmpData[index].name.toString()
                    : tmpData[index] is District
                        ? tmpData[index].name.toString()
                        : (tmpData[index] as Ward).name.toString(),
                style: AppTextTheme.textPrimary,
              ),
            ),
          ),
        )
      ],
    );
  }
}

// Dialog getShowSelectionDialog({required List<dynamic> data}) {
//   return Dialog(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     child: ConstrainedBox(
//       constraints: const BoxConstraints(maxHeight: 400, minHeight: 200),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: data.length,
//                 itemBuilder: (context, index) => ListTile(
//                   onTap: () => Navigator.pop(context, data[index]),
//                   title: Text(
//                     (data[index] is CustomerGroup)
//                         ? data[index].customerGroupName
//                         : data[index] is CustomerType
//                             ? data[index].customerTypeName
//                             : data[index] is Channel
//                                 ? data[index].channelName
//                                 : null,
//                     style: AppTextTheme.textPrimary,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

Dialog getLoadingDialog() {
  return Dialog(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Loading(),
      ],
    ),
  );
}

Dialog getErrorDialog({
  required BuildContext context,
  required String message,
}) {
  return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColor.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.iconAppError,
                  height: 100,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  message,
                  style: AppTextTheme.textPrimary,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                PrimaryButton(
                  context: context,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: 'Đóng',
                  backgroundColor: AppColor.errorColor,
                ),
              ],
            ),
          ),
        ],
      ));
}

Dialog getAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
}) {
  return Dialog(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextTheme.textPrimaryBold,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            message,
            style: AppTextTheme.textPrimary,
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryButton(
                context: context,
                onPressed: () {
                  Navigator.pop(context);
                },
                label: 'Đóng',
                backgroundColor: AppColor.secondaryColor,
              ),
              PrimaryButton(
                  context: context,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  label: 'Đồng ý')
            ],
          )
        ],
      ),
    ),
  );
}

void showGlobalDialog(
    {required String message,
    DialogType dialogType = DialogType.alert,
    Function(dynamic value)? callbackWhenDismiss}) async {
  switch (dialogType) {
    case DialogType.alert:
      await showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => getErrorDialog(
          context: context,
          message: message,
        ),
      ).then((value) =>
          callbackWhenDismiss != null ? callbackWhenDismiss(value) : null);
      break;
    case DialogType.datePicker:
      break;
  }
}
