import 'package:get_it/get_it.dart';

// リポジトリ
import 'package:sampleorder/data/category/repository/category_repository_impl.dart';
import 'package:sampleorder/data/menu/repository/menu_repository_impl.dart';
import 'package:sampleorder/data/transaction/repository/transaction_repository_impl.dart';
import 'package:sampleorder/data/order/repository/order_repository_impl.dart';

// ユースケース（カテゴリー）
import 'package:sampleorder/domain/category/usecase/get_categories_usecase.dart';
import 'package:sampleorder/domain/category/usecase/add_category_usecase.dart';
import 'package:sampleorder/domain/category/usecase/update_category_usecase.dart';
import 'package:sampleorder/domain/category/usecase/delete_category_usecase.dart';

// ユースケース（メニュー）
import 'package:sampleorder/domain/menu/usecase/get_menu_items_usecase.dart';
import 'package:sampleorder/domain/menu/usecase/add_menu_item_usecase.dart';
import 'package:sampleorder/domain/menu/usecase/update_menu_item_usecase.dart';
import 'package:sampleorder/domain/menu/usecase/delete_menu_item_usecase.dart';

// ユースケース（取引）
import 'package:sampleorder/domain/transaction/usecase/get_transactions_usecase.dart';
import 'package:sampleorder/domain/transaction/usecase/add_transaction_usecase.dart';
import 'package:sampleorder/domain/transaction/usecase/update_transaction_usecase.dart';

// ユースケース（注文）
import 'package:sampleorder/domain/order/usecase/get_orders_usecase.dart';
import 'package:sampleorder/domain/order/usecase/add_order_usecase.dart';
import 'package:sampleorder/domain/order/usecase/update_order_usecase.dart';
import 'package:sampleorder/domain/order/usecase/delete_order_usecase.dart';

// ViewModel
import 'package:sampleorder/viewmodel/category_viewmodel.dart';
import 'package:sampleorder/viewmodel/menu_viewmodel.dart';
import 'package:sampleorder/viewmodel/transaction_viewmodel.dart';
import 'package:sampleorder/viewmodel/order_viewmodel.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // リポジトリの登録
  getIt.registerLazySingleton(() => CategoryRepositoryImpl());
  getIt.registerLazySingleton(() => MenuRepositoryImpl());
  getIt.registerLazySingleton(() => TransactionRepositoryImpl());
  getIt.registerLazySingleton(() => OrderRepositoryImpl());

  // カテゴリー用ユースケースの登録
  getIt.registerLazySingleton(
      () => GetCategoriesUseCase(getIt<CategoryRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => AddCategoryUseCase(getIt<CategoryRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => UpdateCategoryUseCase(getIt<CategoryRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => DeleteCategoryUseCase(getIt<CategoryRepositoryImpl>()));

  // メニュー用ユースケースの登録
  getIt.registerLazySingleton(
      () => GetMenuItemsUseCase(getIt<MenuRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => AddMenuItemUseCase(getIt<MenuRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => UpdateMenuItemUseCase(getIt<MenuRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => DeleteMenuItemUseCase(getIt<MenuRepositoryImpl>()));

  // 取引用ユースケースの登録
  getIt.registerLazySingleton(
      () => GetTransactionsUseCase(getIt<TransactionRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => AddTransactionUseCase(getIt<TransactionRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => UpdateTransactionUseCase(getIt<TransactionRepositoryImpl>()));

  // 注文用ユースケースの登録
  getIt.registerLazySingleton(
      () => GetOrdersUseCase(getIt<OrderRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => AddOrderUseCase(getIt<OrderRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => UpdateOrderUseCase(getIt<OrderRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => DeleteOrderUseCase(getIt<OrderRepositoryImpl>()));

  // ViewModelの登録
  getIt.registerFactory(() => CategoryViewModel());
  getIt.registerFactory(() => MenuViewModel());
  getIt.registerFactory(() => TransactionViewModel());
  getIt.registerFactory(() => OrderViewModel());
}
