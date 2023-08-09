
import '../../model/device_profile_settings.dart';

class AppStrings{

  static String appTitle = 'Foyer';
  static String profiles = 'Profiles';
  static String profileDeletedSuccessfully = 'Profile Deleted Successfully';
  static String somethingWentWrong = 'Something Went Wrong';

  static String latitudeHintText = 'latitude';
  static String longitudeHintText = 'longitude';
  static String invalidLatitude = 'valid range is -90 to 90';
  static String invalidLongitude = 'valid range is -180 to 180';

  static String detailsTitles(DeviceProfileSettings? deviceProfileSettings) => deviceProfileSettings != null ? 'Edit Profile' : 'Create Profile';
  static String submitButtonTitle(DeviceProfileSettings? deviceProfileSettings) => deviceProfileSettings != null ? 'Update Details' : 'Create Profile';
  static String pleaseProvideValid({required detail}) => 'Please Provide Valid $detail';

}