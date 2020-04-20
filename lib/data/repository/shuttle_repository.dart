import 'package:latlong/latlong.dart';

import '../provider/shuttle_api_provider.dart';
//import '../provider/shuttle_local_provider.dart';

/// Repo class that retrieves data from provider class methods and
/// distributes the data to BLoC pattern
class ShuttleRepository {
  final _shuttleProvider = ShuttleApiProvider();
  //final _shuttleProvider = ShuttleLocalProvider();

  Future<List<dynamic>> get getRoutes async => _shuttleProvider.getRoutes;
  Future<List<dynamic>> get getStops async => _shuttleProvider.getStops;
  Future<List<dynamic>> get getUpdates async => _shuttleProvider.getUpdates;
  Future<LatLng> get getLocation async => _shuttleProvider.getLocation();
  bool get getIsConnected => _shuttleProvider.getIsConnected;
}
