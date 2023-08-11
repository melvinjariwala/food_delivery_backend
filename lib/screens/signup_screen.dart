import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_backend/cubits/signup/signup_cubit.dart';
import 'package:food_delivery_backend/models/restaurant_model.dart';
import 'package:food_delivery_backend/models/user_model.dart' as Owner;
import 'package:food_delivery_backend/repositories/authentication/authentication_repository.dart';
import 'package:food_delivery_backend/repositories/restaurant/restaurant_repository.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static const String routeName = '/signup-screen';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const SignupScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signup",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: BlocProvider(
        create: (context) => SignupCubit(
            context.read<AuthenticationRepository>(),
            context.read<RestaurantRepository>()),
        child: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == SignupStatus.error) {
              // Error Handling
            }
          },
          child: const Center(
            child: SizedBox(
              height: 320,
              width: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _EmailInput(),
                  SizedBox(height: 20),
                  _PasswordInput(),
                  SizedBox(height: 20),
                  _SignupButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0))),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != previous.password,
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(
              labelText: "Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(builder: (context, state) {
      return state.status == SignupStatus.submitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context.read<SignupCubit>().signupFormSubmitted();
                // if (state.status == SignupStatus.success) {
                //   final user = FirebaseAuth.instance.currentUser;

                //   final restaurant = Restaurant(
                //       user: Owner.User(id: user!.uid, email: user.email));
                //   print("restaurant (after signup): $restaurant");
                //   final restaurantRepository =
                //       RepositoryProvider.of<RestaurantRepository>(context)
                //           .addRestaurant(restaurant);
                // }
              },
              child: const Text("Signup"));
    }, listener: (context, state) {
      if (state.status == SignupStatus.success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Signup successful")));
        Navigator.of(context).pop();
      } else if (state.status == SignupStatus.error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Signup failed")));
      }
    });
  }
}
