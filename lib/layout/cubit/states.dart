abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDataBaseState extends AppStates {}

class AppGetDataBaseState extends AppStates {}

class AppGetDataBaseLoadingState extends AppStates {}

class AppUpdateDataBaseState extends AppStates {}

class AppInsertDataBaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class AppDeleteDataBaseState extends AppStates {}

//..........
class AppCreateTaskLoadingState extends AppStates {}

class AppCreateTaskSuccessState extends AppStates {}

class AppCreateTaskErrorState extends AppStates {}


class GetTaskSuccessState extends AppStates{}

class GetTaskErrorState extends AppStates{}



class AppGetUserLoadingState extends AppStates{}

class AppGetUserSuccessState extends AppStates{}

class AppGetUserErrorState extends AppStates
{
  final String error;

  AppGetUserErrorState(this.error);
}



class AppGeTaskLoadingState extends AppStates{}

class AppGeTaskSuccessState extends AppStates{}

class AppGeTaskErrorState extends AppStates
{
  final String error;

  AppGeTaskErrorState(this.error);
}



