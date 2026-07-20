import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/analytics_events.dart';
import '../../../core/enums/shipment_status.dart';
import '../../../core/errors/failures.dart';
import '../../../core/validators/form_validators.dart';
import '../../../data/models/shipment_model.dart';
import '../../../data/repositories/shipment_repository.dart';
import '../../../l10n/l10n.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_routes.dart';
import '../../../services/analytics_service.dart';
import '../../../services/auth_service.dart';
import '../../../utils/snackbar_helper.dart';
import '../../shell/controllers/main_shell_controller.dart';

/// Manages shipment list state and CRUD operations.
class ShipmentController extends GetxController {
  ShipmentController({required this._repository});

  final ShipmentRepository _repository;
  static const _uuid = Uuid();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  final RxList<ShipmentModel> shipments = <ShipmentModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<ShipmentStatus> formStatus = ShipmentStatus.pending.obs;

  ShipmentModel? editingShipment;

  @override
  void onInit() {
    super.onInit();
    loadShipments();
  }

  Future<void> loadShipments() async {
    isLoading.value = true;
    try {
      final items = await _repository.getAll();
      shipments.assignAll(items);
    } on StorageFailure catch (e) {
      SnackbarHelper.error(e.message);
    } finally {
      isLoading.value = false;
    }
  }

  void openCreateForm() {
    editingShipment = null;
    _resetForm();
    if (Get.isRegistered<AnalyticsService>()) {
      Get.find<AnalyticsService>().logEvent(
        AnalyticsEvents.featureOpenShipmentForm,
        parameters: const <String, Object>{'mode': 'create'},
      );
    }
    AppNavigation.push(AppRoutes.shipmentForm);
  }

  void openEditForm(ShipmentModel shipment) {
    editingShipment = shipment;
    customerController.text = shipment.customerName;
    originController.text = shipment.origin;
    destinationController.text = shipment.destination;
    formStatus.value = shipment.status;
    if (Get.isRegistered<AnalyticsService>()) {
      Get.find<AnalyticsService>().logEvent(
        AnalyticsEvents.featureOpenShipmentForm,
        parameters: const <String, Object>{'mode': 'edit'},
      );
    }
    AppNavigation.push(AppRoutes.shipmentForm);
  }

  Future<void> saveShipment() async {
    if (isLoading.value) return;

    final form = formKey.currentState;
    if (form == null || !form.validate()) return;

    final routeError = FormValidators.originDestination(
      originController.text,
      destinationController.text,
    );
    if (routeError != null) {
      SnackbarHelper.error(routeError);
      return;
    }

    final user = Get.find<AuthService>().currentUser.value;
    if (user == null) {
      SnackbarHelper.error('Not authenticated');
      return;
    }

    final isCreate = editingShipment == null;
    isLoading.value = true;
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      if (isCreate) {
        final created = ShipmentModel(
          id: _generateId(),
          userId: user.id,
          customerName: customerController.text.trim(),
          origin: originController.text.trim(),
          destination: destinationController.text.trim(),
          status: formStatus.value,
          createdAt: now,
          updatedAt: now,
        );
        final items = await _repository.create(created);
        shipments.assignAll(items);
      } else {
        final updated = editingShipment!.copyWith(
          customerName: customerController.text.trim(),
          origin: originController.text.trim(),
          destination: destinationController.text.trim(),
          status: formStatus.value,
          updatedAt: now,
        );
        final items = await _repository.update(updated);
        shipments.assignAll(items);
      }

      // Pop before snackbar — popping would otherwise dismiss the snackbar.
      AppNavigation.pop();
      _goToShipmentsTab();
      SnackbarHelper.successAfterNav(
        isCreate ? l10n.shipmentAdded : l10n.shipmentUpdated,
      );
    } on StorageFailure catch (e) {
      SnackbarHelper.error(e.message);
    } finally {
      isLoading.value = false;
    }
  }

  void _goToShipmentsTab() {
    if (Get.isRegistered<MainShellController>()) {
      Get.find<MainShellController>().changeTab(1);
    }
    AppNavigation.go(AppRoutes.shipments);
  }

  Future<void> deleteShipment(ShipmentModel shipment) async {
    final strings = l10n;
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text(strings.deleteShipment),
        content: Text(strings.deleteShipmentConfirm(shipment.id)),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(strings.cancel),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(strings.delete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final items = await _repository.delete(shipment.id);
      shipments.assignAll(items);
      SnackbarHelper.success(strings.shipmentDeleted);
    } on StorageFailure catch (e) {
      SnackbarHelper.error(e.message);
    }
  }

  Future<void> updateStatus(
    ShipmentModel shipment,
    ShipmentStatus status,
  ) async {
    try {
      final updated = shipment.copyWith(
        status: status,
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
      final items = await _repository.update(updated);
      shipments.assignAll(items);
      SnackbarHelper.success(l10n.shipmentUpdated);
    } on StorageFailure catch (e) {
      SnackbarHelper.error(e.message);
    }
  }

  String? validateCustomer(String? value) => FormValidators.required(value);

  String? validateOrigin(String? value) => FormValidators.required(value);

  String? validateDestination(String? value) => FormValidators.required(value);

  void _resetForm() {
    customerController.clear();
    originController.clear();
    destinationController.clear();
    formStatus.value = ShipmentStatus.pending;
  }

  String _generateId() => 'SHP-${_uuid.v4()}';

  @override
  void onClose() {
    customerController.dispose();
    originController.dispose();
    destinationController.dispose();
    super.onClose();
  }
}
