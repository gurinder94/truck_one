class WeatherModel {
  WeatherModel({
    this.location,
    this.current,
    this.forecast,
    this.alerts,
  });

  Location? location;
  Current? current;
  Forecast? forecast;
  Alerts? alerts;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
    forecast: Forecast.fromJson(json["forecast"]),
    alerts: Alerts.fromJson(json["alerts"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location!.toJson(),
    "current": current!.toJson(),
    "forecast": forecast!.toJson(),
    "alerts": alerts!.toJson(),
  };
}

class Alerts {
  Alerts({
    this.alert,
  });

  List<Alert>? alert;

  factory Alerts.fromJson(Map<String, dynamic> json) => Alerts(
    alert: List<Alert>.from(json["alert"].map((x) => Alert.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "alert": List<dynamic>.from(alert!.map((x) => x.toJson())),
  };
}

class Alert {
  Alert({
    this.headline,
    this.msgtype,
    this.severity,
    this.urgency,
    this.areas,
    this.category,
    this.certainty,
    this.event,
    this.note,
    this.effective,
    this.expires,
    this.desc,
    this.instruction,
  });

  String? headline;
  String? msgtype;
  String? severity;
  String? urgency;
  String? areas;
  String? category;
  String? certainty;
  String? event;
  String? note;
  DateTime? effective;
  DateTime? expires;
  String? desc;
  String? instruction;

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    headline: json["headline"],
    msgtype: json["msgtype"],
    severity: json["severity"],
    urgency: json["urgency"],
    areas: json["areas"],
    category: json["category"],
    certainty: json["certainty"],
    event: json["event"],
    note: json["note"],
    effective: DateTime.parse(json["effective"]),
    expires: DateTime.parse(json["expires"]),
    desc: json["desc"],
    instruction: json["instruction"],
  );

  Map<String, dynamic> toJson() => {
    "headline": headline,
    "msgtype": msgtype,
    "severity": severity,
    "urgency": urgency,
    "areas": areas,
    "category": category,
    "certainty": certainty,
    "event": event,
    "note": note,
    "effective": effective!.toIso8601String(),
    "expires": expires!.toIso8601String(),
    "desc": desc,
    "instruction": instruction,
  };
}

class Current {
  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
    this.airQuality,
  });

  dynamic lastUpdatedEpoch;
  String? lastUpdated;
  dynamic tempC;
  dynamic tempF;
  dynamic isDay;
  Condition? condition;
  dynamic windMph;
  dynamic windKph;
  dynamic windDegree;
  String? windDir;
  dynamic pressureMb;
  dynamic pressureIn;
  dynamic precipMm;
  dynamic precipIn;
  dynamic humidity;
  dynamic cloud;
  dynamic feelslikeC;
  dynamic feelslikeF;
  dynamic visKm;
  dynamic visMiles;
  dynamic uv;
  dynamic gustMph;
  dynamic gustKph;
  Map<String, double>? airQuality;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"].toDouble(),
    tempF: json["temp_f"].toDouble(),
    isDay: json["is_day"],
    condition: Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"],
    windKph: json["wind_kph"],
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"],
    pressureIn: json["pressure_in"].toDouble(),
    precipMm: json["precip_mm"],
    precipIn: json["precip_in"],
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"].toDouble(),
    feelslikeF: json["feelslike_f"].toDouble(),
    visKm: json["vis_km"],
    visMiles: json["vis_miles"],
    uv: json["uv"],
    gustMph: json["gust_mph"].toDouble(),
    gustKph: json["gust_kph"].toDouble(),
    airQuality: Map.from(json["air_quality"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition!.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "uv": uv,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
    "air_quality": Map.from(airQuality!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class Condition {
  Condition({
    this.text,
    this.icon,
    this.code,
  });

  String? text;
  String? icon;
  dynamic code;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    text: json["text"],
    icon: json["icon"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon,
    "code": code,
  };
}

class Forecast {
  Forecast({
    this.forecastday,
  });

  List<Forecastday>? forecastday;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecastday: List<Forecastday>.from(json["forecastday"].map((x) => Forecastday.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "forecastday": List<dynamic>.from(forecastday!.map((x) => x.toJson())),
  };
}

class Forecastday {
  Forecastday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  DateTime? date;
  dynamic dateEpoch;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
    date: DateTime.parse(json["date"]),
    dateEpoch: json["date_epoch"],
    day: Day.fromJson(json["day"]),
    astro: Astro.fromJson(json["astro"]),
    hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "date_epoch": dateEpoch,
    "day": day!.toJson(),
    "astro": astro!.toJson(),
    "hour": List<dynamic>.from(hour!.map((x) => x.toJson())),
  };
}

class Astro {
  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
  });

  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonIllumination;

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"],
    moonIllumination: json["moon_illumination"],
  );

  Map<String, dynamic> toJson() => {
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "moon_illumination": moonIllumination,
  };
}

class Day {
  Day({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
  });

  dynamic maxtempC;
  dynamic maxtempF;
  dynamic mintempC;
  dynamic mintempF;
  dynamic avgtempC;
  dynamic avgtempF;
  dynamic maxwindMph;
  dynamic maxwindKph;
  dynamic totalprecipMm;
  dynamic totalprecipIn;
  dynamic avgvisKm;
  dynamic avgvisMiles;
  dynamic avghumidity;
  dynamic dailyWillItRain;
  dynamic dailyChanceOfRain;
  dynamic dailyWillItSnow;
  dynamic dailyChanceOfSnow;
  Condition? condition;
  dynamic uv;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    maxtempC: json["maxtemp_c"].toDouble(),
    maxtempF: json["maxtemp_f"].toDouble(),
    mintempC: json["mintemp_c"].toDouble(),
    mintempF: json["mintemp_f"].toDouble(),
    avgtempC: json["avgtemp_c"].toDouble(),
    avgtempF: json["avgtemp_f"].toDouble(),
    maxwindMph: json["maxwind_mph"].toDouble(),
    maxwindKph: json["maxwind_kph"].toDouble(),
    totalprecipMm: json["totalprecip_mm"].toDouble(),
    totalprecipIn: json["totalprecip_in"].toDouble(),
    avgvisKm: json["avgvis_km"].toDouble(),
    avgvisMiles: json["avgvis_miles"],
    avghumidity: json["avghumidity"],
    dailyWillItRain: json["daily_will_it_rain"],
    dailyChanceOfRain: json["daily_chance_of_rain"],
    dailyWillItSnow: json["daily_will_it_snow"],
    dailyChanceOfSnow: json["daily_chance_of_snow"],
    condition: Condition.fromJson(json["condition"]),
    uv: json["uv"],
  );

  Map<String, dynamic> toJson() => {
    "maxtemp_c": maxtempC,
    "maxtemp_f": maxtempF,
    "mintemp_c": mintempC,
    "mintemp_f": mintempF,
    "avgtemp_c": avgtempC,
    "avgtemp_f": avgtempF,
    "maxwind_mph": maxwindMph,
    "maxwind_kph": maxwindKph,
    "totalprecip_mm": totalprecipMm,
    "totalprecip_in": totalprecipIn,
    "avgvis_km": avgvisKm,
    "avgvis_miles": avgvisMiles,
    "avghumidity": avghumidity,
    "daily_will_it_rain": dailyWillItRain,
    "daily_chance_of_rain": dailyChanceOfRain,
    "daily_will_it_snow": dailyWillItSnow,
    "daily_chance_of_snow": dailyChanceOfSnow,
    "condition": condition!.toJson(),
    "uv": uv,
  };
}

