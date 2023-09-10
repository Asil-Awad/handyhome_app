import 'package:flutter/material.dart';

import '../../../data/models/category_model.dart';

class DetailsScreen extends StatelessWidget {
  final CategoryModel category;

  const DetailsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement the UI to display the details of the selected search result
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Column(
        children: [
          Text('Name: ${category.name}'),
          Text('Icon: ${category.icon}'),
          Text('Count Services: ${category.countServices}'),
          Text('Category Services: ${category.categoryServices}'),
        ],
      ),
    );
  }
}

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//       final searchCubit = Provider.of<SearchCubit>(context, listen: false);

//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'البحث',
//                   style: StyleManger.headline1(),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 SearchCustomWidget(
//                   onTap: () {
//                     // Call the performSearch method when the widget is tapped
//                    final serviceName = 'q'; // Replace with the actual search query
//                     searchCubit.performSearch(serviceName);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           Expanded(
//             child: BlocBuilder<SearchCubit, SearchState>(
//               builder: (context, state) {
//                 if (state is LoadingSearchState) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is FailureSearchState) {
//                   return Center(child: Text(state.message));
//                 } else if (state is LoadedSearchState) {
//                   final searchResults = state.categories;
//                   return SearchResult(
//                     searchResults: searchResults,
//                   );
//                 } else {
//                   // InitialSearchState or other states
//                   return Container();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
