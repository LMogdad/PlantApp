import 'package:planet_app/models/plant_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseNetworking {
  Future<List<Plant>> getPlants(int catagoryId) async {
    List<Plant> plantList = [];
    final data = await Supabase.instance.client
        .from("plants")
        .select()
        .eq("catagory_id", catagoryId);
    for (var plant in data) {
      plantList.add(Plant.fromJson(plant));
    }
    return plantList;
  }

  Future<List<Plant>> searchPlant(String name) async {
    List<Plant> plantList = [];
    final data = await Supabase.instance.client.from("plants").select();
    for (var plant in data) {
      if ((plant['name'] as String)
          .toLowerCase()
          .contains(name.toLowerCase())) {
        plantList.add(Plant.fromJson(plant));
      }
    }
    return plantList;
  }

  Future<List<Plant>> findByWaterDate(String date) async {
    List<Plant> plantList = [];
    final data = await Supabase.instance.client.from("plants").select();
    for (var plant in data) {
      print("'${plant['next_time_watring']}' ---------------------> '$date'");
      if ((plant['next_time_watring'] as String?) == date) {
        plantList.add(Plant.fromJson(plant));
      }
    }
    print(plantList);
    return plantList;
  }

  addPlant(int id) async {
    await Supabase.instance.client.from('plants').update({
      'user_add': true,
      'next_time_watring':
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
    }).eq('id', id);
  }

  removePlant(int id) async {
    await Supabase.instance.client
        .from('plants')
        .update({'user_add': false}).eq('id', id);
  }

  water(int id, int nextWatering) async {
    DateTime now = DateTime.now().add(Duration(days: 7 * nextWatering));
    await Supabase.instance.client.from("plants").update(
      {'next_time_watring': '${now.year}-${now.month}-${now.day}'},
    ).eq('id', id);
  }
}
