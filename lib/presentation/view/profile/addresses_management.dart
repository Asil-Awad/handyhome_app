import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import '../../../customwidget/custom_button_with_background_widget.dart';
import '../../resources/color_manager.dart';
import '../home/category_screen.dart';
import 'ProfileComponents/add_address_bottom_sheet.dart';

class AddressesManagementScreen extends StatelessWidget {
  const AddressesManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 10, right: 30),
            child: CustomHeaderWidget(
              title: 'إدارة العناوين',
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              itemBuilder: (context, index) => Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'المنزل',
                            style: StyleManger.headline1(fontSize: 14),
                          ),
                          const Spacer(),
                          CustomIconButton(
                              backgroundColor: ColorManager.background,
                              iconColor: Colors.grey,
                              icon: Icons.edit,
                              onTap: () {
                                print('edit');
                              }),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomIconButton(
                            backgroundColor: ColorManager.redLightColor,
                            iconColor: ColorManager.redDarkColor,
                            icon: Icons.delete,
                            onTap: () {
                              print('delete');
                            },
                          )
                        ],
                      ),
                      const Text('فلسطين٬ غزة٬ شارع الشهداء'),
                      const Text('الحساينة هوم٬ 19'),
                      const Text('0594070068')
                    ],
                  ),
                ),
              ),
              itemCount: 10,
            ),
          ),
          CustomButtonWithBackgroundWidget(
            text: '+ إضافة عنوان جديد',
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -3),
                blurRadius: 10,
                color: Colors.grey.shade400,
              )
            ],
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                clipBehavior: Clip.antiAlias,
                context: context,
                builder: (context) => const AddAddressBottomSheet(),
              );
            },
          )
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 25,
          width: 25,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ));
  }
}
