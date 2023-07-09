import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/customwidget/custom_button_with_background_widget.dart';
import 'package:handy_home_app/data/models/become_service_provider_info_mdoel.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';

import '../home/category_screen.dart';

class BecomeServiceProviderInfoScreen extends StatefulWidget {
  const BecomeServiceProviderInfoScreen({Key? key}) : super(key: key);

  @override
  State<BecomeServiceProviderInfoScreen> createState() =>
      _BecomeServiceProviderInfoScreenState();
}

class _BecomeServiceProviderInfoScreenState
    extends State<BecomeServiceProviderInfoScreen> {
  bool isScroll = false;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        isScroll = scrollController.offset > 0;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 10, right: 30),
            child: CustomHeaderWidget(
              title: 'انضم الينا كمقدم خدمة!',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              children: [
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            'هل أنت محترف ماهر يبحث عن فرص لتطوير عملك والوصول للمزيد من العملاء؟ انضم إلى منصتنا كمقدم خدمة وكن جزءًا من شبكتنا الموثوقة. استفد من تدفق ثابت من طلبات الخدمة وفرصة لعرض خبرتك.'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'لماذا الانضمام إلينا؟',
                          style: StyleManger.headline1(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...becomeServiceProviderInfoModel
                            .map(
                              (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '• ${e.title}',
                                    style: StyleManger.headline1(fontSize: 14),
                                  ),
                                  Text(
                                    e.details,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          CustomButtonWithBackgroundWidget(
            text: 'تقديم طلب الانضمام!',
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -3),
                blurRadius: 10,
                color: Colors.grey.shade400,
              )
            ],
            onPressed: () {
              NavigationManager.pushNamed(
                  RouteConstants.becomeServiceProviderApplicationScreen);
            },
          )
        ],
      ),
    );
  }
}
