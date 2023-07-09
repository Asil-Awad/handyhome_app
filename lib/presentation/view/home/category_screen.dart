import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/home_horizontal_category_widget.dart';
import '../../../customwidget/search_custom_widget.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 18, left: 30, right: 30),
        child: Column(
          children: [
            const CustomHeaderWidget(title: 'خدمات السباكة'),
            const SizedBox(
              height: 16,
            ),
            const SearchCustomWidget(),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 30,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    NavigationManager.pushNamed(
                        RouteConstants.serviceDetailsRoute);
                  },
                  child: const SingleServiceWidget(
                    width: double.infinity,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CardForIconWidget(
          icon: Icon(
            Icons.arrow_back,
            color: ColorManager.brownColor,
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: StyleManger.headline1(),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

class CardForIconWidget extends StatelessWidget {
  const CardForIconWidget({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
          onPressed: () {
            NavigationManager.pop();
          },
          icon: icon),
    );
  }
}
