import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:intl/intl.dart';


import 'package:cometchat_uikit_shared/src/utils/timezone_utils/date_time.dart';
import 'package:cometchat_uikit_shared/src/utils/timezone_utils/env.dart';

class SchedulerUtils {
  static String getTimeZoneIdentifiers(String zone){

    final res = timeZoneDatabase.locations[zone]?.currentTimeZone.abbreviation;

    return res ?? "";
  }

  static Map<String, Map> timeZones = {
    "Etc/GMT+12": {"abbr" : "DST", "name" : "Dateline Standard Time"},
    "Etc/GMT+11": {"abbr" : "U", "name" : "UTC-11"},
    "Pacific/Midway": {"abbr" : "U", "name" : "UTC-11"},
    "Pacific/Niue": {"abbr" : "U", "name" : "UTC-11"},
    "Pacific/Pago_Pago": {"abbr" : "U", "name" : "UTC-11"},
    "Etc/GMT+10": {"abbr" : "HST", "name" : "Hawaiian Standard Time"},
    "Pacific/Honolulu": {"abbr" : "HST", "name" : "Hawaiian Standard Time"},
    "Pacific/Johnston": {"abbr" : "HST", "name" : "Hawaiian Standard Time"},
    "Pacific/Rarotonga": {"abbr" : "HST", "name" : "Hawaiian Standard Time"},
    "Pacific/Tahiti": {"abbr" : "HST", "name" : "Hawaiian Standard Time"},
    "America/Anchorage": {"abbr" : "AKDT", "name" : "Alaskan Standard Time"},
    "America/Juneau": {"abbr" : "AKDT", "name" : "Alaskan Standard Time"},
    "America/Nome": {"abbr" : "AKDT", "name" : "Alaskan Standard Time"},
    "America/Sitka": {"abbr" : "AKDT", "name" : "Alaskan Standard Time"},
    "America/Yakutat": {"abbr" : "AKDT", "name" : "Alaskan Standard Time"},
    "America/Santa_Isabel": {"abbr" : "PDT", "name" : "Pacific Standard Time (Mexico)"},
    "America/Los_Angeles": {"abbr" : "PDT", "name" : "Pacific Daylight Time"},
    "America/Tijuana": {"abbr" : "PDT", "name" : "Pacific Daylight Time"},
    "America/Vancouver": {"abbr" : "PDT", "name" : "Pacific Daylight Time"},
    "America/Los_Angeles": {"abbr" : "PST", "name" : "Pacific Standard Time"},
    "America/Tijuana": {"abbr" : "PST", "name" : "Pacific Standard Time"},
    "America/Vancouver": {"abbr" : "PST", "name" : "Pacific Standard Time"},
    "PST8PDT": {"abbr" : "PST", "name" : "Pacific Standard Time"},
    "America/Creston": {"abbr" : "UMST", "name" : "US Mountain Standard Time"},
    "America/Dawson": {"abbr" : "UMST", "name" : "US Mountain Standard Time"},
    "America/Dawson_Creek": {"abbr" : "UMST", "name" : "US Mountain Standard Time"},
    "America/Hermosillo": {"abbr" : "UMST", "name" : "US Mountain Standard Time"},
    "America/Phoenix": {"abbr" : "UMST", "name" : "US Mountain Standard Time"},
    "America/Whitehorse": {"abbr" : "UMST", "name" : "US Mountain Standard Time"},
    "Etc/GMT+7": {"abbr" : "UMST", "name" : "US Mountain Standard Time"},
    "America/Chihuahua": {"abbr" : "MDT", "name" : "Mountain Standard Time (Mexico)"},
    "America/Mazatlan": {"abbr" : "MDT", "name" : "Mountain Standard Time (Mexico)"},
    "America/Boise": {"abbr" : "MDT", "name" : "Mountain Standard Time"},
    "America/Cambridge_Bay": {"abbr" : "MDT", "name" : "Mountain Standard Time"},
    "America/Denver": {"abbr" : "MDT", "name" : "Mountain Standard Time"},
    "America/Edmonton": {"abbr" : "MDT", "name" : "Mountain Standard Time"},
    "America/Inuvik": {"abbr" : "MDT", "name" : "Mountain Standard Time"},
    "America/Ojinaga": {"abbr" : "MDT", "name" : "Mountain Standard Time"},
    "America/Yellowknife": {"abbr" : "MDT", "name" : "Mountain Standard Time"},
    "MST7MDT": {"abbr" : "MDT", "name" : "Mountain Standard Time"},
    "America/Belize": {"abbr" : "CAST", "name" : "Central America Standard Time"},
    "America/Costa_Rica": {"abbr" : "CAST", "name" : "Central America Standard Time"},
    "America/El_Salvador": {"abbr" : "CAST", "name" : "Central America Standard Time"},
    "America/Guatemala": {"abbr" : "CAST", "name" : "Central America Standard Time"},
    "America/Managua": {"abbr" : "CAST", "name" : "Central America Standard Time"},
    "America/Tegucigalpa": {"abbr" : "CAST", "name" : "Central America Standard Time"},
    "Etc/GMT+6": {"abbr" : "CAST", "name" : "Central America Standard Time"},
    "Pacific/Galapagos": {"abbr" : "CAST", "name" : "Central America Standard Time"},
    "America/Chicago": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Indiana/Knox": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Indiana/Tell_City": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Matamoros": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Menominee": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/North_Dakota/Beulah": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/North_Dakota/Center": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/North_Dakota/New_Salem": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Rainy_River": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Rankin_Inlet": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Resolute": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Winnipeg": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "CST6CDT": {"abbr" : "CDT", "name" : "Central Standard Time"},
    "America/Bahia_Banderas": {"abbr" : "CDT", "name" : "Central Standard Time (Mexico)"},
    "America/Cancun": {"abbr" : "CDT", "name" : "Central Standard Time (Mexico)"},
    "America/Merida": {"abbr" : "CDT", "name" : "Central Standard Time (Mexico)"},
    "America/Mexico_City": {"abbr" : "CDT", "name" : "Central Standard Time (Mexico)"},
    "America/Monterrey": {"abbr" : "CDT", "name" : "Central Standard Time (Mexico)"},
    "America/Regina": {"abbr" : "CCST", "name" : "Canada Central Standard Time"},
    "America/Swift_Current": {"abbr" : "CCST", "name" : "Canada Central Standard Time"},
    "America/Bogota": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Cayman": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Coral_Harbour": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Eirunepe": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Guayaquil": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Jamaica": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Lima": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Panama": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Rio_Branco": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "Etc/GMT+5": {"abbr" : "SPST", "name" : "SA Pacific Standard Time"},
    "America/Detroit": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Havana": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Indiana/Petersburg": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Indiana/Vincennes": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Indiana/Winamac": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Iqaluit": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Kentucky/Monticello": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Louisville": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Montreal": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Nassau": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/New_York": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Nipigon": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Pangnirtung": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Port-au-Prince": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Thunder_Bay": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Toronto": {"abbr" : "EST", "name" : "Eastern Standard Time"},
    "America/Detroit": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Havana": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Indiana/Petersburg": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Indiana/Vincennes": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Indiana/Winamac": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Iqaluit": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Kentucky/Monticello": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Louisville": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Montreal": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Nassau": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/New_York": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Nipigon": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Pangnirtung": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Port-au-Prince": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Thunder_Bay": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Toronto": {"abbr" : "EDT", "name" : "Eastern Daylight Time"},
    "America/Indiana/Marengo": {"abbr" : "UEDT", "name" : "US Eastern Standard Time"},
    "America/Indiana/Vevay": {"abbr" : "UEDT", "name" : "US Eastern Standard Time"},
    "America/Indianapolis": {"abbr" : "UEDT", "name" : "US Eastern Standard Time"},
    "America/Caracas": {"abbr" : "VST", "name" : "Venezuela Standard Time"},
    "America/Asuncion": {"abbr" : "PYT", "name" : "Paraguay Standard Time"},
    "America/Glace_Bay": {"abbr" : "ADT", "name" : "Atlantic Standard Time"},
    "America/Goose_Bay": {"abbr" : "ADT", "name" : "Atlantic Standard Time"},
    "America/Halifax": {"abbr" : "ADT", "name" : "Atlantic Standard Time"},
    "America/Moncton": {"abbr" : "ADT", "name" : "Atlantic Standard Time"},
    "America/Thule": {"abbr" : "ADT", "name" : "Atlantic Standard Time"},
    "Atlantic/Bermuda": {"abbr" : "ADT", "name" : "Atlantic Standard Time"},
    "America/Campo_Grande": {"abbr" : "CBST", "name" : "Central Brazilian Standard Time"},
    "America/Cuiaba": {"abbr" : "CBST", "name" : "Central Brazilian Standard Time"},
    "America/Anguilla": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Antigua": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Aruba": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Barbados": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Blanc-Sablon": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Boa_Vista": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Curacao": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Dominica": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Grand_Turk": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Grenada": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Guadeloupe": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Guyana": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Kralendijk": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/La_Paz": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Lower_Princes": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Manaus": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Marigot": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Martinique": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Montserrat": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Port_of_Spain": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Porto_Velho": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Puerto_Rico": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Santo_Domingo": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/St_Barthelemy": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/St_Kitts": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/St_Lucia": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/St_Thomas": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/St_Vincent": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Tortola": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "Etc/GMT+4": {"abbr" : "SWST", "name" : "SA Western Standard Time"},
    "America/Santiago": {"abbr" : "PSST", "name" : "Pacific SA Standard Time"},
    "Antarctica/Palmer": {"abbr" : "PSST", "name" : "Pacific SA Standard Time"},
    "America/St_Johns": {"abbr" : "NDT", "name" : "Newfoundland Standard Time"},
    "America/Sao_Paulo": {"abbr" : "ESAST", "name" : "E. South America Standard Time"},
    "America/Argentina/Buenos_Aires": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/Catamarca": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/Cordoba": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/Jujuy": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/La_Rioja": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/Mendoza": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/Rio_Gallegos": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/Salta": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/San_Juan": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/San_Luis": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/Tucuman": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Argentina/Ushuaia": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Buenos_Aires": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Catamarca": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Cordoba": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Jujuy": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Mendoza": {"abbr" : "AST", "name" : "Argentina Standard Time"},
    "America/Araguaina": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "America/Belem": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "America/Cayenne": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "America/Fortaleza": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "America/Maceio": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "America/Paramaribo": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "America/Recife": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "America/Santarem": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "Antarctica/Rothera": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "Atlantic/Stanley": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "Etc/GMT+3": {"abbr" : "SEST", "name" : "SA Eastern Standard Time"},
    "America/Godthab": {"abbr" : "GDT", "name" : "Greenland Standard Time"},
    "America/Montevideo": {"abbr" : "MST", "name" : "Montevideo Standard Time"},
    "America/Bahia": {"abbr" : "BST", "name" : "Bahia Standard Time"},
    "America/Noronha": {"abbr" : "U", "name" : "UTC-02"},
    "Atlantic/South_Georgia": {"abbr" : "U", "name" : "UTC-02"},
    "Etc/GMT+2": {"abbr" : "U", "name" : "UTC-02"},
    "America/Scoresbysund": {"abbr" : "ADT", "name" : "Azores Standard Time"},
    "Atlantic/Azores": {"abbr" : "ADT", "name" : "Azores Standard Time"},
    "Atlantic/Cape_Verde": {"abbr" : "CVST", "name" : "Cape Verde Standard Time"},
    "Etc/GMT+1": {"abbr" : "CVST", "name" : "Cape Verde Standard Time"},
    "Africa/Casablanca": {"abbr" : "MDT", "name" : "Morocco Standard Time"},
    "Africa/El_Aaiun": {"abbr" : "MDT", "name" : "Morocco Standard Time"},
    "America/Danmarkshavn": {"abbr" : "UTC", "name" : "UTC"},
    "Etc/GMT": {"abbr" : "UTC", "name" : "UTC"},
    "Europe/Isle_of_Man": {"abbr" : "GMT", "name" : "GMT Standard Time"},
    "Europe/Guernsey": {"abbr" : "GMT", "name" : "GMT Standard Time"},
    "Europe/Jersey": {"abbr" : "GMT", "name" : "GMT Standard Time"},
    "Europe/London": {"abbr" : "GMT", "name" : "GMT Standard Time"},
    "Europe/Isle_of_Man": {"abbr" : "BST", "name" : "British Summer Time"},
    "Europe/Guernsey": {"abbr" : "BST", "name" : "British Summer Time"},
    "Europe/Jersey": {"abbr" : "BST", "name" : "British Summer Time"},
    "Europe/London": {"abbr" : "BST", "name" : "British Summer Time"},
    "Atlantic/Canary": {"abbr" : "GDT", "name" : "GMT Standard Time"},
    "Atlantic/Faeroe": {"abbr" : "GDT", "name" : "GMT Standard Time"},
    "Atlantic/Madeira": {"abbr" : "GDT", "name" : "GMT Standard Time"},
    "Europe/Dublin": {"abbr" : "GDT", "name" : "GMT Standard Time"},
    "Europe/Lisbon": {"abbr" : "GDT", "name" : "GMT Standard Time"},
    "Africa/Abidjan": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Accra": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Bamako": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Banjul": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Bissau": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Conakry": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Dakar": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Freetown": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Lome": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Monrovia": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Nouakchott": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Ouagadougou": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Africa/Sao_Tome": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Atlantic/Reykjavik": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Atlantic/St_Helena": {"abbr" : "GST", "name" : "Greenwich Standard Time"},
    "Arctic/Longyearbyen": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Amsterdam": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Andorra": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Berlin": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Busingen": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Gibraltar": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Luxembourg": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Malta": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Monaco": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Oslo": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Rome": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/San_Marino": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Stockholm": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Vaduz": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Vatican": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Vienna": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Zurich": {"abbr" : "WEDT", "name" : "W. Europe Standard Time"},
    "Europe/Belgrade": {"abbr" : "CEDT", "name" : "Central Europe Standard Time"},
    "Europe/Bratislava": {"abbr" : "CEDT", "name" : "Central Europe Standard Time"},
    "Europe/Budapest": {"abbr" : "CEDT", "name" : "Central Europe Standard Time"},
    "Europe/Ljubljana": {"abbr" : "CEDT", "name" : "Central Europe Standard Time"},
    "Europe/Podgorica": {"abbr" : "CEDT", "name" : "Central Europe Standard Time"},
    "Europe/Prague": {"abbr" : "CEDT", "name" : "Central Europe Standard Time"},
    "Europe/Tirane": {"abbr" : "CEDT", "name" : "Central Europe Standard Time"},
    "Africa/Ceuta": {"abbr" : "RDT", "name" : "Romance Standard Time"},
    "Europe/Brussels": {"abbr" : "RDT", "name" : "Romance Standard Time"},
    "Europe/Copenhagen": {"abbr" : "RDT", "name" : "Romance Standard Time"},
    "Europe/Madrid": {"abbr" : "RDT", "name" : "Romance Standard Time"},
    "Europe/Paris": {"abbr" : "RDT", "name" : "Romance Standard Time"},
    "Europe/Sarajevo": {"abbr" : "CEDT", "name" : "Central European Standard Time"},
    "Europe/Skopje": {"abbr" : "CEDT", "name" : "Central European Standard Time"},
    "Europe/Warsaw": {"abbr" : "CEDT", "name" : "Central European Standard Time"},
    "Europe/Zagreb": {"abbr" : "CEDT", "name" : "Central European Standard Time"},
    "Africa/Algiers": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Bangui": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Brazzaville": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Douala": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Kinshasa": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Lagos": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Libreville": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Luanda": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Malabo": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Ndjamena": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Niamey": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Porto-Novo": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Tunis": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Etc/GMT-1": {"abbr" : "WCAST", "name" : "W. Central Africa Standard Time"},
    "Africa/Windhoek": {"abbr" : "NST", "name" : "Namibia Standard Time"},
    "Asia/Nicosia": {"abbr" : "GDT", "name" : "GTB Standard Time"},
    "Europe/Athens": {"abbr" : "GDT", "name" : "GTB Standard Time"},
    "Europe/Bucharest": {"abbr" : "GDT", "name" : "GTB Standard Time"},
    "Europe/Chisinau": {"abbr" : "GDT", "name" : "GTB Standard Time"},
    "Asia/Beirut": {"abbr" : "MEDT", "name" : "Middle East Standard Time"},
    "Africa/Cairo": {"abbr" : "EST", "name" : "Egypt Standard Time"},
    "Asia/Damascus": {"abbr" : "SDT", "name" : "Syria Standard Time"},
    "Asia/Nicosia": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Athens": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Bucharest": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Chisinau": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Helsinki": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Kyiv": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Mariehamn": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Nicosia": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Riga": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Sofia": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Tallinn": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Uzhgorod": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Vilnius": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Europe/Zaporozhye": {"abbr" : "EEDT", "name" : "E. Europe Standard Time"},
    "Africa/Blantyre": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Bujumbura": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Gaborone": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Harare": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Johannesburg": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Kigali": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Lubumbashi": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Lusaka": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Maputo": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Maseru": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Africa/Mbabane": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Etc/GMT-2": {"abbr" : "SAST", "name" : "South Africa Standard Time"},
    "Europe/Helsinki": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Kyiv": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Mariehamn": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Riga": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Sofia": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Tallinn": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Uzhgorod": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Vilnius": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Zaporozhye": {"abbr" : "FDT", "name" : "FLE Standard Time"},
    "Europe/Istanbul": {"abbr" : "TDT", "name" : "Turkey Standard Time"},
    "Asia/Jerusalem": {"abbr" : "JDT", "name" : "Israel Standard Time"},
    "Africa/Tripoli": {"abbr" : "LST", "name" : "Libya Standard Time"},
    "Asia/Amman": {"abbr" : "JST", "name" : "Jordan Standard Time"},
    "Asia/Baghdad": {"abbr" : "AST", "name" : "Arabic Standard Time"},
    "Europe/Kaliningrad": {"abbr" : "KST", "name" : "Kaliningrad Standard Time"},
    "Asia/Aden": {"abbr" : "AST", "name" : "Arab Standard Time"},
    "Asia/Bahrain": {"abbr" : "AST", "name" : "Arab Standard Time"},
    "Asia/Kuwait": {"abbr" : "AST", "name" : "Arab Standard Time"},
    "Asia/Qatar": {"abbr" : "AST", "name" : "Arab Standard Time"},
    "Asia/Riyadh": {"abbr" : "AST", "name" : "Arab Standard Time"},
    "Africa/Addis_Ababa": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Africa/Asmera": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Africa/Dar_es_Salaam": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Africa/Djibouti": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Africa/Juba": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Africa/Kampala": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Africa/Khartoum": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Africa/Mogadishu": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Africa/Nairobi": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Antarctica/Syowa": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Etc/GMT-3": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Indian/Antananarivo": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Indian/Comoro": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Indian/Mayotte": {"abbr" : "EAST", "name" : "E. Africa Standard Time"},
    "Europe/Kirov": {"abbr" : "MSK", "name" : "Moscow Standard Time"},
    "Europe/Moscow": {"abbr" : "MSK", "name" : "Moscow Standard Time"},
    "Europe/Simferopol": {"abbr" : "MSK", "name" : "Moscow Standard Time"},
    "Europe/Volgograd": {"abbr" : "MSK", "name" : "Moscow Standard Time"},
    "Europe/Minsk": {"abbr" : "MSK", "name" : "Moscow Standard Time"},
    "Europe/Astrakhan": {"abbr" : "SAMT", "name" : "Samara Time"},
    "Europe/Samara": {"abbr" : "SAMT", "name" : "Samara Time"},
    "Europe/Ulyanovsk": {"abbr" : "SAMT", "name" : "Samara Time"},
    "Asia/Tehran": {"abbr" : "IDT", "name" : "Iran Standard Time"},
    "Asia/Dubai": {"abbr" : "AST", "name" : "Arabian Standard Time"},
    "Asia/Muscat": {"abbr" : "AST", "name" : "Arabian Standard Time"},
    "Etc/GMT-4": {"abbr" : "AST", "name" : "Arabian Standard Time"},
    "Asia/Baku": {"abbr" : "ADT", "name" : "Azerbaijan Standard Time"},
    "Indian/Mahe": {"abbr" : "MST", "name" : "Mauritius Standard Time"},
    "Indian/Mauritius": {"abbr" : "MST", "name" : "Mauritius Standard Time"},
    "Indian/Reunion": {"abbr" : "MST", "name" : "Mauritius Standard Time"},
    "Asia/Tbilisi": {"abbr" : "GET", "name" : "Georgian Standard Time"},
    "Asia/Yerevan": {"abbr" : "CST", "name" : "Caucasus Standard Time"},
    "Asia/Kabul": {"abbr" : "AST", "name" : "Afghanistan Standard Time"},
    "Antarctica/Mawson": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Asia/Aqtau": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Asia/Aqtobe": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Asia/Ashgabat": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Asia/Dushanbe": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Asia/Oral": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Asia/Samarkand": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Asia/Tashkent": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Etc/GMT-5": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Indian/Kerguelen": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Indian/Maldives": {"abbr" : "WAST", "name" : "West Asia Standard Time"},
    "Asia/Yekaterinburg": {"abbr" : "YEKT", "name" : "Yekaterinburg Time"},
    "Asia/Karachi": {"abbr" : "PKT", "name" : "Pakistan Standard Time"},
    "Asia/Kolkata": {"abbr" : "IST", "name" : "Indian Standard Time"},
    "Asia/Calcutta": {"abbr" : "IST", "name" : "Indian Standard Time"},
    "Asia/Colombo": {"abbr" : "SLST", "name" : "Sri Lanka Standard Time"},
    "Asia/Kathmandu": {"abbr" : "NST", "name" : "Nepal Standard Time"},
    "Antarctica/Vostok": {"abbr" : "CAST", "name" : "Central Asia Standard Time"},
    "Asia/Almaty": {"abbr" : "CAST", "name" : "Central Asia Standard Time"},
    "Asia/Bishkek": {"abbr" : "CAST", "name" : "Central Asia Standard Time"},
    "Asia/Qyzylorda": {"abbr" : "CAST", "name" : "Central Asia Standard Time"},
    "Asia/Urumqi": {"abbr" : "CAST", "name" : "Central Asia Standard Time"},
    "Etc/GMT-6": {"abbr" : "CAST", "name" : "Central Asia Standard Time"},
    "Indian/Chagos": {"abbr" : "CAST", "name" : "Central Asia Standard Time"},
    "Asia/Dhaka": {"abbr" : "BST", "name" : "Bangladesh Standard Time"},
    "Asia/Thimphu": {"abbr" : "BST", "name" : "Bangladesh Standard Time"},
    "Asia/Rangoon": {"abbr" : "MST", "name" : "Myanmar Standard Time"},
    "Indian/Cocos": {"abbr" : "MST", "name" : "Myanmar Standard Time"},
    "Antarctica/Davis": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Asia/Bangkok": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Asia/Hovd": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Asia/Jakarta": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Asia/Phnom_Penh": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Asia/Pontianak": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Asia/Saigon": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Asia/Vientiane": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Etc/GMT-7": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Indian/Christmas": {"abbr" : "SAST", "name" : "SE Asia Standard Time"},
    "Asia/Novokuznetsk": {"abbr" : "NCAST", "name" : "N. Central Asia Standard Time"},
    "Asia/Novosibirsk": {"abbr" : "NCAST", "name" : "N. Central Asia Standard Time"},
    "Asia/Omsk": {"abbr" : "NCAST", "name" : "N. Central Asia Standard Time"},
    "Asia/Hong_Kong": {"abbr" : "CST", "name" : "China Standard Time"},
    "Asia/Macau": {"abbr" : "CST", "name" : "China Standard Time"},
    "Asia/Shanghai": {"abbr" : "CST", "name" : "China Standard Time"},
    "Asia/Krasnoyarsk": {"abbr" : "NAST", "name" : "North Asia Standard Time"},
    "Asia/Brunei": {"abbr" : "MPST", "name" : "Singapore Standard Time"},
    "Asia/Kuala_Lumpur": {"abbr" : "MPST", "name" : "Singapore Standard Time"},
    "Asia/Kuching": {"abbr" : "MPST", "name" : "Singapore Standard Time"},
    "Asia/Makassar": {"abbr" : "MPST", "name" : "Singapore Standard Time"},
    "Asia/Manila": {"abbr" : "MPST", "name" : "Singapore Standard Time"},
    "Asia/Singapore": {"abbr" : "MPST", "name" : "Singapore Standard Time"},
    "Etc/GMT-8": {"abbr" : "MPST", "name" : "Singapore Standard Time"},
    "Antarctica/Casey": {"abbr" : "WAST", "name" : "W. Australia Standard Time"},
    "Australia/Perth": {"abbr" : "WAST", "name" : "W. Australia Standard Time"},
    "Asia/Taipei": {"abbr" : "TST", "name" : "Taipei Standard Time"},
    "Asia/Choibalsan": {"abbr" : "UST", "name" : "Ulaanbaatar Standard Time"},
    "Asia/Ulaanbaatar": {"abbr" : "UST", "name" : "Ulaanbaatar Standard Time"},
    "Asia/Irkutsk": {"abbr" : "NAEST", "name" : "North Asia East Standard Time"},
    "Asia/Dili": {"abbr" : "JST", "name" : "Japan Standard Time"},
    "Asia/Jayapura": {"abbr" : "JST", "name" : "Japan Standard Time"},
    "Asia/Tokyo": {"abbr" : "JST", "name" : "Japan Standard Time"},
    "Etc/GMT-9": {"abbr" : "JST", "name" : "Japan Standard Time"},
    "Pacific/Palau": {"abbr" : "JST", "name" : "Japan Standard Time"},
    "Asia/Pyongyang": {"abbr" : "KST", "name" : "Korea Standard Time"},
    "Asia/Seoul": {"abbr" : "KST", "name" : "Korea Standard Time"},
    "Australia/Adelaide": {"abbr" : "CAST", "name" : "Cen. Australia Standard Time"},
    "Australia/Broken_Hill": {"abbr" : "CAST", "name" : "Cen. Australia Standard Time"},
    "Australia/Darwin": {"abbr" : "ACST", "name" : "AUS Central Standard Time"},
    "Australia/Brisbane": {"abbr" : "EAST", "name" : "E. Australia Standard Time"},
    "Australia/Lindeman": {"abbr" : "EAST", "name" : "E. Australia Standard Time"},
    "Australia/Melbourne": {"abbr" : "AEST", "name" : "AUS Eastern Standard Time"},
    "Australia/Sydney": {"abbr" : "AEST", "name" : "AUS Eastern Standard Time"},
    "Antarctica/DumontDUrville": {"abbr" : "WPST", "name" : "West Pacific Standard Time"},
    "Etc/GMT-10": {"abbr" : "WPST", "name" : "West Pacific Standard Time"},
    "Pacific/Guam": {"abbr" : "WPST", "name" : "West Pacific Standard Time"},
    "Pacific/Port_Moresby": {"abbr" : "WPST", "name" : "West Pacific Standard Time"},
    "Pacific/Saipan": {"abbr" : "WPST", "name" : "West Pacific Standard Time"},
    "Pacific/Truk": {"abbr" : "WPST", "name" : "West Pacific Standard Time"},
    "Australia/Currie": {"abbr" : "TST", "name" : "Tasmania Standard Time"},
    "Australia/Hobart": {"abbr" : "TST", "name" : "Tasmania Standard Time"},
    "Asia/Chita": {"abbr" : "YST", "name" : "Yakutsk Standard Time"},
    "Asia/Khandyga": {"abbr" : "YST", "name" : "Yakutsk Standard Time"},
    "Asia/Yakutsk": {"abbr" : "YST", "name" : "Yakutsk Standard Time"},
    "Antarctica/Macquarie": {"abbr" : "CPST", "name" : "Central Pacific Standard Time"},
    "Etc/GMT-11": {"abbr" : "CPST", "name" : "Central Pacific Standard Time"},
    "Pacific/Efate": {"abbr" : "CPST", "name" : "Central Pacific Standard Time"},
    "Pacific/Guadalcanal": {"abbr" : "CPST", "name" : "Central Pacific Standard Time"},
    "Pacific/Kosrae": {"abbr" : "CPST", "name" : "Central Pacific Standard Time"},
    "Pacific/Noumea": {"abbr" : "CPST", "name" : "Central Pacific Standard Time"},
    "Pacific/Ponape": {"abbr" : "CPST", "name" : "Central Pacific Standard Time"},
    "Asia/Sakhalin": {"abbr" : "VST", "name" : "Vladivostok Standard Time"},
    "Asia/Ust-Nera": {"abbr" : "VST", "name" : "Vladivostok Standard Time"},
    "Asia/Vladivostok": {"abbr" : "VST", "name" : "Vladivostok Standard Time"},
    "Antarctica/McMurdo": {"abbr" : "NZST", "name" : "New Zealand Standard Time"},
    "Pacific/Auckland": {"abbr" : "NZST", "name" : "New Zealand Standard Time"},
    "Etc/GMT-12": {"abbr" : "U", "name" : "UTC+12"},
    "Pacific/Funafuti": {"abbr" : "U", "name" : "UTC+12"},
    "Pacific/Kwajalein": {"abbr" : "U", "name" : "UTC+12"},
    "Pacific/Majuro": {"abbr" : "U", "name" : "UTC+12"},
    "Pacific/Nauru": {"abbr" : "U", "name" : "UTC+12"},
    "Pacific/Tarawa": {"abbr" : "U", "name" : "UTC+12"},
    "Pacific/Wake": {"abbr" : "U", "name" : "UTC+12"},
    "Pacific/Wallis": {"abbr" : "U", "name" : "UTC+12"},
    "Pacific/Fiji": {"abbr" : "FST", "name" : "Fiji Standard Time"},
    "Asia/Anadyr": {"abbr" : "MST", "name" : "Magadan Standard Time"},
    "Asia/Kamchatka": {"abbr" : "MST", "name" : "Magadan Standard Time"},
    "Asia/Magadan": {"abbr" : "MST", "name" : "Magadan Standard Time"},
    "Asia/Srednekolymsk": {"abbr" : "MST", "name" : "Magadan Standard Time"},
    "Asia/Kamchatka": {"abbr" : "KDT", "name" : "Kamchatka Standard Time"},
    "Etc/GMT-13": {"abbr" : "TST", "name" : "Tonga Standard Time"},
    "Pacific/Enderbury": {"abbr" : "TST", "name" : "Tonga Standard Time"},
    "Pacific/Fakaofo": {"abbr" : "TST", "name" : "Tonga Standard Time"},
    "Pacific/Tongatapu": {"abbr" : "TST", "name" : "Tonga Standard Time"},
    "Pacific/Apia": {"abbr" : "SST", "name" : "Samoa Standard Time"},
  };

