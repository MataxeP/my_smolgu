import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double pinVisiblePosition = 20;
const double pinInvisiblePosition = -220;

class Buiding {
  String buildName;
  String address;
  String thumbNail;
  LatLng locationCoords;

  Buiding(
      {required this.buildName,
      required this.address,
      required this.thumbNail,
      required this.locationCoords});
}

final List<Buiding> univBuildingsList = [
  Buiding(
      buildName: 'СмолГУ',
      address: 'улица Пржевальского, 4',
      locationCoords: const LatLng(54.784302, 32.046221),
      thumbNail: "assets/icons/places_nav.jpeg"),
  Buiding(
      buildName: 'Библиотека',
      address: 'улица Пржевальского, 2А',
      locationCoords: const LatLng(54.785013, 32.047766),
      thumbNail: "assets/icons/places_nav.jpeg"),
  Buiding(
      buildName: 'Многофункциональный спортивный комплекс',
      address: 'улица Пржевальского, 4Г',
      locationCoords: const LatLng(54.785516891691465, 32.047347527786265),
      thumbNail: "assets/icons/places_nav.jpeg"),
];

final List<Buiding> hostelsList = [
  Buiding(
      buildName: 'Общежитие №1',
      address: 'улица Дзержинского, 23/1',
      locationCoords: const LatLng(54.780849, 32.036932),
      thumbNail: "assets/icons/obshagi_nav.jpeg"),
  Buiding(
      buildName: 'Общежитие №2',
      address: 'улица Урицкого, 13',
      locationCoords: const LatLng(54.774602, 32.05171),
      thumbNail: "assets/icons/obshagi_nav.jpeg"),
  Buiding(
      buildName: 'Общежитие №3',
      address: 'улица Кирова, 27',
      locationCoords: const LatLng(54.769549, 32.035019),
      thumbNail: "assets/icons/obshagi_nav.jpeg"),
  Buiding(
      buildName: 'Общежитие №4',
      address: 'улица Пржевальского, 2А',
      locationCoords: const LatLng(54.785013, 32.047766),
      thumbNail: "assets/icons/obshagi_nav.jpeg"),
];

final List<Buiding> foodList = [
  Buiding(
      buildName: '7 Слонов/Миккей',
      address: 'Большая Советская улица, 19/2',
      locationCoords: const LatLng(54.784011, 32.054063),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Русский двор',
      address: 'улица Октябрьской Революции, 1Б',
      locationCoords: const LatLng(54.781368, 32.045206),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Мандариновый гусь/Шоколад',
      address: 'улица Октябрьской Революции, 7',
      locationCoords: const LatLng(54.776389, 32.044514),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Пицца Чили',
      address: 'улица Глинки, 11',
      locationCoords: const LatLng(54.77978, 32.050784),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Кафе Дом 20',
      address: 'Большая Советская улица, 20',
      locationCoords: const LatLng(54.782049, 32.052536),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Сан-Жак',
      address: 'Чуриловский переулок, 19',
      locationCoords: const LatLng(54.778533, 32.03881),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Домино',
      address: 'улица Дзержинского, 16',
      locationCoords: const LatLng(54.780548, 32.040157),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Домино',
      address: 'проспект Гагарина, 1',
      locationCoords: const LatLng(54.777152, 32.050668),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Самовар',
      address: 'улица Ленина, 14',
      locationCoords: const LatLng(54.782422, 32.050901),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Смолка Ресторан',
      address: 'улица Ногина, 32Б',
      locationCoords: const LatLng(54.785569, 32.043661),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Квартал',
      address: 'улица Пржевальского, 6/25',
      locationCoords: const LatLng(54.784198, 32.042601),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Красное&Белое',
      address: 'Коммунистическая улица, 12',
      locationCoords: const LatLng(54.780465, 32.050452),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Красное&Белое',
      address: 'улица Исаковского, 20',
      locationCoords: const LatLng(54.779624, 32.059965),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Гута',
      address: 'Большая Советская улица, 39/11',
      locationCoords: const LatLng(54.780641, 32.052967),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Океан',
      address: 'улица Исаковского, 16',
      locationCoords: const LatLng(54.779089, 32.059543),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Продтовары',
      address: 'Коммунистическая улица, 15/2',
      locationCoords: const LatLng(54.7806, 32.054791),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Ермак',
      address: 'улица Октябрьской Революции, 3Б',
      locationCoords: const LatLng(54.777386, 32.045673),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Веста',
      address: 'улица Барклая-де-Толли, 1',
      locationCoords: const LatLng(54.779297, 32.051925),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Магазин продуктов',
      address: 'улица Бакунина, 12',
      locationCoords: const LatLng(54.786244, 32.039034),
      thumbNail: "assets/icons/food_nav.jpeg"),
  Buiding(
      buildName: 'Заря',
      address: 'улица Конёнкова, 2/12',
      locationCoords: const LatLng(54.782999, 32.049024),
      thumbNail: "assets/icons/food_nav.jpeg"),
];

