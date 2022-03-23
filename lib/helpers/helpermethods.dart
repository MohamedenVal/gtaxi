import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gtaxi/helpers/requesthelpers.dart';

class HelperMethodes {
  Future<String> findCordinateAddress(Position position) async {
    String placeAddress = '';

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyCGD0gE33dc-6UHtIAptXSAVZRogFvV8Hs';

    var response = await RequestHelper.getRequest(url, '');

    if (response != 'failed') {
      placeAddress = response['results'][0]['formated_address'];
    }

    return placeAddress;
  }
}