  static List<DateTime> generateCumulativeTimeSlots(
      DateTime from,
      DateTime to,
      int limit,
      Map<String, List<TimeRange>>? availability,
      Map<String, Map<String, dynamic>> blockedDates,
      int interval,
      Duration bufferTime,
      String messageTimeZone,
      String localTimeZone,

      ) {
    List<DateTime> cumulativeTimeSlots = [];
    while (cumulativeTimeSlots.length < limit && from.isBefore(to)) {
      String day = DateFormat('yMd').format(from);
      List<DateTimeRange>? blockedTime;
      List<DateTimeRange>? availableSlots;
      if (blockedDates.containsKey(day)) {
        blockedTime = blockedDates[day]!["timings"].cast<DateTimeRange>();
      }

      List<DateTimeRange>? nextDayBlockedTime;
      String day2 = DateFormat('yMd').format(from.add(const Duration(days: 1)));
      if (blockedDates.containsKey(day2)) {
        nextDayBlockedTime = blockedDates[day2]!["timings"].cast<DateTimeRange>();
      }

      availableSlots = getAvailableSlots(from, messageTimeZone, localTimeZone, availability);



      DateTime nextDay = from.add(const Duration(days: 1));
      List<DateTimeRange>? nextDayAvailableSlots;


      nextDayAvailableSlots = getAvailableSlots(nextDay, messageTimeZone, localTimeZone, availability);

      List<DateTime> generatedTimeStamps = generateTimeStamps(
          from,
          availableSlots ??
              [],
          blockedTime ?? [],
          interval,
          bufferTime,
          TimeFormat.twelveHour,nextDayAvailableSlots??[],nextDayBlockedTime??[]);

      if (generatedTimeStamps.isNotEmpty) {
        if (generatedTimeStamps.length > limit - cumulativeTimeSlots.length) {
          cumulativeTimeSlots.addAll(generatedTimeStamps
              .sublist(0, limit - cumulativeTimeSlots.length)
              .toList());
        } else {
          cumulativeTimeSlots.addAll(generatedTimeStamps);
        }
      }

      from = from.add(const Duration(days: 1));
    }
    return cumulativeTimeSlots;
  }


