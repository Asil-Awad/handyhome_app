
import '../../data/models/category_model.dart';

abstract class SearchState{}
class InitialSearchState extends SearchState{}
class LoadingSearchState extends SearchState{}
class LoadedSearchState extends SearchState{
   final List<CategoryModel> categories;
  LoadedSearchState({required this.categories});
}
class FailureSearchState extends SearchState{
    final String message;
  FailureSearchState({required this.message});
}