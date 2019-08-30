import 'package:first_flutter_app/main/m/WX_Autor_entity.dart';
import 'package:first_flutter_app/main/m/a_s_entity.dart';
import 'package:first_flutter_app/main/m/banner_entity.dart';
import 'package:first_flutter_app/main/m/atr_bean_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "WXAutorEntity") {
      return WXAutorEntity.fromJson(json) as T;
    } else if (T.toString() == "ASEntity") {
      return ASEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity.fromJson(json) as T;
    } else if (T.toString() == "AtrBeanEntity") {
      return AtrBeanEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}