  static List<DateTime> generateTimeStamps(
      DateTime selectedDate,
      List<DateTimeRange> availableSlots,
      List<DateTimeRange> blockedSlots,
      int meetingDuration,
      Duration bufferTime,
      TimeFormat timeFormat,
      List<DateTimeRange> nextDayAvailableSlots,
      List<DateTimeRange> nextDayBlockedSlots) {
    List<DateTime> generatedTimeStamps = [];


    List<DateTimeRange> mergedSlots =  blockedSlots.isNotEmpty?  adjustAvailableSlots(availableSlots, blockedSlots, bufferTime,selectedDate):availableSlots;

    for (var slot in mergedSlots) {
      DateTime from = slot.start;
      DateTime to = slot.end;

      while (from.isBefore(to)) {
        DateTime proposedTime = from.add(Duration(minutes: meetingDuration));

        if (from.day > selectedDate.day ) {
          break;
        } else if (from.day == selectedDate.day &&( proposedTime.isAtSameMomentAs(to) || proposedTime.isBefore(to)) 
            && generatedTimeStamps.validateEntry(from)) {
          generatedTimeStamps.add(from);

        } else if (selectedDate.day == from.day && proposedTime.day > selectedDate.day && generatedTimeStamps.validateEntry(from)) {
          if (nextDayAvailableSlots.isNotEmpty && !checkTimeIsOverlapping(
              DateTimeRange(start: from, end: proposedTime), nextDayAvailableSlots, nextDayBlockedSlots, bufferTime, selectedDate)) {
            generatedTimeStamps.add(from);
          }
        }
        from = proposedTime;
      }
    }

    return generatedTimeStamps;
  }

