// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foyer/repository/repository.dart';
import 'package:foyer/value/app_globals/app_strings.dart';
import '../model/device_profile_settings.dart';
import '../utils/provider/profile_provider.dart';
import 'alert_dialogs.dart';
import 'profile_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ProfilesProvider? profilesProvider;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    checkForProfile();
  }

  void checkForProfile() {
    profilesProvider = context.read<ProfilesProvider?>();

    profilesProvider!.getProfiles().then((value) async {
      if(profilesProvider!.profiles.isEmpty){
        WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
          noProfileDialog(context);
        });
      }

      SharedPreferences preferences = await _prefs;
      int? currentProfile = preferences.getInt('current_profile');
      if (currentProfile != null &&
          profilesProvider!.profiles.isNotEmpty &&
          profilesProvider!.profiles.indexWhere((element) => element.id == currentProfile) != -1) {
        profilesProvider!.changeCurrentProfile(profilesProvider!.profiles.where((element) => element.id == currentProfile).first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profiles),
        centerTitle: true,
      ),
      body: profilesProvider != null
          ? Selector<ProfilesProvider, int>(
              selector: (context, profileSettingsProvider) =>
              profileSettingsProvider.profiles.length,
              shouldRebuild: (previous, next) => true,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    DeviceProfileSettings deviceProfileSettings = profilesProvider!.profiles[index];
                    return Selector<ProfilesProvider, DeviceProfileSettings>(
                      selector: (_, settingProvider) => settingProvider.profiles[index],
                      shouldRebuild: (previous, next) => true,
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                          child: InkWell(
                            onTap: () {
                              changeDeviceProfileDialog(context, deviceProfileSettings);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Builder(builder: (context) {
                                              return SizedBox(
                                                height: 26,
                                                child: Center(
                                                  child: Text("Profile : ${profilesProvider!.profiles[index].id}",
                                                      style: TextStyle(
                                                          fontSize: context.watch<ProfilesProvider>().currentProfile?.fontSize ?? 18,
                                                          fontWeight: FontWeight.w400)),
                                                ),
                                              );
                                            }),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'Latitude : ${deviceProfileSettings.latitude}',
                                                    style: TextStyle(color: Colors.grey.shade800),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'Longitude : ${deviceProfileSettings.longitude}',
                                                    style: TextStyle(color: Colors.grey.shade800),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'Font Size : ${deviceProfileSettings.fontSize}',
                                                    style: TextStyle(color: Colors.grey.shade800),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            splashRadius: 20,
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.grey.shade700,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                  builder: (context) => ProfileInfoScreen(deviceProfileSettings: deviceProfileSettings),
                                                ),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            splashRadius: 20,
                                            icon: Icon(
                                              Icons.delete_rounded,
                                              color: Colors.grey.shade700,
                                            ),
                                            onPressed: () async {
                                              await Repository().deleteProfile(deviceProfileSettings.id!);
                                              await context.read<ProfilesProvider>().getProfiles();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(AppStrings.profileDeletedSuccessfully),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            )
          : Center(
              child: Text(AppStrings.somethingWentWrong),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const ProfileInfoScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Profile'),
        // child: const Icon(Icons.add),
      ),
    );
  }
}
