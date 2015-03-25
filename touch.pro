QT += qml quick network multimedia positioning sql location
#TEMPLATE=app
TARGET = touch
!android: !ios: !blackberry: qtHaveModule(widgets): QT += widgets
qtHaveModule(webengine) {
        QT += webengine
        DEFINES += QT_WEBVIEW_WEBENGINE_BACKEND
}
include(src/src.pri)


OTHER_FILES += \
    main.qml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat


RESOURCES += \
    resources.qrc


ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

DISTFILES += \
    content/ui/AndroidDelegate.qml \
    content/ui/CategoryDelegate.qml \
    content/ui/ContextMenu.qml \
    content/ui/FlipBar.qml \
    content/ui/GoogleImagesDialog.qml \
    content/ui/HeaderRefresh.qml \
    content/ui/ImageChooser.qml \
    content/ui/ImageGallery.qml \
    content/ui/LineInput.qml \
    content/ui/MyRatingIndicator.qml \
    content/ui/SearchDelegate.qml \
    content/ui/Toast.qml \
    content/ui/ToolBarnium.qml\
    content/ui/camera/CameraButton.qml \
    content/ui/camera/CameraPropertyButton.qml \
    content/ui/camera/CameraPropertyPopup.qml \
    content/ui/camera/FocusButton.qml \
    content/ui/camera/PhotoCaptureControls.qml \
    content/ui/camera/PhotoPreview.qml \
    content/ui/camera/VideoCaptureControls.qml \
    content/ui/camera/VideoPreview.qml \
    content/ui/camera/ZoomControl.qml \
    content/ui/camera/CameraPage.qml \
    content/pages/Account.qml \
    content/pages/BookmarkPage.qml \
    content/pages/Home.qml \
    content/pages/MainForm.qml \
    content/pages/newStorePage.qml \
    content/pages/Particuliers.qml \
    content/pages/ProductDetailsPage.qml \
    content/pages/ProductsPage.qml \
    content/pages/Professionels.qml \
    content/pages/ProfilePage.qml \
    content/pages/SearchResultsPage.qml \
    content/pages/SplashscreenPage.qml \
    content/pages/StorePage.qml \
    content/pages/StorePageAdmin.qml \
    content/pages/StoresDashboardPage.qml \
    content/ui/FormInputDelegate.qml \
    content/ui/FormInputDelegateBtn.qml \
    content/ui/adWebKit.qml \
    content/ui/TimeEdit.qml \
    content/pages/SearchMapResultsPage.qml \
    content/pages/SearchListGridResultsPage.qml \
    content/pages/WorkingHourse.qml \
    content/pages/StoreWizardPage.qml \
    content/ui/camera/Popup.qml \
    content/pages/Test.qml