  static DateTime  getConvertedTime(DateTime baseDate, String utcZone) {
    return TZDateTime.from(baseDate, getLocation(utcZone));
  }

  static bool checkBlockedSlotStatus(
      List<DateTimeRange> blockedSlots, int bufferTime, DateTime proposedTime) {
    return blockedSlots.any((blockedSlot) {

      DateTime bufferedBlockedTo =
          blockedSlot.end.add(Duration(minutes: bufferTime));

      return proposedTime.isBefore(bufferedBlockedTo) &&
          proposedTime.isAfter(blockedSlot.start);
    });
  }

  static String getFormattedTime(DateTime time, TimeFormat timeFormat) {
    String formattedTime = "";
    if (timeFormat == TimeFormat.twelveHour) {
      formattedTime = DateFormat.jm().format(time);
    } else {
      formattedTime = DateFormat.Hm().format(time);
    }
    return formattedTime;
  }

  static Future<Map<String, Map<String, dynamic>>> fetchICSFile(
      String? url, String timeZone, Function(CometChatException) onError) async {
    Map<String, Map<String, dynamic>> blockedDates = {};

    if (url != null && url.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final icsContent = response.body;
          final events = parseICS(icsContent,timeZone);
          blockedDates = events;
        } else {
          onError(CometChatException("ERR","FAILED_TO_LOAD_ICS_FILE","Failed to load ICS file: ${response.statusCode}"));
          if (kDebugMode) {
            print('Failed to load ICS file: ${response.statusCode}');
          }
        }
      } catch (e) {
        onError(CometChatException("ERR","UNABLE_TO_PARSE_ICS_FILE","Unable to parse ICS file: $e"));
        if (kDebugMode) {
          print('Error: caught while parsing icsFile $e');
        }
      }
    } else {
      onError(CometChatException("ERR","INVALID_API_ENDPOINT","the api endpoint is either null of empty"));
    }
    return blockedDates;
  }

  static Map<String, Map<String, dynamic>> parseICS(String icsContent, String timeZone) {
    // Split ICS content into lines
    final lines = LineSplitter.split(icsContent);

    // Parse events
    // final List<Map<String, String>> events = [];
    Map<String, String>? currentEvent;
    Map<String, Map<String, dynamic>> blockedDates = {};

    late DateTimeRange blockedDuration;
    String? day;
    late DateTime startTime;
    late DateTime endTime;


    for (final line in lines) {
      if (line.startsWith('BEGIN:VEVENT')) {
        currentEvent = {};
        // blockedDuration = TimeRange(from: "", to: "");
      } else if (line.startsWith('END:VEVENT')) {
        if (currentEvent != null) {
          // events.add(Map.from(currentEvent));
          currentEvent = null;
          blockedDates[day]!['timings'].add(blockedDuration);
          blockedDates[day]!['fullDayOut'] = false;
        }
      } else if (currentEvent != null) {
        final parts = line.split(':');
        if (parts.length == 2) {
          currentEvent[parts[0]] = parts[1];
          if (parts[0].contains("DTSTART")) {
            // print("start here DTSTART ->  ${parts[0]} : ${parts[1]}");

            startTime = DateTime.parse(parts[1]);

            RegExp regex = RegExp(r"DTSTART;TZID=(.*)");

            Match? match = regex.firstMatch(parts[0]);

            if (match != null) {
              String result = match.group(1) ?? "";
              if (result.isNotEmpty && result!=timeZone) {

                   startTime=getConvertedTime(startTime.toLocal(),timeZone);

              } else {
                startTime=startTime.toLocal();
              }
            } else {
              startTime=startTime.toLocal();

            }

            day = DateFormat('yMd').format(startTime);
            if (!blockedDates.containsKey(day)) {
              blockedDates[day] = {
                "timings": [],
                "weekday": DateFormat('EEEE').format(startTime),
              };
            }

            blockedDuration = DateTimeRange(start: startTime, end: startTime);
          } else if (parts[0].contains("DTEND")) {

            endTime = DateTime.parse(parts[1]);


            RegExp regex = RegExp(r"DTEND;TZID=(.*)");

            Match? match = regex.firstMatch(parts[0]);

            if (match != null) {
              String result = match.group(1) ?? "";
              if (result.isNotEmpty && result!=timeZone) {

                endTime=getConvertedTime(endTime.toLocal(),timeZone);

              } else {
                endTime=endTime.toLocal();
              }

            }  else{
              endTime=endTime.toLocal();
            }

            int difference = endTime.difference(startTime).inDays;
            if (difference > 0) {
              blockedDuration = DateTimeRange(
                  start: blockedDuration.start,
                  end: DateTime(
                      blockedDuration.start.year,
                      blockedDuration.start.month,
                      blockedDuration.start.day,
                      23,
                      59,
                      59));
              blockedDates[day]!['timings'].add(blockedDuration);
              blockedDates[day]!['fullDayOut'] = false;
              while (difference > 1) {
                // blockedDuration = TimeRange(from: "", to: "");
                startTime = startTime.add(const Duration(days: 1));
                day = DateFormat('yMd').format(startTime);
                if (!blockedDates.containsKey(day)) {
                  blockedDates[day] = {
                    "timings": [],
                    "weekday": DateFormat('EEEE').format(startTime),
                    "fullDayOut": true
                  };
                }

                blockedDuration = DateTimeRange(
                    start: DateTime(startTime.year, startTime.month,
                        startTime.day, 0, 0, 0),
                    end: DateTime(startTime.year, startTime.month,
                        startTime.day, 23, 59, 59));
                blockedDates[day]!['timings'].add(blockedDuration);
                difference--;
              }

              day = DateFormat('yMd').format(endTime);
              if (!blockedDates.containsKey(day)) {
                blockedDates[day] = {
                  "timings": [],
                  "weekday": DateFormat('EEEE').format(endTime),
                };
              }

              blockedDuration = DateTimeRange(
                  start: DateTime(
                      endTime.year, endTime.month, endTime.day, 0, 0, 0),
                  end: endTime);
            } else {
              blockedDuration = DateTimeRange(
                  start: startTime,
                  end: endTime);
            }
          }
        }
      }
    }

    return blockedDates;
  }

  static const List<String> weekdays = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday"
  ];


  static List<DateTimeRange> getAvailableSlots(DateTime selectedDateTime, String messageTimeZone, String localTimeZone, Map<String, List<TimeRange>>? availability){
    // initializing start time and end time in local time zone
    DateTime localStartTime = selectedDateTime;
    DateTime localEndTime = selectedDateTime.add(const Duration(hours: 23,minutes: 59,seconds: 59));
    List<DateTimeRange> totalAvailableSlots = [];

    if(messageTimeZone==localTimeZone){
      List<TimeRange> availableSlots = availability?[weekdays[localStartTime.weekday-1]] ?? [];

      for(TimeRange start in availableSlots ){

        DateTime startTime = localStartTime.add(Duration(hours: int.parse(start.from.substring(0,2)), minutes: int.parse(start.from.substring(2))));

        DateTime endTime =localStartTime.add(Duration(hours: int.parse(start.to.substring(0,2)), minutes: int.parse(start.to.substring(2))));

        if(startTime.isAfter(localStartTime) || startTime.isAtSameMomentAs(localStartTime) && endTime.isAfter(startTime)){

          totalAvailableSlots.add(DateTimeRange(start: startTime.toLocal(), end: endTime.toLocal()));
        }

      }
    }else {
      // converting today and next day to provided time zone
      DateTime internationalStartTime = getConvertedTime(
          localStartTime, messageTimeZone);
      DateTime internationalEndTime = getConvertedTime(
          localEndTime, messageTimeZone);

      List<
          TimeRange> availableSlots1 = availability?[weekdays[internationalStartTime
          .weekday - 1]] ?? [];


      DateTime baseStart = internationalStartTime.subtract(Duration(
          hours: internationalStartTime.hour,
          minutes: internationalStartTime.minute,
          seconds: internationalStartTime.second,
          microseconds: internationalStartTime.microsecond,
          milliseconds: internationalStartTime.millisecond));

      for (TimeRange start in availableSlots1) {

        DateTime startTime = baseStart.add(Duration(
            hours: int.parse(start.from.substring(0, 2)),
            minutes: int.parse(start.from.substring(2))));

        DateTime endTime = baseStart.add(Duration(
            hours: int.parse(start.to.substring(0, 2)),
            minutes: int.parse(start.to.substring(2))));


        startTime = SchedulerUtils.
        getConvertedTime(startTime.toLocal(),localTimeZone);
        endTime = SchedulerUtils.getConvertedTime(endTime.toLocal(),localTimeZone);

       if((startTime.day==selectedDateTime.day || endTime.day == selectedDateTime.day) && endTime.isAfter(startTime)) {

          if(startTime.day<selectedDateTime.day && localStartTime.isBefore(endTime)){
            startTime = localStartTime;
          }
          if(endTime.day>selectedDateTime.day && localEndTime.isAfter(startTime)){
            endTime = localEndTime;
          }

          totalAvailableSlots.add(DateTimeRange(
              start: startTime,
              end: endTime));
        }


      }

      if(internationalEndTime.day>internationalStartTime.day) {
        List<TimeRange> availableSlots2 =
            availability?[weekdays[internationalEndTime.weekday - 1]] ?? [];

        DateTime baseEnd = internationalEndTime.subtract(Duration(
            hours: internationalEndTime.hour,
            minutes: internationalEndTime.minute,
            seconds: internationalEndTime.second,
            microseconds: internationalEndTime.microsecond,
            milliseconds: internationalEndTime.millisecond));

        for (TimeRange start in availableSlots2) {

          DateTime startTime = baseEnd.add(Duration(
              hours: int.parse(start.from.substring(0, 2)),
              minutes: int.parse(start.from.substring(2))));


          DateTime endTime = baseEnd.add(Duration(
              hours: int.parse(start.to.substring(0, 2)),
              minutes: int.parse(start.to.substring(2))));


    startTime = SchedulerUtils.getConvertedTime(startTime.toLocal(),localTimeZone);
    endTime = SchedulerUtils.getConvertedTime(endTime.toLocal(),localTimeZone);
    if((startTime.day==selectedDateTime.day || endTime.day == selectedDateTime.day) && endTime.isAfter(startTime)) {

      if(startTime.day<selectedDateTime.day){
        startTime = localStartTime;
      }
      if(endTime.day>selectedDateTime.day){
        endTime = localEndTime;
      }
      totalAvailableSlots.add(DateTimeRange(
          start: startTime,
          end: endTime));
    }
  }

      }
    }
    return totalAvailableSlots;
  }



  static List<DateTimeRange> adjustAvailableSlots(List<DateTimeRange> availableSlots, List<DateTimeRange> blockedSlots, Duration bufferTime, DateTime selectedDate) {
    List<DateTimeRange> adjustedSlots = [];

    for (var availableSlot in availableSlots) {
      for (var blockedSlot in blockedSlots) {
        DateTime availableStart = availableSlot.start;
        DateTime availableEnd = availableSlot.end;
        DateTime blockedStart = blockedSlot.start;
        DateTime blockedEnd = blockedSlot.end;
        if(blockedEnd.day>selectedDate.day){
          blockedEnd = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,23,59,59);
          // bufferTime = Duration.zero;
        }
        if(blockedStart.day<selectedDate.day){
          blockedStart = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,0,0,0);
        }

        if (availableStart.isBefore(blockedEnd) && availableEnd.isAfter(blockedStart)) {
          // Adjust the available slot
          if (availableStart.isBefore(blockedStart)) {
            if(blockedEnd.add(bufferTime).isBefore(availableEnd)){

              adjustedSlots.add(
                  DateTimeRange(start: availableStart, end: blockedStart)
              );
              availableStart = blockedEnd.add(bufferTime);

            }
            adjustedSlots.add(
              DateTimeRange(start: availableStart, end: availableEnd)
            );
          } else {

            if (blockedEnd.isBefore(availableEnd)) {
              adjustedSlots.add(DateTimeRange(start: blockedEnd.add(bufferTime), end: availableEnd));
            }
          }
        } else  if (blockedEnd.isAtSameMomentAs(availableStart)) {
          adjustedSlots.add(DateTimeRange(start: blockedEnd.add(bufferTime), end: availableEnd));
        }else {
          adjustedSlots.add(availableSlot);
        }
      }
    }

    return adjustedSlots;
  }

  static bool checkTimeIsOverlapping(
      DateTimeRange meeting,
      List<DateTimeRange> availableSlots,
      List<DateTimeRange> blockedSlots,
      Duration bufferTime, DateTime selectedDate) {
    bool isOverlapping = false;

    List<DateTimeRange> mergedSlots = blockedSlots.isNotEmpty? adjustAvailableSlots(availableSlots, blockedSlots, bufferTime, selectedDate):availableSlots;
    for (var mergedSlot in mergedSlots) {
      if (mergedSlot.timeIsValid(meeting)) {
        isOverlapping = true;
        break;
      }
    }
    return isOverlapping;
  }

