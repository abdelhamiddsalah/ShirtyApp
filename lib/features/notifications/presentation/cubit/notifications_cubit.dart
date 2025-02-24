import 'package:bloc/bloc.dart';
import 'package:clothshop/features/notifications/data/models/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final Box<NotificationModel> notificationsBox;

  NotificationsCubit(this.notificationsBox) : super(NotificationsInitial()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      final notifications = notificationsBox.values.toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      emit(NotificationsLoaded(notifications));
    } catch (e, stackTrace) {
      print('Error loading notifications: $e\n$stackTrace');
      emit(NotificationsError('فشل في تحميل الإشعارات'));
    }
  }

  Future<void> addNotification(NotificationModel notification) async {
    try {
      await notificationsBox.add(notification);
      await loadNotifications();
    } catch (e, stackTrace) {
      print('Error adding notification: $e\n$stackTrace');
      emit(NotificationsError('فشل في إضافة الإشعار'));
    }
  }

  Future<void> clearNotifications() async {
    try {
      await notificationsBox.clear();
      emit(const NotificationsLoaded([]));
    } catch (e, stackTrace) {
      print('Error clearing notifications: $e\n$stackTrace');
      emit(NotificationsError('فشل في مسح الإشعارات'));
    }
  }

  @override
  Future<void> close() async {
    await notificationsBox.close();
    return super.close();
  }
}