import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foyer/utils/provider/theme_provider.dart';
import 'package:foyer/validators/app_validators.dart';
import 'package:foyer/value/app_globals/app_strings.dart';

import '../model/device_profile_settings.dart';
import '../value/app_globals/app_constants.dart';

class ProfileInfoScreen extends StatefulWidget {
  final DeviceProfileSettings? deviceProfileSettings;

  const ProfileInfoScreen({super.key, this.deviceProfileSettings});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController latitudeController;
  late TextEditingController longitudeController;

  @override
  void initState() {
    latitudeController = TextEditingController(text: widget.deviceProfileSettings?.latitude);
    longitudeController = TextEditingController(text: widget.deviceProfileSettings?.longitude);
    super.initState();
  }

  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.detailsTitles(widget.deviceProfileSettings),
          ),
          centerTitle: true,
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: latitudeController,
                      validator: AppValidators.latitudeValidator,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      decoration: InputDecoration(hintText: AppStrings.latitudeHintText),
                    ),
                    TextFormField(
                      controller: longitudeController,
                      validator: AppValidators.longitudeValidator,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      decoration: InputDecoration(hintText: AppStrings.longitudeHintText),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 8),
                      child: Row(
                        children: [
                          Text(
                            'Select Theme Color',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Consumer<ThemeProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        return SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [...getColorAvatars(context)],
                          ),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Row(
                        children: [
                          Text(
                            'Select Font Size',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Consumer<ThemeProvider>(
                      builder: (context, value, child) {
                        return SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [...getSizeBoxes(context)],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          onAddOrEditProfile(context);
                        },
                        child: Text(
                          AppStrings.submitButtonTitle(widget.deviceProfileSettings),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void onAddOrEditProfile(BuildContext context) {
    DeviceProfileSettings deviceProfileSettings = DeviceProfileSettings(
        id: widget.deviceProfileSettings != null ? widget.deviceProfileSettings!.id : null,
        latitude: latitudeController.text.trim(),
        longitude: longitudeController.text.trim(),
        themeColor: context.read<ThemeProvider>().themeColor,
        fontSize: context.read<ThemeProvider>().fontSize);
    if (widget.deviceProfileSettings != null) {
      AppValidators.validateEditProfile(formKey, context, deviceProfileSettings);
    } else {
      AppValidators.validateAddProfile(formKey, context, deviceProfileSettings);
    }
  }

  List<Widget> getColorAvatars(BuildContext context) {
    return colors
        .map((e) => InkWell(
              onTap: () {
                context.read<ThemeProvider>().updateThemeColor(e);
              },
              child: CircleAvatar(
                  radius: e == context.read<ThemeProvider>().themeColor ? 20 : 16,
                  backgroundColor: Colors.grey,
                  child: Center(
                    child: CircleAvatar(radius: 16, backgroundColor: e),
                  )),
            ))
        .toList();
  }

  List<Widget> getSizeBoxes(BuildContext context) {
    return listOfFontSizes
        .map((e) => InkWell(
            onTap: () {
              context.read<ThemeProvider>().updateFontSize(e);
            },
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.read<ThemeProvider>().fontSize == e ? Theme.of(context).appBarTheme.backgroundColor : Colors.grey.shade400),
              child: Center(
                  child: Text(
                e.toString(),
                style: TextStyle(color: context.read<ThemeProvider>().fontSize == e ? Colors.white : Colors.black),
              )),
            )))
        .toList();
  }
}
