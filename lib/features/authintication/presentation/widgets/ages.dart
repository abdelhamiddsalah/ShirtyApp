import 'package:clothshop/features/authintication/presentation/cubit/agescubit/cubit/ages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Ages extends StatelessWidget {
  final Function(String) onAgeSelected;

  const Ages({super.key, required this.onAgeSelected});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<AgesCubit, AgesState>(
      builder: (context, state) {
        if (state is AgesInitial) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: screenWidth * 0.008,
            ),
          );
        } else if (state is AgesLoaded) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                ),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: screenWidth * 0.003,
                    ),
                  ),
                ),
                child: Text(
                  'Select Age',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (context, index) {
                    String age = state.list[index]['value'].toString();
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.01,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.01,
                        ),
                        title: Text(
                          age,
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () => onAgeSelected(age),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        tileColor: Colors.grey.withOpacity(0.1),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is AgesError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: screenWidth * 0.04,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}