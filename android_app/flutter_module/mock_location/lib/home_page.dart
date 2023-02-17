import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mock_location/permissions/get_permissions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  late GetPermission getPermission;
  bool isFakeLocation = true;
  bool isActivePermission = false;

  double startLatitude = 0.0;
  double startLongitude = 0.0;

  double endLatitude = 0.0;
  double endLongitude = 0.0;
  double distance = 0.0;

  int countPress = 0;

  @override
  void initState() {
    getPermission = GetPermission();
    permissionIsActive();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getLocation(isStart: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detect Mock Location'),
        ),
        body: isActivePermission ? _content() : _needPermission());
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
                visible: countPress > 0,
                child: Text('IsFakeLocation: $isFakeLocation')),
            const Text('kisweb $kIsWeb')
          ],
        ),
      ),
    );
  }

  Widget _needPermission() {
    return const Center(
      child: Text('Need Permission'),
    );
  }

  Future<bool> permissionIsActive() async {
    final status = await getPermission.status();
    getLocation(isStart: true).whenComplete(() {
      isActivePermission = true;
      setState(() {});
    });
    return status;
  }

  Future<void> getLocation({bool isStart = true}) async {
    if (isStart) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        startLatitude = position.latitude;
        startLongitude = position.longitude;
      });
    } else {
      Position position = await Geolocator.getPositionStream().first;
      setState(() {
        endLatitude = position.latitude;
        endLongitude = position.longitude;
      });
    }

    calculateDistance();
  }

  Future<void> calculateDistance() async {
    countPress++;
    getLocation(isStart: false);

    //Calculates the distance between the supplied coordinates in meters.
    distance = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);

    if (endLatitude == 0.0 && endLongitude == 0.0) {
      await getLocation(isStart: false);
      calculateDistance();
    }

    if (distance > 100) {
      setState(() {
        distance = distance;
        isFakeLocation = true;
      });
    } else {
      setState(() {
        distance = distance;
        isFakeLocation = false;
      });
    }
  }
}
