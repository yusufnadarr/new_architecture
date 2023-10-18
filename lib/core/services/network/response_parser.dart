import '../../base/base_model.dart';
import 'network_service.dart';

extension CoreDioOperations on NetworkService {
  R? responseParser<T, R>(BaseModel<T> model, dynamic data) {
    if (data is List) {
      return data.map((e) => model.fromJson(e)).toList().cast<T>() as R;
    } else if (data is Map) {
      return model.fromJson(data as Map<String, dynamic>) as R;
    }
    return data as R?;
  }
}
