import 'package:flutter/material.dart';
import 'package:udemy_app/model/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              // Text(
              //   place.title,
              //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              //       color: Theme.of(context).colorScheme.onBackground),
              // ),
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: Text(
      //     place.title,
      //     style: Theme.of(context)
      //         .textTheme
      //         .bodyLarge!
      //         .copyWith(color: Theme.of(context).colorScheme.onBackground),
      //   ),
      // ),
    );
  }
}
