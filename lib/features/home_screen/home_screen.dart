// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:driver_app/configs/configs_export.dart';
import 'package:driver_app/constants/app_const.dart';
import 'package:driver_app/features/export_features.dart';
import 'package:driver_app/features/home_screen/blocs/blocs_export.dart';
import 'package:driver_app/features/home_screen/components/components_export.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:driver_app/ultis/ultis_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';
import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart'; // DECODE ROUTES

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pusher = ConnectToPusher();

  LatLng userPosition = const LatLng(10.758970, 106.675461);
  final RequestLocation requestLocation = RequestLocation();
  VietmapController? mapController;
  StreamSubscription<Position>? _positionStreamSubscription;
  File? _imageFile;

  String userName = '';
  double reviewRate = 0;
  bool status = false;
  Line? line;
  OrderModel? order;
  LatLng? desAddress;

  void prepareConnect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Position temp = await requestLocation.getCurrentLocation();

    setState(() {
      userName = prefs.getString('userName').toString();
      reviewRate = prefs.getDouble('reviewRate')!;
      if (prefs.getString('order') != null) {
        existOrder();
      } else if (_positionStreamSubscription != null) {
        _positionStreamSubscription?.cancel();
      }

      if (prefs.getBool('isOnline') != null) {
        status = prefs.getBool('isOnline')!;
      } else {
        prefs.setBool('isOnline', false);
      }
      userPosition = LatLng(temp.latitude, temp.longitude);
      _moveLocation();
    });
  }

  void existOrder() async {
    _removeLine();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    order = OrderModel.fromMap(jsonDecode(prefs.getString('order')!));
    log('ORDER: $order');

    List<LatLng> points = [];
    switch (order!.orderStatus.statusName) {
      case 'Tài xế đã nhận đơn':
        setState(() {
          points = [
            userPosition,
            LatLng(order!.fromAddress.lat, order!.fromAddress.lng),
          ];
          desAddress = LatLng(order!.fromAddress.lat, order!.fromAddress.lng);
        });
        break;
      case 'Tài xế đã đến điểm lấy':
        setState(() {
          points = [
            userPosition,
            LatLng(order!.toAddress.lat, order!.toAddress.lng),
          ];
          desAddress = LatLng(order!.toAddress.lat, order!.toAddress.lng);
        });
        break;
      case 'Tài xế đã đến điểm giao' || 'Giao hàng thành công':
        points = [];
        break;
      default:
        points = [];
    }

    if (points.isNotEmpty) {
      Either<Failure, VietMapRoutingModel> routes =
          await Vietmap.routing(VietMapRoutingParams(points: points));

      routes.fold((l) => null, (r) {
        for (var path in r.paths!) {
          List<LatLng> geometry =
              VietmapPolylineDecoder.decodePolyline(path.points!, false);
          _drawLine(geometry);
        }
      });
    }

    _positionStreamSubscription = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high, distanceFilter: 3))
        .listen((Position position) async {
      log('USER: ${position.toString()}');
      String token = prefs.getString('token')!;

      Map<String, dynamic> data = {
        'lat': position.latitude.toString(),
        'lng': position.longitude.toString(),
        'receiverId': order!.user.id.toString()
      };

      await OrderService.updateDriverLocation(data, token);
    });
  }

  @override
  void initState() {
    getAvatar();
    super.initState();
    Vietmap.getInstance(MAP_KEY);
    pusher.connecToPusher();
    prepareConnect();
  }

  void getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('avatar') != '') {
      File ans =
          await downloadAndSaveImage(prefs.getString('avatar').toString());
      setState(() {
        _imageFile = ans;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _positionStreamSubscription?.cancel();
  }

  void _drawLine(List<LatLng>? geometry) async {
    line = await mapController!.addPolyline(PolylineOptions(
      geometry: geometry,
      polylineColor: Colors.blue,
      polylineWidth: 10,
    ));
  }

  void _removeLine() {
    if (line != null) {
      mapController!.clearLines();
    }
  }

  void _moveLocation() {
    mapController?.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: userPosition, zoom: 16)));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<DrawerBloc, DrawerState>(listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            } else if (state is LogoutPending) {
              showDialog(
                  context: context,
                  builder: (context) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.green.shade800,
                        ),
                      ));
            }
          }),
        ],
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: status
                    ? const Text(
                        'Online',
                        style: TextStyle(color: Colors.black),
                      )
                    : const Text('Offline',
                        style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.white,
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.black),
                actions: [
                  Switch(
                      activeColor: Colors.green.shade600,
                      value: status,
                      onChanged: (value) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isOnline', value);

                        setState(() {
                          status = value;
                          log(state.toString());
                        });

                        final ul = {
                          'lat': userPosition.latitude.toString(),
                          'lng': userPosition.longitude.toString()
                        };

                        if (value == true) {
                          context.read<HomeBloc>().add(DriverActive(
                              currentLocation: jsonEncode(ul), status: 1));
                        } else {
                          context.read<HomeBloc>().add(DriverActive(
                              currentLocation: jsonEncode(ul), status: 0));
                        }

                        _moveLocation();
                      })
                ],
                elevation: 0,
              ),
              drawer: SafeArea(
                child: HomeDrawer(
                  userName: userName,
                  reviewRate: reviewRate,
                  imageFile: _imageFile,
                ),
              ),
              body: Stack(
                children: [
                  VietmapGL(
                    myLocationEnabled: status,
                    trackCameraPosition: status,
                    myLocationTrackingMode: status
                        ? MyLocationTrackingMode.None
                        : MyLocationTrackingMode.TrackingGPS,
                    myLocationRenderMode: status
                        ? MyLocationRenderMode.NORMAL
                        : MyLocationRenderMode.GPS,
                    initialCameraPosition:
                        CameraPosition(target: userPosition, zoom: 18),
                    styleString: Vietmap.getVietmapStyleUrl(),
                    onMapCreated: (VietmapController controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                  ),
                  Positioned(
                      bottom: 8.0,
                      right: 8.0,
                      child: GestureDetector(
                        onTap: _moveLocation,
                        child: const Icon(
                          Icons.my_location,
                          size: 30,
                        ),
                      )),
                  mapController != null && order != null && desAddress != null
                      ? MarkerLayer(markers: [
                          Marker(
                              alignment: Alignment.bottomCenter,
                              width: 50,
                              height: 50,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 50,
                              ),
                              latLng: desAddress!)
                        ], mapController: mapController!)
                      : const SizedBox.shrink()
                ],
              ),
            );
          },
        ));
  }
}
