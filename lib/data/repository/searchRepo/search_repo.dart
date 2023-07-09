


import 'package:dartz/dartz.dart';

import '../../../app/constants_manager.dart';
import '../../models/category_model.dart';
import '../../network/remote/api_result_handler.dart';
import '../../network/remote/dio_helper.dart';

class SearchRepository{
DioHelper dioHelper = DioHelper();
  Future<Either< ApiFailure,ApiSuccess>> getRecentSearches(String serviceName) async {
    ApiResults response = await dioHelper.getData(
      endPoint: Endpoints.recentSearches,
      queryParameters: {"q": serviceName}
    );

    if (response is ApiSuccess) {
      return right(ApiSuccess(
          response.data
              .map((e) => CategoryModel.fromJson(e))
              .toList()
              .cast<CategoryModel>(),
          response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return left(ApiFailure('an error occur'));
      }
      return left(response as ApiFailure);
    }
  }
}