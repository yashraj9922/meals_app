import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Stack(
          // first widget will be the bottom most widget and other widgets will be added on top of that
          children: [
            // 1st Widget(bottom most widget)
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            // this widget that controls where a child of a [Stack] is positioned/located
            // 2nd Widget(on top of FadeInImage Widget)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      // how will text be cuttoff when it is more than 2 lines...(3 dots will be added {TextOverflow.ellipsis})
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
          ],
        ), // Stack() --> Multiple widgets are positioned on top of each other along the z-axis(ex. we can have a image in background and a text displayed on it)
      ),
    );
  }
}
