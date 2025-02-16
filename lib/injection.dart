import 'package:clothshop/core/network/network_info.dart';
import 'package:clothshop/core/services/firebase_auth_services.dart';
import 'package:clothshop/core/services/firestore_services.dart';
import 'package:clothshop/features/authintication/data/repositories/auth_repositry_impl.dart';
import 'package:clothshop/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:clothshop/features/authintication/domain/usecases/forgetpassword_usecase.dart';
import 'package:clothshop/features/authintication/domain/usecases/login_usecase.dart';
import 'package:clothshop/features/authintication/domain/usecases/signup_usecase.dart';
import 'package:clothshop/features/authintication/presentation/cubit/forgetpassword/cubit/forgetpasswordreset_cubit.dart';
import 'package:clothshop/features/authintication/presentation/cubit/logincubit/cubit/login_cubit.dart';
import 'package:clothshop/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:clothshop/features/cart/data/datasources/local_datasource_cart.dart';
import 'package:clothshop/features/cart/data/datasources/remote_datasource_cart.dart';
import 'package:clothshop/features/cart/data/repositories/cart_repositry_Impl.dart';
import 'package:clothshop/features/cart/domain/repositories/cart_repositry.dart';
import 'package:clothshop/features/cart/domain/usecases/getcarts_usecase.dart';
import 'package:clothshop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:clothshop/features/home/data/datasources/category_datasources/local_datasource.dart';
import 'package:clothshop/features/home/data/datasources/category_datasources/remote_datasource.dart';
import 'package:clothshop/features/home/data/datasources/product_datasources/local_productdatasource.dart';
import 'package:clothshop/features/home/data/datasources/product_datasources/remote_productdatasource.dart';
import 'package:clothshop/features/home/data/repositories/home_repostries_impel.dart';
import 'package:clothshop/features/home/domain/repositories/home_repositry.dart';
import 'package:clothshop/features/home/domain/usecases/category_usecase.dart';
import 'package:clothshop/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:clothshop/features/home/domain/usecases/getproducts_byprice_usecase.dart';
import 'package:clothshop/features/home/domain/usecases/getproductsbytitle.dart';
import 'package:clothshop/features/home/domain/usecases/new_products_usecase.dart';
import 'package:clothshop/features/home/domain/usecases/products_usecase.dart';
import 'package:clothshop/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:clothshop/features/notifications/data/models/notification_model.dart';
import 'package:clothshop/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:clothshop/features/orders/data/repositories/addtocart_repositry_Impl.dart';
import 'package:clothshop/features/orders/domain/repositories/addtocart_repositry.dart';
import 'package:clothshop/features/orders/domain/usecases/addtocart_usecase.dart';
import 'package:clothshop/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:clothshop/features/reviews/data/repositories/reviews_repositry_Impl.dart';
import 'package:clothshop/features/reviews/domain/repositories/reviews_repositry.dart';
import 'package:clothshop/features/reviews/domain/usecases/reviews_usecase.dart';
import 'package:clothshop/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // مفقود في الكود الأصلي
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1️⃣ تسجيل Firebase
  sl.registerLazySingleton(() => FirebaseFirestore.instance); 
  sl.registerLazySingleton(() => FirebaseAuthServices());
  sl.registerLazySingleton(() => FirestoreService(sl())); // تأكد من تسجيل FirestoreService

  // 2️⃣ تسجيل `AuthRepositries`
  sl.registerLazySingleton<AuthRepositries>(
    () => AuthRepositryImpl(
      firebaseAuthServices: sl(),
       // إضافة FirestoreService
    ),
  );

  // 3️⃣ تسجيل `HomeRepositry`
  sl.registerLazySingleton<HomeRepositry>(
    () => HomeRepostriesImpel(
      sl(),
      sl(),
      sl(), sl(),sl(), sl(),
    ),
  );

    sl.registerLazySingleton<ReviewsRepository>(
    () => ReviewsRepositoryImpl(
       sl(), // يفترض أن FirebaseFirestore مسجل مسبقاً
    ),
  );

  sl.registerLazySingleton<AddtocartRepositry>(()=> AddtocartRepositryImpl(firestoreService: sl()));

  sl.registerLazySingleton<CartRepositry>(
    () => CartRepositryImpl(
       remoteDatasourceCart: sl(), localDatasourceCart: sl(),
        sl()
  ));


  // 4️⃣ تسجيل `usecases`
  sl.registerLazySingleton(() => Authusecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ForgetpasswordUsecase(sl()));
  sl.registerLazySingleton(() => CategoryUsecase(sl()));
  sl.registerLazySingleton(()=> ProductsUsecase(sl()));
  sl.registerLazySingleton(() => ReviewsUsecase(sl(),));
  sl.registerLazySingleton(()=> NewProductsUsecase(sl()));
  sl.registerLazySingleton(() => Getproductsbytitle(sl()));
  sl.registerLazySingleton(() => GetAllProductsUsecase(sl()));
  sl.registerLazySingleton(()=> GetproductsBypriceUsecase(sl()));
  sl.registerLazySingleton(()=> AddtocartUsecase(addtocartRepositry: sl()));
  sl.registerLazySingleton(()=> GetcartsUsecase(sl()));

  sl.registerFactoryParam<TextEditingController, void, void>(
    (_, __) => TextEditingController(),
  );

 


  // 5️⃣ تسجيل `Cubits`
  sl.registerFactory(() => AuthinticationCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ForgetpasswordresetCubit(sl()));
  sl.registerFactory(() => CategoriesCubit(sl()));
  sl.registerFactory(()=> ProductsCubit(sl(),sl(),sl(),sl()));
  sl.registerFactory(() => CartCubit( sl()));
  final notificationBox = await Hive.openBox<NotificationModel>('notificationsBox');
sl.registerLazySingleton(() => notificationBox);
sl.registerLazySingleton<NotificationsCubit>(() => NotificationsCubit(sl()));
 sl.registerFactoryParam<ReviewsCubit,  String, void>(
  (productId, __) => ReviewsCubit(
    reviewsUsecase: sl(),
    reviewController: TextEditingController(),
    nameController: TextEditingController(),
    productId: productId, // Pass the productId here
  ),
);
sl.registerFactory(() => OrdersCubit(sl()));

  // 6️⃣ تسجيل `datasources`
  sl.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(sl())); // هنا يتم تسجيل RemoteDatasource
  sl.registerLazySingleton<LocalDatasource>(() => LocalDatasourceImpl(sl()));
  sl.registerLazySingleton<LocalProductdatasource>(()=> LocalProductdatasourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RemoteProductdatasource>(() => RemoteProductdatasourceImpl(sl()));
  sl.registerLazySingleton<RemoteDatasourceCart>(() => RemoteDatasourceCartImpl( firestoreService: sl()));
  sl.registerLazySingleton<LocalDatasourceCart>(() => LocalDatasourceCartImpl( sl()));

  // 7️⃣ تسجيل `NetworkInfo`
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

  // 8️⃣ تسجيل SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
