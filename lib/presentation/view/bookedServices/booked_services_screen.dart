import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/bookedServices/active_order_screen..dart';
import 'package:handy_home_app/presentation/view/bookedServices/all_order_screen.dart';

import 'BookedServicesComponents/ordered_tab_button_widget.dart';

class BookedServiceScreen extends StatefulWidget {
  const BookedServiceScreen({Key? key}) : super(key: key);

  @override
  State<BookedServiceScreen> createState() => _BookedServiceScreenState();
}

class _BookedServiceScreenState extends State<BookedServiceScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الطلبات',
              style: StyleManger.headline1(fontSize: 22),
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              children: [
                OrderedTabButtonWidget(
                  text: 'الطلبات الفعالة',
                  index: 0,
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  selectedIndex: index,
                ),
                const SizedBox(
                  width: 7,
                ),
                OrderedTabButtonWidget(
                  text: 'كل الطلبات',
                  index: 1,
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  selectedIndex: index,
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            [
              const ActiveOrderScreen(),
              const AllOrderScreen(),
            ][index],
          ],
        ),
      ),
    );
  }
}
