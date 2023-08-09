import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foyer/repository/repository.dart';

import '../../model/device_profile_settings.dart';

class ProfilesProvider extends ChangeNotifier {

  DeviceProfileSettings? currentProfile;
  List<DeviceProfileSettings> profiles = [];

  ProfilesProvider(){
    getProfiles();
  }

  Future<void> getProfiles() async {
    profiles = await Repository().getProfiles();
    notifyListeners();
  }

  void changeCurrentProfile(DeviceProfileSettings deviceProfileSettings)async{
    currentProfile = deviceProfileSettings;
    SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt('current_profile', deviceProfileSettings.id!);
    notifyListeners();
  }

}
