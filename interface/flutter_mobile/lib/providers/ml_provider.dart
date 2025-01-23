import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class MLProvider with ChangeNotifier {
  final ApiService _apiService;
  List<dynamic> _result = [];
  bool _isLoading = false;

  MLProvider(this._apiService);

  List<dynamic> get result => _result;
  bool get isLoading => _isLoading;

  Future<void> predict(List<double> input) async {
    _isLoading = true;
    notifyListeners();
    try {
      _result = await _apiService.predict(input);
    } catch (e) {
      print('Error: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
