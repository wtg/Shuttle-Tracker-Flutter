import 'package:latlong/latlong.dart';

import '../../models/shuttle_route.dart';
import '../../models/shuttle_stop.dart';
import '../../models/shuttle_update.dart';
import '../provider/shuttle_api_provider.dart';
//import '../provider/shuttle_local_provider.dart';

/// Repo class that retrieves data from provider class methods and
/// distributes the data to BLoC pattern
class ShuttleRepository {
  final _shuttleProvider = ShuttleApiProvider();

//  void get openSocket => _shuttleProvider.openSocket();
  Future<List<ShuttleRoute>> get getRoutes async =>
      _shuttleProvider.getRoutes();
  Future<List<ShuttleStop>> get getStops async => _shuttleProvider.getStops();
  Future<List<ShuttleUpdate>> get getUpdates async =>
      _shuttleProvider.getUpdates();
  Future<LatLng> get getLocation async => _shuttleProvider.getLocation();
  bool get getIsConnected => _shuttleProvider.getIsConnected;
}
