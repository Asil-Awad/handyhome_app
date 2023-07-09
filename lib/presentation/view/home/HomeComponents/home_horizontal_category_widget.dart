import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/data/models/service_model.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/single_service_widget.dart';
import 'package:skeletons/skeletons.dart';

class HomeHorizontalCategoryWidget extends StatelessWidget {
  const HomeHorizontalCategoryWidget({
    this.changeTheOrder = false,
    Key? key,
  }) : super(key: key);
  final bool changeTheOrder;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestServiceCubit, LatestServiceAddedInitialState>(
      builder: (context, state) {
        List<ServiceModel> servicesChanged = [];
        if (state is LatestServiceAddedLoadingState) {
          return SkeletonItem(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            height: 200,
            width: 250,
          ));
        } else if (state is LatestServiceAddedSuccessState) {
          if (changeTheOrder) {
            servicesChanged.addAll(state.services);
            servicesChanged.shuffle();
          }
          return SizedBox(
            height: 250,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(right: 27),
              scrollDirection: Axis.horizontal,
              itemCount: state.services.length,
              itemBuilder: (context, index) => SingleServiceWidget(
                imageHeight: 180,
                image: changeTheOrder
                    ? servicesChanged[index].image
                    : state.services[index].image,
                price: changeTheOrder
                    ? '${servicesChanged[index].priceFrom}-${servicesChanged[index].priceTo}'
                    : '${state.services[index].priceFrom}-${state.services[index].priceTo}',
                serviceName: changeTheOrder
                    ? servicesChanged[index].name
                    : state.services[index].name,
                loadingPlaceholder: Container(
                  height: 200,
                  width: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          );
        }
        return const Icon(
          Icons.error,
          size: 30,
        );
      },
    );
  }
}
