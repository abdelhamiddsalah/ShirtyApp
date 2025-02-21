import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:clothshop/features/profile/presentation/widgets/complaint_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.05,
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                child: Text('Profile', style: TextStyles.authtitle.copyWith(
                  fontSize: screenWidth * 0.08,
                  color: Colors.white
                ))),
              SizedBox(height: screenHeight * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: screenHeight * 0.05,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      thickness: 1,
                      color: AppColors.primary,
                      width: 10,
                      indent: 10,
                    ),
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoaded) {
                        return Column(
                          children: [
                            Text(
                              state.profile.firstName.toString(),
                              style: TextStyles.textinhome,
                            ),
                            Text(
                              state.profile.lastName.toString(),
                              style: TextStyles.textinhome,
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          Text('First Name', style: TextStyles.textinhome),
                          Text('Last Name', style: TextStyles.textinhome),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return Column(
                      children: [
                        ProfileInfoTile(
                          icon: Icons.email,
                          label: state.profile.email.toString(),
                        ),
                        ProfileInfoTile(
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                        ),
                        //ProfileInfoTile(icon: Icons.calendar_month_outlined, label: state.profile.age.toString()),
                        ProfileInfoTile(
                          icon: Icons.calendar_month_outlined,
                          label: state.profile.age,
                        ),
                        ProfileInfoTile(
                          icon: Icons.logout,
                          label: 'Logout',
                          isLogout: true,
                        ),
                      ],
                    );
                   
                  }
                  return const SizedBox();
                },
              ),
              const ComplaintSection()
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLogout;

  const ProfileInfoTile({
    Key? key,
    required this.icon,
    required this.label,
    this.isLogout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(label),
          tileColor: AppColors.secondBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap:
              isLogout
                  ? () {
                      BlocProvider.of<ProfileCubit>(context).logout(); 
                  }
                  : null,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
