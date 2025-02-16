import 'package:clothshop/constants/images.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenhight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenwidth * 0.05,
            vertical: screenhight * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenhight * 0.05),
              Text(
                'Notifications',
                style: TextStyles.authtitle.copyWith(
                  fontSize: screenwidth * 0.06,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenhight * 0.01),
              BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(
                          vertical: screenhight * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          trailing: Text(
                            "${state.notifications[index].timestamp.hour}:${state.notifications[index].timestamp.minute}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          title: Text(state.notifications[index].title),
                          subtitle: Text(state.notifications[index].body),
                          leading: Image.asset(
                            Assets.imagesNotificationbing,
                          ),
                        ),
                      ),
                    );
                  } else if (state is NotificationsError) {
                    return Center(child: Text(state.message));
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