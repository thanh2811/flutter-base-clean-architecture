import 'package:base_project/view/widgets/loading.dart';
import 'package:base_project/view/widgets/primary_button.dart';
import 'package:base_project/view/widgets/primary_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/model/customer/customer_info_response.dart';
import '../../data/model/location.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/strings.dart';
import '../../data/resources/themes.dart';
import 'drop_down_list_primary.dart';

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

Dialog getShowSelectionDialog({required List<dynamic> data}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 400, minHeight: 200),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.pop(context, data[index]),
                  title: Text(
                    (data[index] is CustomerGroup)
                        ? data[index].customerGroupName
                        : data[index] is CustomerType
                            ? data[index].customerTypeName
                            : data[index] is Channel
                                ? data[index].channelName
                                : null,
                    style: AppTextTheme.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Dialog getLoadingDialog() {
  return Dialog(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SpinKitFadingCircle(
          color: AppColor.white,
          duration: Duration(milliseconds: 500),
        ),
      ],
    ),
  );
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
            style: AppTextTheme.textPageTitle,
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

// share the common Customer filter dialog
Dialog getCustomerFilterDialog({
  required List<CustomerGroup> customerGroups,
  required List<CustomerType> customerTypes,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: CustomerFilterDialog(
      routes: const ['Tất cả tuyến đường', 'Khách hàng hiện tại'],
      visitStatus: const [
        'Trạng thái viếng thăm',
        'Đã viếng thăm',
        'Chưa viếng thăm'
      ],
      distances: const [
        'Sắp xếp theo khoảng cách',
      ],
      customerType: [
        'Loại khách hàng',
        ...customerTypes.map((e) => e.customerTypeName.toString()).toList()
      ],
      groupTypes: [
        'Nhóm khách hàng',
        ...customerGroups.map((e) => e.customerGroupName.toString()).toList()
      ],
    ),
  );
}

// ignore: must_be_immutable
class CustomerFilterDialog extends StatelessWidget {
  CustomerFilterDialog({
    Key? key,
    this.onChanged,
    this.routes,
    this.visitStatus,
    this.distances,
    this.customerType,
    this.groupTypes,
  }) : super(key: key);
  List<String>? routes;
  List<String>? visitStatus;
  List<String>? distances;
  List<String>? customerType;
  List<String>? groupTypes;
  Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            titleDialogFilterCustomer,
            style: AppTextTheme.textPageTitle,
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: AppColor.green,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            subTitleDialogFilterCustomer,
            style: AppTextTheme.textStyleSubTitle,
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryDropDownList(
            items: routes ?? [],
            value: routes?[0],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryDropDownList(
            items: visitStatus ?? [],
            value: visitStatus?[0],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryDropDownList(
            items: distances ?? [],
            value: distances?[0],
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryDropDownList(
            items: customerType ?? [],
            value: customerType?[0],
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryDropDownList(
            items: groupTypes ?? [],
            value: groupTypes?[0],
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryButton(
                context: context,
                onPressed: () {},
                label: 'Mặc định',
                icon: Icons.update,
                backgroundColor: AppColor.blue,
              ),
              PrimaryButton(
                context: context,
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                label: 'Tìm kiếm',
                icon: Icons.search,
                backgroundColor: AppColor.green,
              ),
            ],
          ),
        )
      ],
    );
  }
}
