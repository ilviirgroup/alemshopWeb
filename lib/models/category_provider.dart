import 'package:alemadmin/models/products_provider.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuperCategoryObject with ChangeNotifier {
  String id;
  String name;

  SuperCategoryObject({
    @required this.id,
    @required this.name,
  });
  factory SuperCategoryObject.fromJson(Map<String, dynamic> json) {
    return SuperCategoryObject(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

class CategoryObject with ChangeNotifier {
  String id;
  String name;
  String supcat;
  CategoryObject({
    @required this.id,
    @required this.name,
    @required this.supcat,
  });
  factory CategoryObject.fromJson(Map<String, dynamic> json) {
    return CategoryObject(
      id: json['id'] as String,
      name: json['name'] as String,
      supcat: json['supcategory'] as String,
    );
  }
}

class SubCategoryObject with ChangeNotifier {
  String id;
  String name;
  String supcat;
  SubCategoryObject({
    @required this.id,
    @required this.name,
    @required this.supcat,
  });
  factory SubCategoryObject.fromJson(Map<String, dynamic> json) {
    return SubCategoryObject(
      id: json['id'] as String,
      name: json['name'] as String,
      supcat: json['supcategory'] as String,
    );
  }
}

class Categories with ChangeNotifier {
  List<CategoryObject> _categories = [];

  List<CategoryObject> get categories {
    return [..._categories];
  }

  List<Subcategory> _subcategories = [];
  List<Subcategory> _sortedSubcategories = [];

  List<Subcategory> get sortedSubcategories {
    for (int i = 0; i < _subcategories.length; i++) {
      if (i != _subcategories.length - 1) {
        if (_subcategories[i].alemid != _subcategories[i + 1].alemid) {
          _sortedSubcategories.add(_subcategories[i]);
        }
      }
      if (i == _subcategories.length - 1) {
        if (_subcategories[i].alemid != _subcategories[i - 1].alemid) {
          _sortedSubcategories.add(_subcategories[i]);
        }
      }
    }
    return [..._sortedSubcategories];
  }

  List<Subcategory> get subcategories {
    print(sortedSubcategories);
    return [..._subcategories];
  }

  Subcategory findById(String prodId) {
    return _subcategories.firstWhere((element) => element.alemid == prodId);
  }

  List<Subcategory> findByIdForImages(String prodId) {
    return _subcategories.where((element) => element.alemid == prodId).toList();
  }

  Future<void> getCategories() async {
    const url = 'https://www.alemshop.com.tm?action=getTable&table=category';

    try {
      final response = await http.get(Uri.parse(url));
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      _categories = parsed
          .map<CategoryObject>((json) => CategoryObject.fromJson(json))
          .toList();

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getSubCategories(String catType) async {
    var url = 'https://www.alemshop.com.tm?action=getTable&table=$catType';
    _sortedSubcategories = [];
    try {
      final response = await http.get(Uri.parse(url));
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      _subcategories = parsed
          .map<Subcategory>((json) => Subcategory.fromJson(json))
          .toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
