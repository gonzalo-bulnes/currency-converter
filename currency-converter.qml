import QtQuick 2.0
import Ubuntu.Components 0.1

/*!
    \brief MainView with a Title.
*/

MainView {
    id: root
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the .desktop filename
    applicationName: "CurrencyConverter"

    width: units.gu(100)
    height: units.gu(75)

    property real margins: units.gu(2)
    property real buttonWidth: units.gu(9)

    Page {
        title: i18n.tr("Currency Converter")

    }
}