class Hour {
  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.visKm,
    this.visMiles,
    this.gustMph,
    this.gustKph,
    this.uv,
  });

  dynamic timeEpoch;
  String? time;
  dynamic tempC;
  dynamic tempF;
  dynamic isDay;
  Condition? condition;
  dynamic windMph;
  dynamic windKph;
  dynamic windDegree;
  String? windDir;
  dynamic pressureMb;
  dynamic pressureIn;
  dynamic precipMm;
  dynamic precipIn;
  dynamic humidity;
  dynamic cloud;
  dynamic feelslikeC;
  dynamic feelslikeF;
  dynamic windchillC;
  dynamic windchillF;
  dynamic heatindexC;
  dynamic heatindexF;
  dynamic dewpointC;
  dynamic dewpointF;
  dynamic willItRain;
  dynamic chanceOfRain;
  dynamic willItSnow;
  dynamic chanceOfSnow;
  dynamic visKm;
  dynamic visMiles;
  dynamic gustMph;
  dynamic gustKph;
  dynamic uv;

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    timeEpoch: json["time_epoch"],
    time: json["time"],
    tempC: json["temp_c"].toDouble(),
    tempF: json["temp_f"].toDouble(),
    isDay: json["is_day"],
    condition: Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"].toDouble(),
    windKph: json["wind_kph"].toDouble(),
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"],
    pressureIn: json["pressure_in"].toDouble(),
    precipMm: json["precip_mm"],
    precipIn: json["precip_in"],
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"].toDouble(),
    feelslikeF: json["feelslike_f"].toDouble(),
    windchillC: json["windchill_c"].toDouble(),
    windchillF: json["windchill_f"].toDouble(),
    heatindexC: json["heatindex_c"].toDouble(),
    heatindexF: json["heatindex_f"].toDouble(),
    dewpointC: json["dewpoint_c"].toDouble(),
    dewpointF: json["dewpoint_f"].toDouble(),
    willItRain: json["will_it_rain"],
    chanceOfRain: json["chance_of_rain"],
    willItSnow: json["will_it_snow"],
    chanceOfSnow: json["chance_of_snow"],
    visKm: json["vis_km"],
    visMiles: json["vis_miles"],
    gustMph: json["gust_mph"].toDouble(),
    gustKph: json["gust_kph"].toDouble(),
    uv: json["uv"],
  );

  Map<String, dynamic> toJson() => {
    "time_epoch": timeEpoch,
    "time": time,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition!.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "windchill_c": windchillC,
    "windchill_f": windchillF,
    "heatindex_c": heatindexC,
    "heatindex_f": heatindexF,
    "dewpoint_c": dewpointC,
    "dewpoint_f": dewpointF,
    "will_it_rain": willItRain,
    "chance_of_rain": chanceOfRain,
    "will_it_snow": willItSnow,
    "chance_of_snow": chanceOfSnow,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
    "uv": uv,
  };
}

class Location {
  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  String? name;
  String? region;
  String? country;
  dynamic lat;
  dynamic lon;
  String? tzId;
  dynamic localtimeEpoch;
  String? localtime;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    tzId: json["tz_id"],
    localtimeEpoch: json["localtime_epoch"],
    localtime: json["localtime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "tz_id": tzId,
    "localtime_epoch": localtimeEpoch,
    "localtime": localtime,
  };
}
