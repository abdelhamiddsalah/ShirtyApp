import 'package:bloc/bloc.dart';
import 'package:clothshop/features/notifications/data/models/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final Box<NotificationModel> notificationsBox;
  
  NotificationsCubit(this.notificationsBox) : super(NotificationsInitial()) {
    // Load notifications immediately when cubit is created
    loadNotifications();
  }

  void loadNotifications() {
    try {
      final notifications = notificationsBox.values.toList();
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError("Failed to load notifications: $e"));
    }
  }

  void addNotification(NotificationModel notification) {
    try {
      notificationsBox.add(notification);
      // Reload notifications after adding
      final notifications = notificationsBox.values.toList();
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError("Failed to add notification: $e"));
    }
  }

  void clearNotifications() {
    try {
      notificationsBox.clear();
      emit(NotificationsLoaded([]));
    } catch (e) {
      emit(NotificationsError("Failed to clear notifications: $e"));
    }
  }

  @override
  Future<void> close() {
    // Clean up any resources if needed
    return super.close();
  }
}
