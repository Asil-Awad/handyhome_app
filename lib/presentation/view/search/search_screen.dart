import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/searchCubit/search_cubit.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/home_horizontal_category_widget.dart';

import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../bussiness logic/searchCubit/search_state.dart';
import '../../../customwidget/search_custom_widget.dart';
import '../../resources/style_manager.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'البحث',
                  style: StyleManger.headline1(),
                ),
                const SizedBox(
                  height: 16,
                ),
                SearchCustomWidget(onTap:()=>
                
                Navigator.pushNamed(context, RouteConstants.searchResultScreen)
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: 30),
            children: [
              Text(
                'عمليات البحث الاخيرة',
                style: StyleManger.headline1(fontSize: 18),
              ),
              SizedBox(
                height: 205,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => const SingleServiceWidget(
                    width: 160,
                  ),
                  itemCount: 30,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'اقتراحات سريعة',
                style: StyleManger.headline1(fontSize: 18),
              ),
              SizedBox(
                height: 205,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => const SingleServiceWidget(
                    width: 160,
                  ),
                  itemCount: 30,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                ' خدمات اخرى',
                style: StyleManger.headline1(fontSize: 18),
              ),
              SizedBox(
                height: 205,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => const SingleServiceWidget(
                    width: 160,
                  ),
                  itemCount: 30,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
