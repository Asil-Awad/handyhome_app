import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/view/home/category_screen.dart';
import '../../../customwidget/custom_button_with_background_widget.dart';
import '../../resources/assets_manager.dart';
import 'HomeComponents/customer_comment_widget.dart';
import 'HomeComponents/order_service_bottom_sheet.dart';
import 'HomeComponents/rating_bottom_sheet.dart';
import 'HomeComponents/stare_rating_widget.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({required this.serviceId, Key? key})
      : super(key: key);
  final int serviceId;
  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController ratingController = TextEditingController();
  bool isScroll = false;
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().serviceDetails(id: widget.serviceId);
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
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            print(state);
            if (state is ServiceDetailsLoadingState) {
              return const CircularLoadingWidget();
            } else if (state is ServiceDetailsSuccessState) {
              return Column(
                children: [
                  Container(
                    color: isScroll ? Colors.white : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: CustomHeaderWidget(
                        title: state.serviceDetails.name,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: CachedNetworkImage(
                                      imageUrl: state.serviceDetails.image,
                                      placeholder: (context, url) => Container(
                                        height: 180,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        color: Colors.grey,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 25,
                                left: 25,
                              ),
                              child: StareRatingWidget(ratingNumber: '4.6'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.serviceDetails.name,
                              style: StyleManger.headline1(fontSize: 18),
                            ),
                            Text(
                                '${state.serviceDetails.priceFrom} - ${state.serviceDetails.priceTo} شيكل'),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'تتضمن هذه الخدمة التالي:',
                          style: StyleManger.headline1(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ...state.serviceDetails.serviceInclude!
                            .map((e) => Text('✅ $e'))
                            .toList(),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'لا تتضمن هذه الخدمة التالي:',
                          style: StyleManger.headline1(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ...state.serviceDetails.serviceExclude!
                            .map((e) => Text('❌ $e'))
                            .toList(),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'تعليقات العملاء',
                              style: StyleManger.headline1(fontSize: 16),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ColorManager.buttonBackgroundColor,
                                ),
                                onPressed: () {
                                  ratingBottomSheet(context,
                                      controller: ratingController);
                                },
                                child: const Text(
                                  'قيّم تجربتك',
                                  style: TextStyle(
                                    color: ColorManager.primaryMainEnableColor,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ...state.serviceDetails.reviews!
                            .map(
                              (e) => CustomerCommentWidget(
                                comment: e.comment,
                                image: e.image,
                                name: e.name,
                                rating: e.review,
                              ),
                            )
                            .toList(),
                        // const CustomerCommentWidget(),
                        // const CustomerCommentWidget(),
                        // const CustomerCommentWidget(),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Icon(
              Icons.error,
              size: 30,
            );
          },
        ),
        bottomNavigationBar: CustomButtonWithBackgroundWidget(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                context: context,
                backgroundColor: ColorManager.background,
                useSafeArea: true,
                isScrollControlled: true,
                builder: (context) => const OrderServiceBottomSheet(),
              );
            },
            text: 'اطلب هذه الخدمة'));
  }
}

List<String> include = [
  'توصيل خطوط المياه ساخنة وباردة ',
  'اصلاح "ضعف المياه, التسريب, خلاط المياه"',
  'ضمانة تطبيقنا على الخدمة وضمانة على الاعطال بعد الصيانة التركيب',
  'ضمانة على جميع القطع المركبة',
];

List<String> exclude = [
  'توصيل خطوط المياه ساخنة وباردة ',
  'اصلاح "ضعف المياه, التسريب, خلاط المياه"',
  'ضمانة تطبيقنا على الخدمة وضمانة على الاعطال بعد الصيانة التركيب',
  'ضمانة على جميع القطع المركبة',
];
