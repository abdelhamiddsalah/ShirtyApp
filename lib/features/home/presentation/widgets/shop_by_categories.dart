import 'package:clothshop/core/utils/text_styles.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:clothshop/features/home/presentation/widgets/products_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopByCategories extends StatelessWidget {
  const ShopByCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final screenhight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
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
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              ),
              SizedBox(height: screenhight * 0.02),
              Text('Shop By Categories', style: TextStyles.textinhome.copyWith(fontSize: screenwidth * 0.06)),
              SizedBox(height: screenhight * 0.02),
              BlocProvider(
                create: (context) => sl<CategoriesCubit>()..fetchCategories(),
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: screenwidth * 0.008,
                        ),
                      );
                    }
                    if (state is CategoriesError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is CategoriesLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.categories.length,
                        itemBuilder:
                            (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsGridView(
                                 //path2: state.categories[index].productPath.toString(),
                           categoryId: state.categories[index].id.toString(),
                                )));
                              },
                              child: Container(
                                width:  screenwidth,
                                height: screenhight * 0.1,
                                margin: EdgeInsets.only(bottom: screenhight * 0.02),
                                decoration: BoxDecoration(
                                   color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.05),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenwidth * 0.13,
                                      height: screenwidth * 0.13,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                      ),
                                      child: Image.network(
                                        state.categories[index].image.toString(),
                                      ),
                                    ),
                                    SizedBox(width: screenwidth * 0.05),
                                    Text(
                                      state.categories[index].title.toString(),
                                      style: TextStyles.textinhome.copyWith(fontSize:  screenwidth * 0.04,fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
