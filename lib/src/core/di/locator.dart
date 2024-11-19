import 'package:burger_shop/src/config/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../module/product/product.dart';
import '../../module/user/data/repositories/profile_repo_impl.dart';
import '../../module/user/user.dart';
import '../core.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  ///Bloc

  sl.registerFactory(
    () => AuthBloc(
      getCurrentUser: sl(),
      signInWithPhoneNumber: sl(),
      sendSmsCode: sl(),
      signInWithGoogle: sl(),
      signOut: sl(),
    ),
  );

  sl.registerFactory(() => TimerCubit());

  sl.registerFactory(() => ImagePickerCubit());

  sl.registerFactory(() => ProductBloc(
        getAllProducts: sl(),
        addProduct: sl(),
      ));

  sl.registerFactory(() => CartBloc(
        addOrder: sl(),
      ));

  sl.registerFactory(() => CounterCubit());

  sl.registerFactory(() => ProfileBloc(
        getUserInfo: sl(),
        updateUserName: sl(),
        updateUserPhoto: sl(),
      ));

  sl.registerFactory(() => ShippingAddressCubit(
        addAddress: sl(),
        getAllAddresses: sl(),
        updateAddress: sl(),
        selectDefaultAddress: sl(),
      ));

  sl.registerFactory(() => PaymentMethodsCubit(
        addNewCard: sl(),
        getAllCards: sl(),
        selectDefaultCard: sl(),
      ));

  sl.registerFactory(() => PaymentCardNumberCubit());

  ///Usecases
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => SignInWithPhoneNumber(sl()));
  sl.registerLazySingleton(() => SendSmsCode(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));

  sl.registerLazySingleton(() => GetAllProducts(sl()));
  sl.registerLazySingleton(() => AddProduct(sl()));
  sl.registerLazySingleton(() => AddOrder(sl()));

  sl.registerLazySingleton(() => GetUserInfo(sl()));
  sl.registerLazySingleton(() => UpdateUserName(sl()));
  sl.registerLazySingleton(() => UpdateUserPhoto(sl()));
  sl.registerLazySingleton(() => AddShippingAddress(sl()));
  sl.registerLazySingleton(() => GetAllShippingAddress(sl()));
  sl.registerLazySingleton(() => UpdateShippingAddress(sl()));
  sl.registerLazySingleton(() => SelectDefaultShippingAddress(sl()));

  sl.registerLazySingleton(() => GetAllPaymentCards(sl()));
  sl.registerLazySingleton(() => AddNewPaymentCard(sl()));
  sl.registerLazySingleton(() => SelectDefaultPaymentCard(sl()));

  ///Repositories
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      remoteAuth: sl(),
      localAuth: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(
      remoteProduct: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      remoteProfile: sl(),
    ),
  );

  ///datasource
  sl.registerLazySingleton<FirebaseAutData>(
    () => FirebaseAuthImpl(
      firebaseAuth: sl(),
      firestore: sl(),
    ),
  );

  sl.registerLazySingleton<LocalAuth>(
    () => AuthSharedPreferencesImpl(authPreferences: sl()),
  );

  sl.registerLazySingleton<RemoteProduct>(
    () => RemoteProductImpl(
      firestore: sl(),
      localAuth: sl(),
    ),
  );

  sl.registerLazySingleton<RemoteProfile>(
    () => RemoteProfileImpl(
      firestore: sl(),
      localAuth: sl(),
      storage: sl(),
    ),
  );

  ///Core
  sl.registerLazySingleton<FirebaseAuthCore>(
    () => FirebaseAuthCoreImpl(firebaseAuth: sl()),
  );
  sl.registerLazySingleton<FirestoreCore>(
    () => FirestoreCoreImpl(firestoreDB: sl()),
  );
  sl.registerLazySingleton<FirebaseStorageCore>(
    () => FirebaseStorageCoreImpl(fbStorage: sl()),
  );
  sl.registerLazySingleton<SharedPreferencesDB>(
    () => SharedPreferencesImpl(preferencesCore: sl()),
  );

  ///Extarnal
  // Firebase
  final firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  sl.registerLazySingleton(() => firebase);
  final firebaseAuthDB = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuthDB);
  final firestoreDB = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestoreDB);
  final fbStorage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => fbStorage);

  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
