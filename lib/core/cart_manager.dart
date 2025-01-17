import '../models/sport_class_details_model.dart';

abstract class CartManager {
  static List<SportClassDetailsModel> userCardList = [];

  static bool addToCart(SportClassDetailsModel sportClassDetailsModel) {
    for (var element in userCardList) {
      if (element.classNumber == sportClassDetailsModel.classNumber) {
        return false;
      }
    }
    userCardList.add(sportClassDetailsModel);
    return true;
  }

  static bool deleteFromCart(SportClassDetailsModel sportClassDetailsModel) {
    for (var element in userCardList) {
      if (element.classNumber == sportClassDetailsModel.classNumber) {
        userCardList.remove(element);
        return true;
      }
    }
    return false;
  }
}
