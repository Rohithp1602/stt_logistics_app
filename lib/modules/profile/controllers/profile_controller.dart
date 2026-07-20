import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../core/errors/failures.dart';
import '../../../core/enums/verification_status.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/driver_provider.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../l10n/l10n.dart';
import '../../../services/auth_service.dart';
import '../../../utils/snackbar_helper.dart';

/// Controller for the profile screen that handles user and driver data editing.
class ProfileController extends GetxController {
  final _authRepo = Get.find<AuthRepository>();
  final _authService = Get.find<AuthService>();
  final _driverProvider = Get.find<DriverProvider>();
  final _picker = ImagePicker();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final cdlController = TextEditingController();
  final hubController = TextEditingController();

  final isLoading = false.obs;
  final isSaving = false.obs;
  final user = Rxn<UserModel>();
  final driver = Rxn<DriverModel>();
  final photoPath = RxnString();

  @override
  void onInit() {
    super.onInit();
    _loadUserAndDriver();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    cdlController.dispose();
    hubController.dispose();
    super.onClose();
  }

  Future<void> _loadUserAndDriver() async {
    isLoading.value = true;
    try {
      user.value = _authService.currentUser.value;
      driver.value = await _driverProvider.fetchDriver();
      _populateFields();
    } on StorageFailure catch (e) {
      SnackbarHelper.error(e.message);
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    final currentUser = user.value;
    final currentDriver = driver.value;
    
    if (currentUser != null) {
      fullNameController.text = currentUser.displayName ?? currentDriver?.name ?? '';
      phoneController.text = currentUser.phone.isNotEmpty ? currentUser.phone : (currentDriver?.phone ?? '');
      photoPath.value = currentUser.photoPath ?? currentDriver?.photoPath;
    }
    
    if (currentDriver != null) {
      cdlController.text = currentDriver.cdlNumber;
      hubController.text = currentDriver.hub;
    }
  }

  Future<void> onPhotoTap() async {
    final strings = l10n;
    final dynamic source = await Get.bottomSheet<dynamic>(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(strings.camera),
                onTap: () => Get.back(result: ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(strings.gallery),
                onTap: () => Get.back(result: ImageSource.gallery),
              ),
              if (photoPath.value != null) ...[
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text(strings.removePhoto),
                  onTap: () => Get.back(result: 'remove'),
                ),
              ],
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
    );

    if (source == null) return;

    if (source == 'remove') {
      photoPath.value = null;
      return;
    }

    if (source is! ImageSource) return;

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        photoPath.value = await _saveAvatar(image);
      }
    } catch (e) {
      SnackbarHelper.error('Failed to select photo: ${e.toString()}');
    }
  }

  Future<String> _saveAvatar(XFile image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final avatarsDir = Directory(path.join(appDir.path, 'avatars'));
    if (!await avatarsDir.exists()) {
      await avatarsDir.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = path.extension(image.path);
    final fileName = 'avatar_$timestamp$extension';
    final savedPath = path.join(avatarsDir.path, fileName);

    await File(image.path).copy(savedPath);
    return savedPath;
  }

  Future<void> saveProfile() async {
    if (isSaving.value) return;
    
    isSaving.value = true;
    try {
      final currentUser = user.value;
      if (currentUser == null) {
        SnackbarHelper.error('No user logged in');
        return;
      }

      // Update profile via repository
      final updatedUser = await _authRepo.updateProfile(
        displayName: fullNameController.text.trim(),
        phone: phoneController.text.trim(),
        cdlNumber: cdlController.text.trim(),
        hub: hubController.text.trim(),
        photoPath: photoPath.value,
      );

      // Update driver data
      final updatedDriver = DriverModel(
        userId: currentUser.id,
        name: fullNameController.text.trim(),
        phone: phoneController.text.trim(),
        cdlNumber: cdlController.text.trim(),
        hub: hubController.text.trim(),
        status: driver.value?.status ?? VerificationStatus.pending,
        photoPath: photoPath.value,
      );
      
      await _driverProvider.saveDriver(updatedDriver);

      // Update local state
      user.value = updatedUser;
      driver.value = updatedDriver;

      SnackbarHelper.success(l10n.profileUpdated);
    } on AuthFailure catch (failure) {
      SnackbarHelper.error(failure.message);
    } catch (e) {
      SnackbarHelper.error('Failed to update profile');
    } finally {
      isSaving.value = false;
    }
  }

}