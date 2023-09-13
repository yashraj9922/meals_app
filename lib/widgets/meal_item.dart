import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
    // .name gives u access to the String value of enum
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ), // Stack Widget ignores the shape argument(by default)
      clipBehavior: Clip.hardEdge,
      // to enforce the shape argument..so that any content that goes out of the shape will be cutoff
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(
          // first widget will be the bottom most widget and other widgets will be added on top of that
          children: [
            // 1st Widget(bottom most widget)
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              // making sure that image is never distorted but cutoff if it does not fit into the box
              height: 200,
              width: double.infinity,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: /*meal.duration.toString()+" min",)*/
                              '${meal.duration} min',
                        ),

                        const SizedBox(width: 12),

                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ), // need to format the text of complexity hence we need to add a getter

                        const SizedBox(width: 12),

                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
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
