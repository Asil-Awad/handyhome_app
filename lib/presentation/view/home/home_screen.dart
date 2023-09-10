import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:skeletons/skeletons.dart';

import '../../../bussiness logic/homeCubit/home_cubit.dart';
import 'HomeComponents/home_category_lable_widget.dart';
import 'HomeComponents/home_horizontal_category_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().categories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 30,
          ),
          children: [
            Text(
              'الرئيسية',
              style: StyleManger.headline1(),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return GridView.builder(
                    padding: const EdgeInsets.only(top: 21),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      if (state is CategoryLoadingState) {
                        return SkeletonItem(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.all(5),
                        ));
                      }
                      if (state is CategorySuccessState) {
                        return InkWell(
                          onTap: () {
                            NavigationManager.pushNamed(
                                RouteConstants.categoryRoute);
                          },
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(state.categories[index].icon),
                                Text(
                                  state.categories[index].name,
                                  style: StyleManger.headline1(fontSize: 14),
                                ),
                                Text(
                                    '${state.categories[index].countServices} خدمات فرعية')
                              ],
                            ),
                          ),
                        );
                      }
                      return Image.asset(ImagePath.cleaningImage);
                    });
              },
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImagePath.customServiceImage),
                    Text(
                      'لم تعثر على الخدمة المطلوبة؟',
                      style: StyleManger.headline1(fontSize: 14),
                    ),
                    const Text(
                      'يمكنك طلب خدمة مخصصة بما يتوافق مع احتياجاتك باضافة كافة التفاصيل حول الخدمة المطلوبة.',
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NavigationManager.pushNamed(
                            RouteConstants.orderCustomServiceRoute);
                      },
                      child: const Text('طلب خدمة مخصصة'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        HomeCategoryLabelWidget(
          title: 'الأكثر طلباً',
          onPressed: () {},
        ),
        const HomeHorizontalCategoryWidget(),
        const SizedBox(
          height: 10,
        ),
        HomeCategoryLabelWidget(
          title: 'المضافة حديثاً',
          onPressed: () {},
        ),
        const HomeHorizontalCategoryWidget(),
      ],
    );
  }
}