static  DateTime nearestSelectableDate(DateTime selectedDay,DateTime? from, DateTime? to, Map<String, Map<String, dynamic>> blockedDates, Map<String, List<TimeRange>>? availability){
if(isDateSelectable(selectedDay, from, to, blockedDates, availability)){
return selectedDay;
} else{
  return nearestSelectableDate(selectedDay.add(const Duration(days: 1)), from, to, blockedDates, availability);
}
}

static bool isDateSelectable(DateTime selectedDate, DateTime? from, DateTime? to, Map<String, Map<String, dynamic>> blockedDates, Map<String, List<TimeRange>>? availability){
String day = DateFormat('yMd').format(selectedDate);
DateTime now = DateTime.now();
bool isBlocked = blockedDates.containsKey(day) && blockedDates[day]?["fullDayOut"]==true;
bool isNotAvailable =availability!=null && ( availability[SchedulerUtils.weekdays[selectedDate.weekday-1]]==null || (availability[SchedulerUtils.weekdays[selectedDate.weekday-1]]!=null && availability[SchedulerUtils.weekdays[selectedDate.weekday-1]]!.isEmpty));

if(isBlocked){
return false;
}
if (isNotAvailable){
return false;
}
return selectedDate.isAtSameMomentAs(from ?? now) || selectedDate.isAfter(from ?? now) || selectedDate.isAtSameMomentAs( selectedDate ?? now.add(const Duration(days: 1))) || selectedDate.isBefore( to ?? now.add(const Duration(days: 1)));

}

  static Map<String,dynamic> getActionRequestBody(SchedulerMessage message, DateTime meetStartAt, Duration duration, String timeZoneCode){
    return {
      "payload": message.interactiveData,
      "data" : getActionRequestData(message, meetStartAt, duration, timeZoneCode)
    };

  }

