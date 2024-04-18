import 'package:flutter/material.dart';
import 'package:login_learning/login/loginviewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewModel> {
  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (viewModel) {
        viewModel.setContext(context);
      },
      builder: (context, viewModel, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login Page',
                style: TextStyle(fontSize: 25.0),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your email',
                  ),
                  onChanged: viewModel.validateEmail,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your password',
                  ),
                  onChanged: viewModel.validatePassword,
                ),
              ),
              Container(
                width: 200.0,
                height: 55.0,
                child: ElevatedButton.icon(
                  onPressed: viewModel.formData.isValid()
                      ? viewModel.validateLogin
                      : null,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Login now",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: viewModel.formData.isValid()
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                      (Set<MaterialState> states) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (viewModel.hasError)
                Text(
                  viewModel.errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              if (viewModel.isSuccess)
                Text(
                  'Login Successful',
                  style: TextStyle(color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
