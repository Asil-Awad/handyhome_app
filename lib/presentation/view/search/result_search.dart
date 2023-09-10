import 'package:flutter/material.dart';

import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../customwidget/search_custom_widget.dart';
import '../../../data/models/category_model.dart';
import 'detailscreen.dart';


class SearchResult extends StatelessWidget {
 final List<dynamic> searchResults;

  const SearchResult({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/no_results_image.png'), // Replace with your image
            Text(
              'No search results found.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final category = searchResults[index];
          return ListTile(
            title: Text(category.name),
            subtitle: Text(category.categoryServices),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(category.icon),
            ),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(category: category),
                ),
              );
            },
          );
        },
      );
    }
  }
}