static Map<String,dynamic> getActionRequestData(SchedulerMessage message, DateTime meetStartAt, Duration duration, String timeZoneCode){

    return {
      "conversationId": message.conversationId,
      "senderId": message.sender?.uid,
      "receiver": message.receiverUid,
      "receiverType":message.receiverType,
      "messageCategory": message.category,
      "messageType": message.type,
      "messageId": message.id,
      "meetStartAt": meetStartAt.toString(),
      "duration": duration.inMinutes,
      "timezoneCode": timeZoneCode,//this time zone code is the one which is selected by the user
    };
}

static String getSchedulerTitle(SchedulerMessage schedulerMessage, BuildContext context){
    return  schedulerMessage.title ?? "${Translations.of(context).meetingWith} ${schedulerMessage.sender?.name ?? ''}";
}

static bool isScheduleButtonDisabled(SchedulerMessage schedulerMessage){
  bool isSender = schedulerMessage.sender?.uid == CometChatUIKit.loggedInUser?.uid;
  bool buttonIsDisabled = isSender && !schedulerMessage.allowSenderInteraction;
  return buttonIsDisabled;
}

  static  Map<String,List<dynamic>> getAvailabilityJson(Map<String, List<TimeRange>>? availability) {
    Map<String,List<dynamic>> availabilityJson = {};
    availability?.forEach((key, value) {
      List<Map<String,String>> timeRanges = [];
      for (var timeRange in value) {
        timeRanges.add(timeRange.toJson());
      }
      availabilityJson[key] = timeRanges;
    });
    return availabilityJson;
  }
}

