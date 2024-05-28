
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/screens/murchant_Screen/murchantlayout.dart';
import 'package:smallproject/shared/style/colors.dart';

class UpdatePasswordMerchant extends StatelessWidget {
  final currentpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
   UpdatePasswordMerchant({super.key});

  @override
  Widget build(BuildContext context) {
            final cubit = BlocProvider.of<MerchantlayoutCubitCubit>(context);

    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children:
          [
             Row(
                          children: [
                            
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => const LayoutMurchant()));
                                },
                                icon: const Icon(Icons.arrow_back)),
                              const  Text('Update Profile',style: TextStyle(fontSize: 20),)
                          ],
                        ),
            TextField(
              controller: currentpasswordController,
              decoration:  const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Current Password"
              ),
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: newpasswordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Password"
              ),
            ),
            const SizedBox(height: 24,),
            BlocConsumer<MerchantlayoutCubitCubit,MerchantlayoutCubitState>(
                listener: (context,state){
                  if( state is ChangepasswordSuccessState )
                    {
                      showSnackBarItem(context, "Password Updated Successfully", true);
                        Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => const LayoutMurchant()));
                    }
                  if( state is ChangepswwordwithFailureState )
                    {
                      showSnackBarItem(context, state.error!, false);
                    }
                },
                builder: (context,state)
                {
                  return MaterialButton(
                    onPressed: ()
                    {
                      debugPrint("From TextField : ${currentpasswordController.text}");
                      {
                        if( newpasswordController.text.length >= 6 )
                        {
                         cubit.changePassword(currentPassword: currentpasswordController.text, newPassword: newpasswordController.text.trim());
                        }
                        else
                        {
                          showSnackBarItem(context,"Password must be at least 6 characters",false);
                        }
                      }
                     
                    },
                    color: mainColor,
                    height: 45,
                    minWidth: double.infinity,
                    textColor: Colors.white,
                    child: Text(state is ChangepasswordLoadingState ? "Loading..." : "Update"),
                  );
                }
            )
          ],
        ),
    ));
  }
}
  void showSnackBarItem(
      BuildContext context, String message, bool forSuccessOrFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
    ));
  }