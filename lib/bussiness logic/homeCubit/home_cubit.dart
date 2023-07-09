import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/repository/home/home_repository.dart';
import 'package:meta/meta.dart';

import '../../data/models/category_model.dart';
import '../../data/models/service_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository = HomeRepository();

  HomeCubit() : super(HomeInitial());

  categories() async {
    emit(CategoryLoadingState());

    final data = await homeRepository.getCategory();
    data.fold((l) {
      List<CategoryModel> categories = l.data as List<CategoryModel>;
      emit(CategorySuccessState(categories: categories));
    }, (r) => emit(CategoryFailedState(message: r.message)));
  }

  categoryServices({required int id}) async {
    emit(CategoryServicesLoadingState());

    final data = await homeRepository.getServicesForCategory(id: id);
    data.fold((l) {
      emit(CategoryServicesSuccessState(
          categoryServices: l.data as CategoryWithServicesModel));
    }, (r) => emit(CategoryServicesFailedState(message: r.message)));
  }

  serviceDetails({required int id}) async {
    emit(ServiceDetailsLoadingState());

    final data = await homeRepository.getServiceDetails(id: id);
    data.fold((l) {
      emit(ServiceDetailsSuccessState(serviceDetails: l.data as ServiceModel));
    }, (r) => emit(ServiceDetailsFailedState(message: r.message)));
  }
}

class LatestServiceCubit extends Cubit<LatestServiceAddedInitialState> {
  HomeRepository homeRepository = HomeRepository();

  LatestServiceCubit() : super(LatestServiceAddedInitialState());
  latestAddedService() async {
    emit(LatestServiceAddedLoadingState());

    final data = await homeRepository.getLatestAddedServices();
    data.fold(
        (l) => emit(LatestServiceAddedSuccessState(
            services: l.data as List<ServiceModel>)),
        (r) => emit(LatestServiceAddedFailedState(message: r.message)));
  }
}
