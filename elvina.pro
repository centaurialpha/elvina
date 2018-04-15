QT += quick quickcontrols2
CONFIG += c++11

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    src/backend.js \
    src/MainPage.qml \
    src/main.qml \
    src/CButton.qml \
    Test.pro.user \
    elvina.pro.user \
    qtquickcontrols2.conf

HEADERS += \
    src/articulomodel.h

SOURCES += \
    src/main.cpp \
    src/articulomodel.cpp

RESOURCES += \
    qml.qrc
