import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/assets.dart';
import 'package:weather_app/services/location_Provider.dart';
import 'package:weather_app/utilities/appText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<LocationProvider>(context, listen: false).determinePosition();
  }

  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final locationProvider = Provider.of<LocationProvider>(context);
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(background[0]),
          ),
        ),
        child: Stack(
          children: [
            _clicked == true
                ? Positioned(
                    top: 80,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 30,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
              height: 80,
              child: Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                var locationCity;
                if (locationProvider.currentLocationName != null) {
                  locationCity = locationProvider.currentLocationName!.locality;
                } else {
                  locationCity = 'Unknown Location';
                }
                return ListTile(
                  leading: const Icon(
                    Icons.location_pin,
                    size: 35,
                    color: Colors.red,
                  ),
                  title: AppText(
                    data: locationCity,
                    size: 23,
                    color: Colors.white,
                    fw: FontWeight.w700,
                  ),
                  subtitle: AppText(
                    data: 'Good Evening',
                    size: 20,
                    color: Colors.white,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        _clicked = !_clicked;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 29,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
            Align(
              alignment: const Alignment(0, -0.36),
              child: Image.asset(
                imagePath[1],
                height: 150,
                width: 150,
              ),
            ),
            Align(
              alignment: const Alignment(0, 1.2),
              child: Container(
                height: 430,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: '21°C',
                      size: 27,
                      color: Colors.white,
                      fw: FontWeight.bold,
                    ),
                    AppText(
                      data: 'Snow',
                      size: 22,
                      color: Colors.white,
                      fw: FontWeight.w600,
                    ),
                    AppText(
                      data: DateTime.now().toString(),
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: const Alignment(0.0, 0.75),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black.withOpacity(0.4)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    temphighpic,
                                    height: 40,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      AppText(
                                        data: 'Temp Max',
                                        color: Colors.white,
                                        size: 14,
                                        fw: FontWeight.w600,
                                      ),
                                      AppText(
                                        data: '21°C',
                                        color: Colors.white,
                                        size: 14,
                                        fw: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(children: [
                                    Image.asset(
                                      templowpic,
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        AppText(
                                          data: 'Temp Low',
                                          color: Colors.white,
                                          size: 14,
                                          fw: FontWeight.w600,
                                        ),
                                        AppText(
                                          data: '5°C',
                                          color: Colors.white,
                                          size: 14,
                                          fw: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ]),
                                ]),
                            const Divider(
                              thickness: 2,
                              color: Colors.white,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    sunpic,
                                    height: 40,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      AppText(
                                        data: 'Sunrise',
                                        color: Colors.white,
                                        size: 14,
                                        fw: FontWeight.w600,
                                      ),
                                      AppText(
                                        data: '6:27 AM',
                                        color: Colors.white,
                                        size: 14,
                                        fw: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(children: [
                                    Image.asset(
                                      moonpic,
                                      height: 35,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        AppText(
                                          data: 'Sunset',
                                          color: Colors.white,
                                          size: 14,
                                          fw: FontWeight.w600,
                                        ),
                                        AppText(
                                          data: '6:03 PM',
                                          color: Colors.white,
                                          size: 14,
                                          fw: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ]),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
