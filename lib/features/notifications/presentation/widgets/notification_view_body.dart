import 'package:clothshop/constants/images.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Text(
                'الإشعارات',
                style: TextStyles.authtitle.copyWith(
                  fontSize: screenWidth * 0.06,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsLoaded) {
                    if (state.notifications.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: screenHeight * 0.2),
                            const Text(
                              'لا توجد إشعارات',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x1AFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          trailing: Text(
                            "${state.notifications[index].timestamp.hour}:${state.notifications[index].timestamp.minute.toString().padLeft(2, '0')}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          title: Text(
                            state.notifications[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            state.notifications[index].body,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          leading: Image.asset(
                            Assets.imagesNotificationbing,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else if (state is NotificationsError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
