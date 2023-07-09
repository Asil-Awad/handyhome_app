import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/bussiness%20logic/searchCubit/search_state.dart';

import '../../data/models/category_model.dart';
import '../../data/repository/searchRepo/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialSearchState());

  SearchRepository searchRepository = SearchRepository();

  recentSearches(String serviceName) async {
    emit(LoadingSearchState());

    final data = await searchRepository.getRecentSearches(serviceName);
    data.fold((failure) {
      emit(FailureSearchState(message: failure.message));
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      print(failure.message);
    }, (response) {
      print("Asellllllllllllllllllllllllllll");
      List<CategoryModel> categories = response.data;
      emit(LoadedSearchState(categories: categories));
      print(response.data);
    });
  }
}