String mapStyle = '''
[
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
''';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late GoogleMapController _controller;
  double pinPillPosition = -220;
  late String elementThumbnail = univBuildingsList[0].thumbNail;
  late String elementName = univBuildingsList[0].buildName;
  late String elementAddress = univBuildingsList[0].address;
  late Color selectedColor = Colors.redAccent;

  List<Marker> allMarkers = [];

  int? prevPage;

  @override
  void initState() {
    super.initState();
    for (var element in univBuildingsList) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.buildName),
          draggable: false,
          position: element.locationCoords,
          onTap: () {
            _controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: element.locationCoords,
                    zoom: 17.0,
                    bearing: 30.0,
                    tilt: 50.0)));
            setState(() {
              elementThumbnail = element.thumbNail;
              elementName = element.buildName;
              elementAddress = element.address;
              selectedColor = Colors.redAccent;
              pinPillPosition = pinVisiblePosition;
            });
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        compassEnabled: false,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        initialCameraPosition: const CameraPosition(
            target: LatLng(54.784302, 32.046221),
            zoom: 17.0,
            tilt: 50.0,
            bearing: 30.0),
        markers: Set.from(allMarkers),
        onMapCreated: mapCreated,
        onTap: (LatLng loc) {
          setState(() {
            pinPillPosition = pinInvisiblePosition;
          });
        },
      ),
      Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).backgroundColor,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                        'assets/icons/places_nav.jpeg',
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover)),
                                const SizedBox(height: 6),
                                Text(
                                  'Места',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                pinPillPosition = pinInvisiblePosition;
                                allMarkers = [];
                                for (var element in univBuildingsList) {
                                  allMarkers.add(Marker(
                                      markerId: MarkerId(element.buildName),
                                      draggable: false,
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueRed),
                                      position: element.locationCoords,
                                      onTap: () {
                                        _controller.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target:
                                                        element.locationCoords,
                                                    zoom: 17.0,
                                                    bearing: 30.0,
                                                    tilt: 50.0)));
                                        setState(() {
                                          elementThumbnail = element.thumbNail;
                                          elementName = element.buildName;
                                          elementAddress = element.address;
                                          selectedColor = Colors.redAccent;
                                          pinPillPosition = pinVisiblePosition;
                                        });
                                      }));
                                  moveCamera(
                                      const LatLng(54.784302, 32.046221), 17.0);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                        'assets/icons/obshagi_nav.jpeg',
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover)),
                                const SizedBox(height: 6),
                                Text(
                                  'Общаги',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                pinPillPosition = pinInvisiblePosition;
                                allMarkers = [];
                                for (var element in hostelsList) {
                                  allMarkers.add(Marker(
                                      markerId: MarkerId(element.buildName),
                                      draggable: false,
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueGreen),
                                      position: element.locationCoords,
                                      onTap: () {
                                        _controller.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target:
                                                        element.locationCoords,
                                                    zoom: 17.0,
                                                    bearing: 30.0,
                                                    tilt: 50.0)));
                                        elementThumbnail = element.thumbNail;
                                        elementName = element.buildName;
                                        selectedColor = Colors.greenAccent;
                                        elementAddress = element.address;
                                        setState(() {
                                          pinPillPosition = pinVisiblePosition;
                                        });
                                      }));
                                  moveCamera(
                                      const LatLng(54.773995, 32.041684), 13.5);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                        'assets/icons/food_nav.jpeg',
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover)),
                                const SizedBox(height: 6),
                                Text(
                                  'Еда',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                pinPillPosition = pinInvisiblePosition;
                                allMarkers = [];
                                for (var element in foodList) {
                                  allMarkers.add(Marker(
                                      markerId: MarkerId(element.buildName),
                                      draggable: false,
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueBlue),
                                      position: element.locationCoords,
                                      onTap: () {
                                        _controller.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target:
                                                        element.locationCoords,
                                                    zoom: 17.0,
                                                    bearing: 30.0,
                                                    tilt: 50.0)));
                                        setState(() {
                                          elementThumbnail = element.thumbNail;
                                          elementName = element.buildName;
                                          elementAddress = element.address;
                                          selectedColor = Colors.blueAccent;
                                          pinPillPosition = pinVisiblePosition;
                                        });
                                      }));
                                  moveCamera(
                                      const LatLng(54.782999, 32.049024), 13.7);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  )))),
      AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          left: 0,
          right: 0,
          top: pinPillPosition,
          child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset.zero)
                  ]),
              child: Column(
                children: [
                  Container(
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipOval(
                                child: Image.asset(elementThumbnail,
                                    width: 60, height: 60, fit: BoxFit.cover),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(elementName,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ))),
                                Text(elementAddress,
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(color: Colors.red)))
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ))),
    ])));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
      _controller.setMapStyle(mapStyle);
    });
  }

  moveCamera(locs, zoom) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: locs, zoom: zoom, bearing: 30.0, tilt: 50.0)));
  }
}
