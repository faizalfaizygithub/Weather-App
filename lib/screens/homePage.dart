import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/assets.dart';
import 'package:weather_app/services/location_Provider.dart';
import 'package:weather_app/services/weather_service_provider.dart';
import 'package:weather_app/utilities/appText.dart';
import 'package:weather_app/utilities/customDivider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceProvider>(context, listen: false)
              .fetchWeatherDataByCity(city.toString());
        }
      }
    });

    super.initState();
  }

  TextEditingController _cityController = TextEditingController();
  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final locationProvider = Provider.of<LocationProvider>(context);
    // Get the weather data from the WeatherServiceProvider
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);
// Inside the build method of your _HomePageState class

// Get the sunrise timestamp from the API response
    int sunriseTimestamp = weatherProvider.weather?.sys?.sunrise ??
        0; // Replace 0 with a default timestamp if needed
    int sunsetTimestamp = weatherProvider.weather?.sys?.sunset ??
        0; // Replace 0 with a default timestamp if needed

// Convert the timestamp to a DateTime object
    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);

// Format the sunrise time as a string
    String formattedSunrise = DateFormat.Hm().format(sunriseDateTime);
    String formattedSunset = DateFormat.Hm().format(sunsetDateTime);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Container(
        padding:
            const EdgeInsets.only(top: 65, left: 20, right: 20, bottom: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  background[weatherProvider.weather?.weather![0]?.main ??
                          "N/A"] ??
                      "assets/img/bg1.jpg",
                ))),
        child: Stack(
          children: [
            Container(
              height: 50,
              child: Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                var locationCity;
                if (locationProvider.currentLocationName != null) {
                  locationCity = locationProvider.currentLocationName!.locality;
                } else {
                  locationCity = "Unknown Location";
                }

                return ListTile(
                  leading: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 30,
                  ),
                  title: AppText(
                    data: locationCity,
                    color: Colors.white,
                    fw: FontWeight.w700,
                    size: 18,
                  ),
                  subtitle: AppText(
                    data: "Good Morning",
                    color: Colors.white,
                    fw: FontWeight.w400,
                    size: 14,
                  ),
                );
              }),
            ),
            Align(
              alignment: const Alignment(0, -0.6),
              child: Image.asset(
                imagePath[weatherProvider.weather?.weather![0].main ?? "N/A"] ??
                    "assets/img/cloudicon.webp",
                width: 200,
                height: 200,
                // Adjust the height as needed
              ),
            ),
            Align(
              alignment: const Alignment(0, 0),
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data:
                          "${weatherProvider.weather?.main!.temp!.toStringAsFixed(0)} \u00B0C" ??
                              "", // Display temperature
                      color: Colors.white,
                      fw: FontWeight.bold,
                      size: 32,
                    ),
                    AppText(
                      data: weatherProvider.weather?.name ?? "N/A",
                      color: Colors.white,
                      fw: FontWeight.w600,
                      size: 20,
                    ),
                    AppText(
                      data: weatherProvider.weather?.weather![0].main ?? "N/A",
                      color: Colors.white,
                      fw: FontWeight.w600,
                      size: 20,
                    ),
                    AppText(
                      data: DateFormat('hh:mm a').format(DateTime.now()),
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.75),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.4)),
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              temphighpic,
                              height: 55,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Temp Max",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                ),
                                AppText(
                                  data:
                                      "${weatherProvider.weather?.main!.tempMax!.toStringAsFixed(0)} \u00B0C" ??
                                          "N/A",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              templowpic,
                              height: 55,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Temp Min",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                ),
                                AppText(
                                  data:
                                      "${weatherProvider.weather?.main!.tempMin!.toStringAsFixed(0)} \u00B0C" ??
                                          "N/A",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    CustomDivider(
                      startIndent: 20,
                      endIndent: 20,
                      color: Colors.white,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              sunpic,
                              height: 50,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Sunrise",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                ),
                                AppText(
                                  data: "${formattedSunrise} PM",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              moonpic,
                              height: 50,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Sunset",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                ),
                                AppText(
                                  data: "${formattedSunset} PM",
                                  color: Colors.white,
                                  size: 14,
                                  fw: FontWeight.w600,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _cityController,
                        decoration: const InputDecoration(
                          hintText: 'Search your city',
                          hintStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Provider.of<WeatherServiceProvider>(context,
                                  listen: false)
                              .fetchWeatherDataByCity(
                                  _cityController.text.toString());
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
