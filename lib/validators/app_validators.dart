// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foyer/repository/repository.dart';
import 'package:foyer/value/app_globals/app_constants.dart';
import 'package:foyer/value/app_globals/app_strings.dart';

import '../model/device_profile_settings.dart';
import '../view/alert_dialogs.dart';
import '../utils/provider/profile_provider.dart';

class AppValidators {
  static String? latitudeValidator(String? latitude) {
    if (latitude == null || latitude.isEmpty) {
      return AppStrings.pleaseProvideValid(detail: 'latitude');
    }
    RegExp latitudeCheck = latitudeRegEx;
    if (!latitudeCheck.hasMatch(latitude)) {
      return AppStrings.invalidLatitude;
    }
    return null;
  }

  static String? longitudeValidator(String? longitude) {
    if (longitude == null || longitude.isEmpty) {
      return AppStrings.pleaseProvideValid(detail: 'longitude');
    }
    RegExp longitudeCheck = longitudeRegEx;
    if (!longitudeCheck.hasMatch(longitude)) {
      return AppStrings.invalidLongitude;
    }
    return null;
  }

  static void validateEditProfile(
    GlobalKey<FormState> formKey,
    BuildContext context,
    DeviceProfileSettings deviceProfileSettings,
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      DeviceProfileSettings earlierData = context.read<ProfilesProvider>().profiles.where((element) => element.id == deviceProfileSettings.id).first;

      bool themeOrFontSizeChanged =
          earlierData.themeColor != deviceProfileSettings.themeColor || earlierData.fontSize != deviceProfileSettings.fontSize;
      bool latLongChanged = earlierData.longitude != deviceProfileSettings.longitude || earlierData.latitude != deviceProfileSettings.latitude;

      if (!themeOrFontSizeChanged && !latLongChanged) {
        nothingChangedDialog(context);
      } else {
        if (themeOrFontSizeChanged) {
          addProfileDialog(context, false, (context) async {
            await Repository().updateProfiles(deviceProfileSettings, deviceProfileSettings.id!);
            await context.read<ProfilesProvider>().getProfiles();
          });
        } else {
          int index = context.read<ProfilesProvider>().profiles.indexWhere(
                (element) => element.longitude == deviceProfileSettings.longitude && element.latitude == deviceProfileSettings.latitude,
              );
          if (index == -1) {
            addProfileDialog(context, false, (context) async {
              await Repository().updateProfiles(deviceProfileSettings, deviceProfileSettings.id!);
              await context.read<ProfilesProvider>().getProfiles();
            });
          } else {
            repeatingLocationDialog(context);
          }
        }
      }
    }
  }

  static void validateAddProfile(
    GlobalKey<FormState> formKey,
    BuildContext context,
    DeviceProfileSettings deviceProfileSettings,
  ) {
    if (formKey.currentState?.validate() ?? false) {
      int index = context
          .read<ProfilesProvider>()
          .profiles
          .indexWhere((element) => element.longitude == deviceProfileSettings.longitude && element.latitude == deviceProfileSettings.latitude);
      if (index == -1) {
        addProfileDialog(context, true, (context) {
          Repository().addProfile(deviceProfileSettings);
          context.read<ProfilesProvider>().getProfiles();
        });
      } else {
        locationAlreadyExistDialog(context);
      }
    }
  }
}
