import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/home_horizontal_category_widget.dart';

import '../../../customwidget/search_custom_widget.dart';
import '../../resources/style_manager.dart';
import '../home/HomeComponents/single_service_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                const SearchCustomWidget(),
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
                    image:
                        "https://mohammedashrafdagga.pythonanywhere.com/media/services_images/services.png",
                    price: '30-50',
                    serviceName: "تركيب مفاصل للأبواب",
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
                    image:
                        "https://mohammedashrafdagga.pythonanywhere.com/media/services_images/services.png",
                    price: '30-50',
                    serviceName: "تركيب مفاصل للأبواب",
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
                    image:
                        "https://mohammedashrafdagga.pythonanywhere.com/media/services_images/services.png",
                    price: '30-50',
                    serviceName: "تركيب مفاصل للأبواب",
                  ),
                  itemCount: 30,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
