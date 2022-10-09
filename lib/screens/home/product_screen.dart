import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/bloc/categoryBloc/category_bloc.dart';
import 'package:mmt_club/bloc/export_bloc.dart';
import 'package:mmt_club/bloc/productsBloc/products_bloc.dart';
import 'package:mmt_club/widgets/refresh.dart';
import 'package:mmt_club/widgets/shimmer_list.dart';
import '../../Localization/localization.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_text.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/my_toast.dart';
import '../../widgets/product/product_card.dart';

class ProductScreen extends StatefulWidget {
  static String routeName = "/ProductList";
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductsBloc productBloc = ProductsBloc();
  bool isSortingAtoZ = true;
  bool isFiltering = false;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    productBloc.add(const GetAllProductsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    productBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("products"),
          style: AppTextStyle.appBarTextTheme(context),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textBlack,
          ),
        ),
      ),
      body: BlocConsumer(
        bloc: productBloc,
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is GetAllProductsError) {
            MyToast.show(
                context: context,
                text: Localization.of(context).getTranslatedValue("try_again"),
                toastState: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          if (state is GetAllProductsWaiting) {
            return const ShimmerList();
          } else if (state is GetAllProductsSuccessfully) {
            return Column(
              children: [
                Container(
                  color: Colors.transparent,
                  height: 55.h,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          size: 15.h,
                          icon: !isSortingAtoZ
                              ? FontAwesomeIcons.sortAlphaUp
                              : FontAwesomeIcons.sortAlphaDown,
                          onPressed: () {
                            setState(() {
                              isSortingAtoZ = !isSortingAtoZ;
                            });
                          },
                          text: Localization.of(context)
                              .getTranslatedValue("sorting"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          text: Localization.of(context)
                              .getTranslatedValue("filtering"),
                          onPressed: () async {
                            CategoryBloc categoryBloc = CategoryBloc();
                            categoryBloc.add(GetCategoryEvent());
                            return buildFilteringDialog(context, categoryBloc);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                state.productDetailsModels.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            Localization.of(context)
                                .getTranslatedValue("no_items_found"),
                            style: TextStyle(
                              fontSize: 17,
                              color: AppColors.basicColor,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.productDetailsModels.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = state.productDetailsModels;
                            if (isSortingAtoZ) {
                              data.sort((a, b) {
                                return a.name
                                    .toLowerCase()
                                    .compareTo(b.name.toLowerCase());
                              });
                            } else {
                              data = List.from(data.reversed);
                            }
                            return ProductCard(
                              product: data[index],
                            );
                          },
                        ),
                      )
              ],
            );
          } else if (state is GetAllProductsError) {
            return Center(
              child: TapToRefreesh(onTap: () {
                productBloc.add(const GetAllProductsEvent());
              }),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<dynamic> buildFilteringDialog(
      BuildContext context, CategoryBloc categoryBloc) {
    int? catID = -1;
    return showDialog(
      context: context,
      builder: (ctx) {
        return BlocBuilder(
          bloc: categoryBloc,
          builder: (context, state) {
            if (state is GetCategoryWaiting) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.all(20),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else if (state is GetCategorySuccessfully) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.all(20),
                title: Text(
                  Localization.of(context).getTranslatedValue("filters_title"),
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: StatefulBuilder(
                      builder: ((context, setInnerState) => Column(
                            children: [
                              Container(
                                height: 45.h,
                                child: TextField(
                                  controller: searchController,
                                  cursorHeight: 25.h,
                                  cursorColor: AppColors.basicColor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    suffixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  itemCount: state.cats.length,
                                  itemBuilder: (cxt, index) {
                                    return ListTile(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      title: Text(state.cats[index].name),
                                      leading: Radio<int>(
                                        toggleable: true,
                                        value: state.cats[index].id,
                                        groupValue: catID,
                                        onChanged: (var value) {
                                          // log(catID.toString());
                                          setInnerState(() {
                                            catID = value;
                                          });
                                        },
                                        activeColor: AppColors.basicColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (searchController.text.isNotEmpty || catID != -1) {
                        productBloc.add(GetAllProductsEvent(
                            catID: catID == -1 ? null : catID,
                            keyword: searchController.text.isEmpty
                                ? null
                                : searchController.text));
                      }

                      Navigator.of(ctx).pop();
                    },
                    child:
                        Text(Localization.of(context).getTranslatedValue("OK")),
                  ),
                ],
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
