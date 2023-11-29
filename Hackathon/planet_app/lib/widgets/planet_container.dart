import 'package:flutter/material.dart';
import 'package:planet_app/models/plant_model.dart';
import 'package:planet_app/screens/plant_detail_screen.dart';

class PlantContainer extends StatelessWidget {
  const PlantContainer({super.key, required this.plant});
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.75),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 170,
              width: 165,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  plant.image.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                plant.name!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlantDetailScreen(plant: plant)));
                },
                icon: const Icon(
                  Icons.arrow_circle_right_rounded,
                  size: 35,
                  color: Color(0xff2E481E),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
