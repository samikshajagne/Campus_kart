import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

String uid = '';
String userEmail='';
String userImageUrl ='';
String getUserName = '';
Position ? position;
List<Placemark>? placemarks;
String completeAddress ='';
String adUserName ='';