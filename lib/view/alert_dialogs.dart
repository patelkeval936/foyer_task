import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foyer/view/profile_info_screen.dart';

import '../model/device_profile_settings.dart';
import '../utils/provider/profile_provider.dart';

void addProfileDialog(BuildContext context,bool isCreate,void Function(BuildContext context) function) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
               '${isCreate ? 'Create' : 'Edit'} Profile ?',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Are You Sure To ${ isCreate ? 'Create' : 'Edit'}  Profile ?',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              function(context);
                              Navigator.of(dialogContext).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Yes"))))
              ],
            )
          ],
        ),
      );
    },
  );
}

void noProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'No Profiles Found',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Please Create one to Continue',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No')))),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => const ProfileInfoScreen(),
                              ));
                            },
                            child: const Text("Let's Create"))))
              ],
            )
          ],
        ),
      );
    },
  );
}

void changeDeviceProfileDialog(BuildContext context, DeviceProfileSettings profileSettings) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Change Device Profile Settings?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'This will change your  location, theme and font size',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No')))),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<ProfilesProvider>().changeCurrentProfile(profileSettings);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Yes'))))
              ],
            )
          ],
        ),
      );
    },
  );
}

void locationAlreadyExistDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Location Already Exist',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Please try changing your latitude or longitude to add your location',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Okay')))),
              ],
            )
          ],
        ),
      );
    },
  );
}

void repeatingLocationDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Location is already defined',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'Location You have entered is already associated with other profile',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Okay')))),
                ],
              )
            ],
          ),
        );
      });
}

void nothingChangedDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please Change Data to update',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'Please try changing any of the given field to update the data',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Okay')))),
                ],
              )
            ],
          ),
        );
      });
}
