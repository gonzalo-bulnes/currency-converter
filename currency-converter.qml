import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import Ubuntu.Components.Popups 0.1

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

    function convert(from, fromRateIndex, toRateIndex) {
        var fromRate = currencies.getRate(fromRateIndex);
        if (from.length <= 0 || fromRate <= 0.0)
            return "";
        return currencies.getRate(toRateIndex) * (parseFloat(from) / fromRate);
    }

    Page {
        title: i18n.tr("Currency Converter")

        ListModel {
            id: currencies
            ListElement {
                currency: "EUR"
                rate: 1.0
            }

            function getCurrency(idx) {
                return (idx >= 0 && idx < count) ? get(idx).currency: ""
            }

            function getRate(idx) {
                return (idx >= 0 && idx < count) ? get(idx).rate: 0.0
            }
        }

        XmlListModel {
            id: ratesFetcher
            source: "http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml"
            namespaceDeclarations: "declare namespace gesmes='http://www.gesmes.org/xml/2002-08-01';"
                                   + "declare default element namespace 'http://www.ecb.int/vocabulary/2002-08-01/eurofxref';"
            query: "/gesmes:Envelope/Cube/Cube/Cube"

            onStatusChanged: {
                if (status === XmlListModel.Ready) {
                    for (var i = 0; i < count; i++)
                        currencies.append({"currency": get(i).currency, "rate": parseFloat(get(i).rate)})
                }
            }

            XmlRole { name: "currency"; query: "@currency/string()" }
            XmlRole { name: "rate"; query: "@rate/string()" }
        }

        ActivityIndicator {
            anchors.right: parent.right
            running: ratesFetcher.status === XmlListModel.Loading
        }

        Component {
            id: currencySelector
            Popover {
                Column {
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                    height: pageLayout.height
                    Header {
                        id: header
                        text: i18n.tr("Select currency")
                    }
                    ListView {
                        clip: true
                        width: parent.width
                        height: parent.height - header.height
                        model: currencies
                        delegate: Standard {
                            text: currency
                            onClicked: {
                                caller.currencyIndex = index
                                caller.input.update()
                                hide()
                            }
                        }
                    }
                }
            }
        }
    }
}
