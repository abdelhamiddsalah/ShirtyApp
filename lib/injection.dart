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
import 'package:clothshop/features/home/data/datasources/category_datasources/local_datasource.dart';
import 'package:clothshop/features/home/data/datasources/category_datasources/remote_datasource.dart';
import 'package:clothshop/features/home/data/datasources/product_datasources/local_productdatasource.dart';
import 'package:clothshop/features/home/data/datasources/product_datasources/remote_productdatasource.dart';
import 'package:clothshop/features/home/data/repositories/home_repostries_impel.dart';
import 'package:clothshop/features/home/domain/repositories/home_repositry.dart';
import 'package:clothshop/features/home/domain/usecases/category_usecase.dart';
import 'package:clothshop/features/home/domain/usecases/products_usecase.dart';
import 'package:clothshop/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:clothshop/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // مفقود في الكود الأصلي
import 'package:get_it/get_it.dart';
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
      sl(), sl(),sl(),
    ),
  );

  // 4️⃣ تسجيل `usecases`
  sl.registerLazySingleton(() => Authusecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ForgetpasswordUsecase(sl()));
  sl.registerLazySingleton(() => CategoryUsecase(sl()));
  sl.registerLazySingleton(()=> ProductsUsecase(sl()));

  // 5️⃣ تسجيل `Cubits`
  sl.registerFactory(() => AuthinticationCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ForgetpasswordresetCubit(sl()));
  sl.registerFactory(() => CategoriesCubit(sl()));
  sl.registerFactory(()=> ProductsCubit(sl()));

  // 6️⃣ تسجيل `datasources`
  sl.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(sl())); // هنا يتم تسجيل RemoteDatasource
  sl.registerLazySingleton<LocalDatasource>(() => LocalDatasourceImpl(sl()));
  sl.registerLazySingleton<LocalProductdatasource>(()=> LocalProductdatasourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RemoteProductdatasource>(() => RemoteProductdatasourceImpl(sl()));

  // 7️⃣ تسجيل `NetworkInfo`
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

  // 8️⃣ تسجيل SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
