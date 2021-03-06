QT       += core gui opengl widgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

win32 {

    OSG_LIB_DIRECTORY = $$(OSG)/lib
    OSG_INCLUDE_DIRECTORY = $$(OSG)/include
    VST3D_SDK_DIRECTORY = $$(VST3D)

    CONFIG(debug, debug|release) {

        TARGET = $$join(TARGET,,,_d)

        LIBS += -L$$OSG_LIB_DIRECTORY -losgd
        LIBS += -L$$OSG_LIB_DIRECTORY -losgViewerd
        LIBS += -L$$OSG_LIB_DIRECTORY -losgDBd
        LIBS += -L$$OSG_LIB_DIRECTORY -lOpenThreadsd
        LIBS += -L$$OSG_LIB_DIRECTORY -losgGAd
        LIBS += -L$$OSG_LIB_DIRECTORY -losgQt5d

    } else {

        LIBS += -L$$OSG_LIB_DIRECTORY -losg
        LIBS += -L$$OSG_LIB_DIRECTORY -losgViewer
        LIBS += -L$$OSG_LIB_DIRECTORY -losgDB
        LIBS += -L$$OSG_LIB_DIRECTORY -lOpenThreads
        LIBS += -L$$OSG_LIB_DIRECTORY -losgGA
        LIBS += -L$$OSG_LIB_DIRECTORY -losgQt5
        LIBS += -L$$VST3D_SDK_DIRECTORY/lib -lVisionBooster
    }

    INCLUDEPATH += $$OSG_INCLUDE_DIRECTORY
    INCLUDEPATH += $$VST3D_SDK_DIRECTORY/include
}

SOURCES += \
    camera_3d.cpp \
    cloud_geometry.cpp \
    cloud_io.cpp \
    main.cpp \
    mainwindow.cpp \
    qviewerwidget.cpp \
    vst3d_camera.cpp

HEADERS += \
    camera_3d.h \
    cloud_geometry.h \
    cloud_io.h \
    mainwindow.h \
    qviewerwidget.h \
    vst3d_camera.h

FORMS += \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    3DPointCloudVisualizaiton.pro.user
