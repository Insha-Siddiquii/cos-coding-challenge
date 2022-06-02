# 🎯 Project Car Inspector 

A new Flutter application for vehicle inspections, details and much more!

## 🗂 Features:
 - Login with Firebase Auth Credentials
 - Login with Firebase Google Sign-in
 - Get Registered with Firebase Auth
 - Amazing gradient themed UI
 - Inspected Vehicles & Details
 - Add vehicle for inspection
 - User settings
 - User profile
 - User change password
 - LogOut Functionality
 - Support iOS and android

 ## 💻 Code Insights:
 - [Used Barrel File - Import files like a pro](https://marketplace.visualstudio.com/items?itemName=miquelddg.dart-barrel-file-generator&ssr=false#overview)
 - [Flutter's Favorite: flutter_bloc state management](https://pub.dev/packages/flutter_bloc)
 - [Used Formz for input validations](https://pub.dev/packages/formz)
 - [Freezed auto code generator for model classes](https://pub.dev/packages/freezed)


## 🧮 Code Structure
<details>

```
📦lib
 ┣ 📂config
 ┃ ┣ 📜config.dart
 ┃ ┣ 📜constants.dart
 ┃ ┗ 📜styles.dart
 ┣ 📂data
 ┃ ┣ 📂http
 ┃ ┃ ┣ 📜user.dart
 ┃ ┃ ┗ 📜vehicle_inspection.dart
 ┃ ┣ 📂local
 ┃ ┃ ┗ 📜local_storage.dart
 ┃ ┗ 📂remote
 ┃ ┃ ┗ 📜firebase.dart
 ┣ 📂domain
 ┃ ┣ 📜auth_repository.dart
 ┃ ┣ 📜lcoal_storage_utils.dart
 ┃ ┣ 📜user_info_repository.dart
 ┃ ┣ 📜user_password_repository.dart
 ┃ ┗ 📜vehicle_repository.dart
 ┣ 📂ui
 ┃ ┣ 📂app_authentication
 ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┣ 📜authentication_bloc.dart
 ┃ ┃ ┃ ┣ 📜authentication_event.dart
 ┃ ┃ ┃ ┗ 📜authentication_state.dart
 ┃ ┃ ┗ 📜authentication.dart
 ┃ ┣ 📂change_password
 ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┣ 📜changepaswd_bloc.dart
 ┃ ┃ ┃ ┣ 📜changepaswd_event.dart
 ┃ ┃ ┃ ┗ 📜changepaswd_state.dart
 ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┗ 📜password.dart
 ┃ ┃ ┣ 📂view
 ┃ ┃ ┃ ┗ 📜change_paswd_page.dart
 ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┣ 📜change_pswd_button.dart
 ┃ ┃ ┃ ┣ 📜change_pswd_form.dart
 ┃ ┃ ┃ ┣ 📜confirm_password.dart
 ┃ ┃ ┃ ┗ 📜user_password.dart
 ┃ ┣ 📂edit_profile
 ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┗ 📜user_edit.dart
 ┃ ┃ ┣ 📂view
 ┃ ┃ ┃ ┗ 📜edit_profile_page.dart
 ┃ ┃ ┗ 📂widgets.
 ┃ ┃ ┃ ┣ 📜user_email_card.dart
 ┃ ┃ ┃ ┗ 📜user_photo.dart
 ┃ ┣ 📂login
 ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┣ 📜login_bloc.dart
 ┃ ┃ ┃ ┣ 📜login_event.dart
 ┃ ┃ ┃ ┗ 📜login_state.dart
 ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┣ 📜password.dart
 ┃ ┃ ┃ ┗ 📜useremail.dart
 ┃ ┃ ┣ 📂view
 ┃ ┃ ┃ ┣ 📜login_page.dart
 ┃ ┃ ┃ ┗ 📜view.dart
 ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┣ 📜google_login.dart
 ┃ ┃ ┃ ┣ 📜login_button.dart
 ┃ ┃ ┃ ┣ 📜login_form.dart
 ┃ ┃ ┃ ┣ 📜user_email.dart
 ┃ ┃ ┃ ┗ 📜user_password.dart
 ┃ ┣ 📂profile
 ┃ ┃ ┗ 📂view
 ┃ ┃ ┃ ┗ 📜profile.dart
 ┃ ┣ 📂sign_up
 ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┣ 📜signup_bloc.dart
 ┃ ┃ ┃ ┣ 📜signup_event.dart
 ┃ ┃ ┃ ┗ 📜signup_state.dart
 ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┣ 📜password.dart
 ┃ ┃ ┃ ┗ 📜useremail.dart
 ┃ ┃ ┣ 📂view
 ┃ ┃ ┃ ┣ 📜sign_up_page.dart
 ┃ ┃ ┃ ┗ 📜sign_up_text.dart
 ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┣ 📜sign_up_button.dart
 ┃ ┃ ┃ ┣ 📜sign_up_form.dart
 ┃ ┃ ┃ ┣ 📜user_email.dart
 ┃ ┃ ┃ ┗ 📜user_password.dart
 ┃ ┣ 📂vehicle_inspection_detail
 ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┣ 📜vehicleinspectionadd_bloc.dart
 ┃ ┃ ┃ ┣ 📜vehicleinspectionadd_event.dart
 ┃ ┃ ┃ ┗ 📜vehicleinspectionadd_state.dart
 ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┣ 📜vehicle_date.dart
 ┃ ┃ ┃ ┣ 📜vehicle_id.dart
 ┃ ┃ ┃ ┣ 📜vehicle_make.dart
 ┃ ┃ ┃ ┣ 📜vehicle_model.dart
 ┃ ┃ ┃ ┗ 📜vehicle_photo.dart
 ┃ ┃ ┗ 📂view
 ┃ ┃ ┃ ┣ 📜vehicle_detail.dart
 ┃ ┃ ┃ ┣ 📜vehicle_inspection_add.dart
 ┃ ┃ ┃ ┗ 📜vehicle_photo_uploader.dart
 ┃ ┗ 📂vehicle_inspection_overview
 ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┣ 📜vehicleinspection_bloc.dart
 ┃ ┃ ┃ ┣ 📜vehicleinspection_event.dart
 ┃ ┃ ┃ ┗ 📜vehicleinspection_state.dart
 ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┣ 📜vehicle.dart
 ┃ ┃ ┃ ┣ 📜vehicle.freezed.dart
 ┃ ┃ ┃ ┗ 📜vehicle.g.dart
 ┃ ┃ ┣ 📂view
 ┃ ┃ ┃ ┗ 📜vehicle_inspection.dart
 ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┣ 📜vehicle_inspection_list.dart
 ┃ ┃ ┃ ┗ 📜vehicle_list_item.dart
 ┣ 📜.DS_Store
 ┣ 📜app.dart
 ┣ 📜generated_plugin_registrant.dart
 ┗ 📜main.dart

```
</details>

## 📱 Demo

[Google Drive Video Demo](https://drive.google.com/drive/folders/1wEM15r-oPLlNcwEcKqWw9APtq0ywzl0J?usp=sharing)

