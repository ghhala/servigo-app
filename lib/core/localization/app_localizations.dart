import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @visitWebsite.
  ///
  /// In en, this message translates to:
  /// **'Visit Our Website'**
  String get visitWebsite;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'create account'**
  String get createAccount;

  /// No description provided for @youAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'you already have account ?'**
  String get youAlreadyHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forgetPassword;

  /// No description provided for @itsHappened.
  ///
  /// In en, this message translates to:
  /// **'It\'s happened . Don\'t worry'**
  String get itsHappened;

  /// No description provided for @pleaseSendCode.
  ///
  /// In en, this message translates to:
  /// **'Please write your Email  Bellow To Send Code'**
  String get pleaseSendCode;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @errorLoadingMessages.
  ///
  /// In en, this message translates to:
  /// **'Error loading messages'**
  String get errorLoadingMessages;

  /// No description provided for @noMessagesYetSayHello.
  ///
  /// In en, this message translates to:
  /// **'No messages yet. Say hello! 👋'**
  String get noMessagesYetSayHello;

  /// No description provided for @typeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessageHint;

  /// No description provided for @photoLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photoLabel;

  /// No description provided for @videoLabel.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get videoLabel;

  /// No description provided for @customerTab.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customerTab;

  /// No description provided for @adminTab.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminTab;

  /// No description provided for @errorLoadingChats.
  ///
  /// In en, this message translates to:
  /// **'Error loading chats'**
  String get errorLoadingChats;

  /// No description provided for @errorLoadingAdmins.
  ///
  /// In en, this message translates to:
  /// **'Error loading admins'**
  String get errorLoadingAdmins;

  /// No description provided for @noConversationsYet.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get noConversationsYet;

  /// No description provided for @noAdminsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No admins available'**
  String get noAdminsAvailable;

  /// No description provided for @tapToContinueConversation.
  ///
  /// In en, this message translates to:
  /// **'Tap to continue conversation'**
  String get tapToContinueConversation;

  /// No description provided for @tapToStartConversation.
  ///
  /// In en, this message translates to:
  /// **'Tap to start conversation'**
  String get tapToStartConversation;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! '**
  String get welcomeBack;

  /// No description provided for @loginWithAccount.
  ///
  /// In en, this message translates to:
  /// **'Login With Your Account'**
  String get loginWithAccount;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with apple'**
  String get continueWithApple;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPasswordQuestion.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgetPasswordQuestion;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @otpCode.
  ///
  /// In en, this message translates to:
  /// **'Otp Code'**
  String get otpCode;

  /// No description provided for @pleaseEnterOtp.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Otp Code '**
  String get pleaseEnterOtp;

  /// No description provided for @changeIt.
  ///
  /// In en, this message translates to:
  /// **'Change It?'**
  String get changeIt;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code?'**
  String get resendCode;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in'**
  String get resendIn;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @resetPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordLabel;

  /// No description provided for @pleaseEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter New Password And Try Don\'t Forget it '**
  String get pleaseEnterNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @createUserAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a user account'**
  String get createUserAccount;

  /// No description provided for @welcomeCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account At ServiGo'**
  String get welcomeCreateAccount;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @selectAccountType.
  ///
  /// In en, this message translates to:
  /// **'Select account type'**
  String get selectAccountType;

  /// No description provided for @uploadIdPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload a personal ID photo'**
  String get uploadIdPhoto;

  /// No description provided for @uploadClearPhoto.
  ///
  /// In en, this message translates to:
  /// **'Please upload a clear photo of the ID from both sides'**
  String get uploadClearPhoto;

  /// No description provided for @uploadFrontImage.
  ///
  /// In en, this message translates to:
  /// **'Click to upload the front image of the ID'**
  String get uploadFrontImage;

  /// No description provided for @uploadBackImage.
  ///
  /// In en, this message translates to:
  /// **'Click to upload the back image of the ID'**
  String get uploadBackImage;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get takePhoto;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @byCreatingAccount.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you agree to our '**
  String get byCreatingAccount;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **' terms and conditions'**
  String get termsAndConditions;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @chooseService.
  ///
  /// In en, this message translates to:
  /// **'Choose The Service'**
  String get chooseService;

  /// No description provided for @workType.
  ///
  /// In en, this message translates to:
  /// **'Work Type'**
  String get workType;

  /// No description provided for @createLabourerAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a labourer account '**
  String get createLabourerAccount;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'S u c c e s s !'**
  String get success;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The account has been\ncreated successfully'**
  String get accountCreatedSuccessfully;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @nameAtLeast3.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters'**
  String get nameAtLeast3;

  /// No description provided for @nameNoNumbers.
  ///
  /// In en, this message translates to:
  /// **'Name cannot contain numbers or symbols'**
  String get nameNoNumbers;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhone;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @passwordAtLeast8.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordAtLeast8;

  /// No description provided for @confirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmYourPassword;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @pleaseSelectService.
  ///
  /// In en, this message translates to:
  /// **'Please select service'**
  String get pleaseSelectService;

  /// No description provided for @pleaseSelectRegion.
  ///
  /// In en, this message translates to:
  /// **'Please select region'**
  String get pleaseSelectRegion;

  /// No description provided for @onBoardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Your needs, one platform'**
  String get onBoardingTitle1;

  /// No description provided for @onBoardingDescription1.
  ///
  /// In en, this message translates to:
  /// **'Find trusted professionals near you compare ratings and choose with confidence'**
  String get onBoardingDescription1;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @onBoardingDescription2.
  ///
  /// In en, this message translates to:
  /// **' Welcome to the ServiGo which provides \n   you with services easily and simply\n  wherever you are.'**
  String get onBoardingDescription2;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @locationDetails.
  ///
  /// In en, this message translates to:
  /// **'Location Details'**
  String get locationDetails;

  /// No description provided for @pleaseSelectLocationFromMap.
  ///
  /// In en, this message translates to:
  /// **'Please select your location from the map'**
  String get pleaseSelectLocationFromMap;

  /// No description provided for @selectServiceType.
  ///
  /// In en, this message translates to:
  /// **'Select Service Type'**
  String get selectServiceType;

  /// No description provided for @notice.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get notice;

  /// No description provided for @mustAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'You must agree to the Terms and Conditions to create your account.'**
  String get mustAcceptTerms;

  /// No description provided for @pleaseConfirmLocationFirst.
  ///
  /// In en, this message translates to:
  /// **'Please open the map and confirm your location first'**
  String get pleaseConfirmLocationFirst;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome {userName}'**
  String welcomeUser(Object userName);

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account Info'**
  String get accountInfo;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @updateInfo.
  ///
  /// In en, this message translates to:
  /// **'Update Info'**
  String get updateInfo;

  /// No description provided for @noName.
  ///
  /// In en, this message translates to:
  /// **'No Name'**
  String get noName;

  /// No description provided for @noPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'No Phone Number'**
  String get noPhoneNumber;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No Email'**
  String get noEmail;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @loadingData.
  ///
  /// In en, this message translates to:
  /// **'Preparing your data...'**
  String get loadingData;

  /// No description provided for @errorLabel.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorLabel;

  /// No description provided for @dataUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data updated successfully'**
  String get dataUpdatedSuccessfully;

  /// No description provided for @uploadPhotoSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Photo uploaded successfully'**
  String get uploadPhotoSuccessfully;

  /// No description provided for @failedToUploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload photo: {errorMessage}'**
  String failedToUploadPhoto(Object errorMessage);

  /// No description provided for @pleaseFillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields'**
  String get pleaseFillRequiredFields;

  /// No description provided for @homeHelpPrompt.
  ///
  /// In en, this message translates to:
  /// **'How Can We Help You Today ?'**
  String get homeHelpPrompt;

  /// No description provided for @homeBannerText.
  ///
  /// In en, this message translates to:
  /// **'High Quality and Competitive\nPrices For Your Home Services'**
  String get homeBannerText;

  /// No description provided for @chooseServiceTypePrompt.
  ///
  /// In en, this message translates to:
  /// **'Choose the service type to begin \n your search :'**
  String get chooseServiceTypePrompt;

  /// No description provided for @noServicesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No services available'**
  String get noServicesAvailable;

  /// No description provided for @favoriteProviders.
  ///
  /// In en, this message translates to:
  /// **'Favorite Providers :'**
  String get favoriteProviders;

  /// No description provided for @noFavoriteProviders.
  ///
  /// In en, this message translates to:
  /// **'No favorite providers yet'**
  String get noFavoriteProviders;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {errorMessage}'**
  String errorMessage(Object errorMessage);

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @unknownProvider.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownProvider;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get completeYourProfile;

  /// No description provided for @completeYourProfileDetails.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile details to\nbe able to post about your\nservice, it is complete:'**
  String get completeYourProfileDetails;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete profile'**
  String get completeProfile;

  /// No description provided for @locationDescription.
  ///
  /// In en, this message translates to:
  /// **'Location description'**
  String get locationDescription;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get aboutMe;

  /// No description provided for @enterLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter a description of your location to help customers find you'**
  String get enterLocationDescription;

  /// No description provided for @describeYourself.
  ///
  /// In en, this message translates to:
  /// **'Describe yourself in a few words'**
  String get describeYourself;

  /// No description provided for @failedToLoadSubServices.
  ///
  /// In en, this message translates to:
  /// **'Failed to load sub services'**
  String get failedToLoadSubServices;

  /// No description provided for @setPriceForServices.
  ///
  /// In en, this message translates to:
  /// **'Set the price for the services :'**
  String get setPriceForServices;

  /// No description provided for @specifyHolidayDays.
  ///
  /// In en, this message translates to:
  /// **'Specify the holiday days :'**
  String get specifyHolidayDays;

  /// No description provided for @fillProviderRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in location, about me, select a sub category, and upload your profile photo'**
  String get fillProviderRequiredFields;

  /// No description provided for @updateProfileSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get updateProfileSuccessfully;

  /// No description provided for @updateProfileFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile: {error}'**
  String updateProfileFailed(Object error);

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get sessionExpired;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @fixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get fixed;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get both;

  /// No description provided for @serviceTypeFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get serviceTypeFixed;

  /// No description provided for @serviceTypeMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get serviceTypeMobile;

  /// No description provided for @serviceTypeBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get serviceTypeBoth;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get changeProfilePicture;

  /// No description provided for @openGalleryToSelectPhoto.
  ///
  /// In en, this message translates to:
  /// **'Open gallery to select a new photo'**
  String get openGalleryToSelectPhoto;

  /// No description provided for @capturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Capture Photo'**
  String get capturePhoto;

  /// No description provided for @openCameraToCapturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Open camera to capture a new photo'**
  String get openCameraToCapturePhoto;

  /// No description provided for @chooseSubCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose sub category :'**
  String get chooseSubCategoryLabel;

  /// No description provided for @chooseSubCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'Choose sub category'**
  String get chooseSubCategoryHint;

  /// No description provided for @setWorkingHoursLabel.
  ///
  /// In en, this message translates to:
  /// **'Set working hours :'**
  String get setWorkingHoursLabel;

  /// No description provided for @fromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get fromLabel;

  /// No description provided for @toLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get toLabel;

  /// No description provided for @myCertificates.
  ///
  /// In en, this message translates to:
  /// **'My Certificates'**
  String get myCertificates;

  /// No description provided for @addCertificatesHint.
  ///
  /// In en, this message translates to:
  /// **'Add certificates to showcase your skills and qualifications.'**
  String get addCertificatesHint;

  /// No description provided for @certificateCountText.
  ///
  /// In en, this message translates to:
  /// **'{count} certificate(s) added'**
  String certificateCountText(Object count);

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @noCertificatesAddedYet.
  ///
  /// In en, this message translates to:
  /// **'No certificates added yet.'**
  String get noCertificatesAddedYet;

  /// No description provided for @tapToAddCertificates.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your certificates'**
  String get tapToAddCertificates;

  /// No description provided for @addToPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Add to Portfolio'**
  String get addToPortfolio;

  /// No description provided for @addPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add Photos'**
  String get addPhotos;

  /// No description provided for @chooseOneOrMoreImages.
  ///
  /// In en, this message translates to:
  /// **'Choose one or more images'**
  String get chooseOneOrMoreImages;

  /// No description provided for @addVideo.
  ///
  /// In en, this message translates to:
  /// **'Add Video'**
  String get addVideo;

  /// No description provided for @chooseVideoFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose a video from gallery'**
  String get chooseVideoFromGallery;

  /// No description provided for @myPortfolio.
  ///
  /// In en, this message translates to:
  /// **'My Portfolio'**
  String get myPortfolio;

  /// No description provided for @addPortfolioHint.
  ///
  /// In en, this message translates to:
  /// **'Add photos & videos of your work'**
  String get addPortfolioHint;

  /// No description provided for @portfolioCountText.
  ///
  /// In en, this message translates to:
  /// **'{count} item(s) added'**
  String portfolioCountText(Object count);

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'VIDEO'**
  String get video;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// No description provided for @failedToLoadVideo.
  ///
  /// In en, this message translates to:
  /// **'Failed to load video'**
  String get failedToLoadVideo;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// No description provided for @addDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add description...'**
  String get addDescriptionHint;

  /// No description provided for @noPortfolioItemsYet.
  ///
  /// In en, this message translates to:
  /// **'No portfolio items yet.'**
  String get noPortfolioItemsYet;

  /// No description provided for @tapToAddPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add photos or videos'**
  String get tapToAddPortfolio;

  /// No description provided for @addDescription.
  ///
  /// In en, this message translates to:
  /// **'Add Description'**
  String get addDescription;

  /// No description provided for @describeThisWork.
  ///
  /// In en, this message translates to:
  /// **'Describe this work...'**
  String get describeThisWork;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @avgRating.
  ///
  /// In en, this message translates to:
  /// **'Avg rating'**
  String get avgRating;

  /// No description provided for @bothFixedMobile.
  ///
  /// In en, this message translates to:
  /// **'Both(Fixed & Mobile)'**
  String get bothFixedMobile;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @overnightYesNo.
  ///
  /// In en, this message translates to:
  /// **'Overnight: {value}'**
  String overnightYesNo(Object value);

  /// No description provided for @workingHoursAndDays.
  ///
  /// In en, this message translates to:
  /// **'Working Hours and Days'**
  String get workingHoursAndDays;

  /// No description provided for @allDays.
  ///
  /// In en, this message translates to:
  /// **'All Days'**
  String get allDays;

  /// No description provided for @aboutHim.
  ///
  /// In en, this message translates to:
  /// **'About him'**
  String get aboutHim;

  /// No description provided for @aboutMeEmptyOwner.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t written a bio yet.'**
  String get aboutMeEmptyOwner;

  /// No description provided for @aboutMeEmptyProvider.
  ///
  /// In en, this message translates to:
  /// **'No info written by provider.'**
  String get aboutMeEmptyProvider;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @customerReviewsAndRatings.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews and Ratings'**
  String get customerReviewsAndRatings;

  /// No description provided for @addReview.
  ///
  /// In en, this message translates to:
  /// **'+ Add Review'**
  String get addReview;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @sendComplaint.
  ///
  /// In en, this message translates to:
  /// **'Send complaint'**
  String get sendComplaint;

  /// No description provided for @writeComplaint.
  ///
  /// In en, this message translates to:
  /// **'Write the complaint...'**
  String get writeComplaint;

  /// No description provided for @complaintSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Complaint sent successfully'**
  String get complaintSentSuccessfully;

  /// No description provided for @failedToSendComplaint.
  ///
  /// In en, this message translates to:
  /// **'Failed to send complaint'**
  String get failedToSendComplaint;

  /// No description provided for @reportReview.
  ///
  /// In en, this message translates to:
  /// **'Report review'**
  String get reportReview;

  /// No description provided for @reportReviewReason.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this review?'**
  String get reportReviewReason;

  /// No description provided for @reviewReportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Review reported successfully'**
  String get reviewReportedSuccessfully;

  /// No description provided for @failedToReportReview.
  ///
  /// In en, this message translates to:
  /// **'Failed to report review'**
  String get failedToReportReview;

  /// No description provided for @deleteReview.
  ///
  /// In en, this message translates to:
  /// **'Delete review'**
  String get deleteReview;

  /// No description provided for @deleteReviewConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your review? This action cannot be undone.'**
  String get deleteReviewConfirm;

  /// No description provided for @failedToDeleteReview.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete review'**
  String get failedToDeleteReview;

  /// No description provided for @addReviewDialog.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReviewDialog;

  /// No description provided for @writeYourReview.
  ///
  /// In en, this message translates to:
  /// **'Write your review...'**
  String get writeYourReview;

  /// No description provided for @reviewAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Review added successfully'**
  String get reviewAddedSuccessfully;

  /// No description provided for @failedToSubmitReview.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review: {error}'**
  String failedToSubmitReview(Object error);

  /// No description provided for @editReview.
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get editReview;

  /// No description provided for @reviewUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Review updated successfully'**
  String get reviewUpdatedSuccessfully;

  /// No description provided for @failedToUpdateReview.
  ///
  /// In en, this message translates to:
  /// **'Failed to update review: {error}'**
  String failedToUpdateReview(Object error);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @selectedDays.
  ///
  /// In en, this message translates to:
  /// **'Selected Days: '**
  String get selectedDays;

  /// No description provided for @noPhone.
  ///
  /// In en, this message translates to:
  /// **'No Phone'**
  String get noPhone;

  /// No description provided for @favoriteToggleFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update favorites'**
  String get favoriteToggleFailed;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @locating.
  ///
  /// In en, this message translates to:
  /// **'Locating...'**
  String get locating;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmLocation;

  /// No description provided for @searchPlace.
  ///
  /// In en, this message translates to:
  /// **'Search place'**
  String get searchPlace;

  /// No description provided for @filterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterTitle;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @applyFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply Filter'**
  String get applyFilter;

  /// No description provided for @noProvidersFound.
  ///
  /// In en, this message translates to:
  /// **'No providers found matching these criteria'**
  String get noProvidersFound;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By:'**
  String get sortBy;

  /// No description provided for @sortPriceAsc.
  ///
  /// In en, this message translates to:
  /// **'Price ↑'**
  String get sortPriceAsc;

  /// No description provided for @sortRatingDesc.
  ///
  /// In en, this message translates to:
  /// **'Rating ↓'**
  String get sortRatingDesc;

  /// No description provided for @sortLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get sortLocation;

  /// No description provided for @couldNotGetLocation.
  ///
  /// In en, this message translates to:
  /// **'Could not get your location. Please enable GPS.'**
  String get couldNotGetLocation;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @topProviders.
  ///
  /// In en, this message translates to:
  /// **'Top 5 providers'**
  String get topProviders;

  /// No description provided for @anErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get anErrorOccurred;

  /// No description provided for @subServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Sub Service'**
  String get subServiceLabel;

  /// No description provided for @requiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredLabel;

  /// No description provided for @pleaseSelectSubServiceFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a sub service first'**
  String get pleaseSelectSubServiceFirst;

  /// No description provided for @ratingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingLabel;

  /// No description provided for @anyRating.
  ///
  /// In en, this message translates to:
  /// **'Any Rating'**
  String get anyRating;

  /// No description provided for @rating2AndUp.
  ///
  /// In en, this message translates to:
  /// **'2 stars & up'**
  String get rating2AndUp;

  /// No description provided for @rating3AndUp.
  ///
  /// In en, this message translates to:
  /// **'3 stars & up'**
  String get rating3AndUp;

  /// No description provided for @rating4AndUp.
  ///
  /// In en, this message translates to:
  /// **'4 stars & up'**
  String get rating4AndUp;

  /// No description provided for @rating5Only.
  ///
  /// In en, this message translates to:
  /// **'5 stars only'**
  String get rating5Only;

  /// No description provided for @availabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availabilityLabel;

  /// No description provided for @availableNow.
  ///
  /// In en, this message translates to:
  /// **'Available Now'**
  String get availableNow;

  /// No description provided for @any.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'price (SYP)'**
  String get priceLabel;

  /// No description provided for @syp.
  ///
  /// In en, this message translates to:
  /// **'SYP'**
  String get syp;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
