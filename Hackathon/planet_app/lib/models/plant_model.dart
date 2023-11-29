class Plant {
  int? id;
  String? name;
  String? describtion;
  String? frequency;
  String? water;
  String? temp;
  String? light;
  int? catagoryId;
  String? image;
  bool? userAdd;

  Plant(
      {this.id,
      this.name,
      this.describtion,
      this.frequency,
      this.water,
      this.temp,
      this.light,
      this.catagoryId,
      this.image,
      this.userAdd});

  Plant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    describtion = json['describtion'];
    frequency = json['frequency'];
    water = json['water'];
    temp = json['temp'];
    light = json['light'];
    catagoryId = json['catagory_id'];
    image = json['image'];
    userAdd = json['user_add'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['describtion'] = describtion;
    data['frequency'] = frequency;
    data['water'] = water;
    data['temp'] = temp;
    data['light'] = light;
    data['catagory_id'] = catagoryId;
    data['image'] = image;
    data['user_add'] = userAdd;
    return data;
  }
}
