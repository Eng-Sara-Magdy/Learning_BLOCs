import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_file_picker11/cubit/loadfile_cubit.dart';
import 'package:test_file_picker11/internet_connection/internetconnection_cubit.dart';
import 'package:test_file_picker11/profile_image/profile_image_cubit.dart';

void main() => runApp(MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text("CUBITs test")),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<LoadfileCubit>(
              create: (context) => LoadfileCubit(),
            ),
            BlocProvider<ProfileImageCubit>(
              create: (BuildContext context) => ProfileImageCubit(),
            ),
            BlocProvider<InternetconnectionCubit>(
              create: (BuildContext context) => InternetconnectionCubit(),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<InternetconnectionCubit, InternetconnectionState>(
                builder: (context, state) {
                  return (state.isConnected == true)
                      ? Text("Internet is connected")
                      : Text("no internet");
                },
              ),
              BlocBuilder<LoadfileCubit, LoadfileState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      context.read<LoadfileCubit>().onButtonClick();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                      ),
                      child: Text("load file",
                          style: TextStyle(color: Colors.black, fontSize: 33)),
                    ),
                  );
                },
              ),
              BlocBuilder<ProfileImageCubit, ProfileImageState>(
                builder: (context, state) {
                  return InkWell(
                    onLongPress: () {
                      context.read<ProfileImageCubit>().onButtonClick();
                    },
                    child: Center(
                      child: state.imagePath != null
                          ? Container(
                              height: 96,
                              width: 96,
                              child: Image.file(
                                File(state.imagePath),
                                fit: BoxFit.cover,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            )
                          : Container(
                              height: 96,
                              width: 96,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          )),
    )));
