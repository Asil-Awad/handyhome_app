import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/home_horizontal_category_widget.dart';
import '../../../customwidget/search_custom_widget.dart';
import '../../../bussiness logic/homeCubit/home_cubit.dart';
import '../../../customwidget/search_custom_widget.dart';
import 'HomeComponents/single_service_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({required this.categoryId, Key? key}) : super(key: key);
  final int categoryId;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().categoryServices(id: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 18, left: 30, right: 30),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is CategoryServicesLoadingState) {
              return const CircularLoadingWidget();
            } else if (state is CategoryServicesSuccessState) {
              return Column(
                children: [
                  CustomHeaderWidget(
                      title: 'خدمات ${state.categoryServices.name}'),
                  const SizedBox(
                    height: 16,
                  ),
                  const SearchCustomWidget(),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.categoryServices.services.length,
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            NavigationManager.pushNamed(
                                RouteConstants.serviceDetailsRoute,
                                arguments: index + 1);
                          },
                          child: SingleServiceWidget(
                            width: double.infinity,
                            image: state.categoryServices.services[index].image,
                            price:
                                '${state.categoryServices.services[index].priceFrom} - ${state.categoryServices.services[index].priceTo}',
                            serviceName:
                                state.categoryServices.services[index].name,
                            loadingPlaceholder: Container(
                              height: 180,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
            height: 50, width: 50, child: CircularProgressIndicator()));
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
