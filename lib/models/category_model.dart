import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  Color color;

  CategoryModel(this.id, this.name, this.image, this.color);

  static List<CategoryModel> getCategories() {
    return [
      CategoryModel("business", "Business", "assets/images/bussines.png",
          Color(0xFFCF7E48)),
      CategoryModel("entertainment", "Entertainment",
          "assets/images/environment.png", Color(0xFF4882CF)),
      CategoryModel("general", "General", "assets/images/politics.png",
          Color(0xFFCF7E48)),
      CategoryModel(
          "sports", "Sports", "assets/images/sports.png", Color(0xFFC91C22)),
      CategoryModel(
          "science", "Science", "assets/images/science.png", Color(0xFFF2D352)),
      CategoryModel(
          "health", "Health", "assets/images/health.png", Color(0xFFED1E79)),
      CategoryModel("technology", "Technology", "assets/images/bussines.png",
          Color(0xFF003E90)),
    ];
  }
}