extension DateTimeExtension on DateTimeRange {
  bool isOverlappingWithBuffer(DateTimeRange other, int bufferTime) {
    return start.isBefore(other.end.add(Duration(minutes: bufferTime))) &&
        other.start.isBefore(end.add(Duration(minutes: bufferTime)));
  }

  bool isStartsBetweenOther(DateTimeRange other) {
    return start.isAfter(other.start) && start.isBefore(other.end);
  }

  bool isEndsBetweenOther(DateTimeRange other,Duration bufferTime) {
    return end.add(bufferTime).isAfter(other.start) && end.add(bufferTime).isBefore(other.end);
  }

  bool timeIsValid(DateTimeRange meeting) {
    return start.isBefore(meeting.start) && end.isAfter(meeting.end);
  }
}

extension DateTimeExtension2 on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime adjustTimeDifference(int hours, int minutes){
    if(hours>0){
      return add(Duration(hours: hours.abs(),minutes: minutes.abs()));
    }else  if(hours<0){
      return subtract(Duration(hours: hours.abs(),minutes: minutes.abs()));
    }  else{
      return this;
    }
  }

  bool isSameTime(DateTime other) {
    return hour == other.hour && minute == other.minute;
  }
}

extension TimeStampGeneration on List<DateTime>{
  bool containsSameDate(DateTime newDate) {
    for (DateTime date in this) {
      if (date.isSameDay(newDate) && date.isSameTime(newDate)) return true;
    }
    return false;
  }

  DateTime getMax(){
    List<DateTime> dateTimes = this;
    return dateTimes.reduce((value, element) => value.isAfter(element) ? value : element);
  }

  bool validateEntry(DateTime dateTime){
    return !containsSameDate(dateTime) && (isEmpty || dateTime.isAfter(getMax()));
  }
}

