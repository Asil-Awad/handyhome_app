import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/searchCubit/search_state.dart';

import '../../data/models/category_model.dart';
import '../../data/repository/searchRepo/search_repo.dart';
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialSearchState());

  SearchRepository searchRepository = SearchRepository();

  void performSearch(String serviceName) async {
    emit(LoadingSearchState());

    final data = await searchRepository.getSearchesRepo(serviceName);
    data.fold((failure) {
      emit(FailureSearchState(message: failure.message));
      print(failure.message);
    }, (response) {
      List<CategoryModel> categories = response.data;
      emit(LoadedSearchState(categories: categories));
      print(response.data);
    });
  }
}
