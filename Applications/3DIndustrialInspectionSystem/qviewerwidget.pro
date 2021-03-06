QT += core gui opengl concurrent widgets

TARGET = 3DIndustrialInspectionSystem
TEMPLATE = app

DEFINES += QT_DEPRECATED_WARNINGS

CONFIG += c++14 c++17

# DESTDIR = ../../bin

# EIGEN
INCLUDEPATH = $$(MS3D)/Eigen

# OSG
win32 {

    OSG_LIB_DIRECTORY = $$(OSG)/lib
    OSG_INCLUDE_DIRECTORY = $$(OSG)/include
    #message($${OSG_LIB_DIRECTORY})
    #message($$(EIGEN))

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
        LIBS += -L$$OSG_LIB_DIRECTORY -losgUtil
    }

    #message($${LIBS}))

    INCLUDEPATH += $$OSG_INCLUDE_DIRECTORY
}

unix {

    CONFIG(debug, debug|release) {

        TARGET = $$join(TARGET,,,_d)

        LIBS += -losgd
        LIBS += -losgViewerd
        LIBS += -losgDBd
        LIBS += -lOpenThreadsd
        LIBS += -losgGAd
        LIBS += -losgQt5d

    } else {

        LIBS +=  -losg
        LIBS +=  -losgViewer
        LIBS +=  -losgDB
        LIBS +=  -lOpenThreads
        LIBS +=  -losgGA
        LIBS +=  -losgQt5
    }
}

INCLUDEPATH += ./include

SOURCES += $$files(./src/*.cpp) \
    src/common_use.cpp
HEADERS += $$files(./include/*.h) \
    include/BackProcessCom.h \
    include/BackProcessExp.h \
    include/LabelVisualCom.h \
    include/LabelVisualExp.h
FORMS += $$files(./forms/*.ui)
