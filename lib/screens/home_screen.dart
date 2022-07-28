import 'package:flutter/material.dart';
import 'package:flutter_product_app/models/response/product_response.dart';
import 'package:flutter_product_app/screens/login_screen.dart';
import 'package:flutter_product_app/screens/register_screen.dart';
import 'package:flutter_product_app/services/remote_service.dart';

class HomeScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String? token;

  const HomeScreen({
    Key? key,
    this.isLoggedIn = false,
    this.token,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductResponse>? products;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    print('token: ${widget.token}');
    products = await RemoteService().getProducts(widget.token);
    if (products != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildHomeAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: !widget.isLoggedIn
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: navigateToRegister,
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
          Expanded(
            child: Visibility(
              visible: isLoaded,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: products?.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(12.0),
                        right: Radius.circular(12.0),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        products != null ? products![index].sku : "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        products != null ? products![index].productName : "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildHomeAppBar() {
    return AppBar(
      title: const Text(
        'Products',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.lightBlue,
    );
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void navigateToRegister() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }
}
