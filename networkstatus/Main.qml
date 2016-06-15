import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Connectivity 1.0
import Ubuntu.Components.ListItems 1.3 as ListItem

MainView {
    id: root
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "networkstatus.xiaoguo"

    width: units.gu(60)
    height: units.gu(85)

    function dumpObject(obj) {
        var keys = Object.keys(obj);
        console.log("length: " + keys.length)
        for( var i = 0; i < keys.length; i++ ) {
            var key = keys[ i ];
            var data = key + ' : ' + obj[ key ];
            console.log( key + ": " + data)
        }
    }

    Connections {
        id: conn
        target: NetworkingStatus
        // full status can be retrieved from the base C++ class
        // status property
        onStatusUpdated: {
            if (value === NetworkingStatus.Offline) {
                console.log("Status: Offline")
            }
            if (value === NetworkingStatus.Connecting) {
                console.log("Status: Connecting")
            }
            if (value === NetworkingStatus.Online) {
                console.log("Status: Online")
            }

            online.subText = NetworkingStatus.online ? "yes" : "no";
        }

        onWifiEnabledUpdated: {
            console.log("wifiEnabledUpdated: " + NetworkingStatus.WifiEnabled);
        }

        onFlightModeUpdated: {
            console.log("FlightModeUpdated: " + NetworkingStatus.flightMode);
            flightMode.subText = NetworkingStatus.flightMode ? "yes" : "no"
        }

        onHotspotEnabledUpdated: {
            console.log("hotspotEnabledUpdated: " + NetworkingStatus.hotspotEnabled)
            hotspotEnabled.subText = networkingStatus.hotspotEnabled ? "yes" : "no"
        }

        onUnstoppableOperationHappeningUpdated: {
            console.log("unstoppableOperationHappeningUpdated: " + NetworkingStatus.UnstoppableOperationHappening);
        }

        onWifiSwitchEnabledUpdated: {
            console.log("wifiSwitchEnabledUpdated: " + NetworkingStatus.wifiSwitchEnabled);
        }

        onFlightModeSwitchEnabledUpdated: {
            console.log("flightModeSwitchEnabledUpdated: " + NetworkingStatus.flightModeSwitchEnabled);
        }

        onHotspotSsidUpdated: {
            console.log("hotspotSsidUpdated: " + NetworkingStatus.hotspotSsid);
        }

        onHotspotPasswordUpdated: {
            console.log("hotspotPasswordUpdated: " + NetworkingStatus.password);
            hotspotPassword.subText = NetworkingStatus.password;
        }

        onHotspotStoredUpdated: {
            console.log("hotspotStoredUpdated: " + NetworkingStatus.hotspotStored);
        }

        onInitialized: {
            console.log("initialized");
        }
    }

    function getStatus(status) {
        switch(status) {
        case 0:
            return "Offline";
        case 1:
            return "Connecting";
        case 2:
            return "Online"
        }
    }

    function dumpProperties(obj) {
        var keys = Object.keys(obj);
        for( var i = 0; i < keys.length; i++ ) {
            var key = keys[ i ];
            var data = key + ' : ' + obj[ key ];
            console.log(data)
        }
    }

    Page {
        id: page
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("Networking Status")
        }

        Item {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                top:page.header.bottom
            }

            Flickable {
                id: scrollWidget
                anchors.fill: parent
                contentHeight: contentItem.childrenRect.height
                boundsBehavior: (contentHeight > root.height) ? Flickable.DragAndOvershootBounds :
                                                                Flickable.StopAtBounds
                flickableDirection: Flickable.VerticalFlick

                Column {
                    id: layout
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: units.gu(1)

                    ListItem.Subtitled {
                        text: i18n.tr("Interfaces")
                        subText: interfaceString
                    }

                    Repeater {
                        model: myModel
                        ListItem.Subtitled {
                            text: "IP address"
                            subText: modelData
                        }
                    }

                    ListItem.Subtitled {
                        id: online
                        text: i18n.tr("online")
                        subText: NetworkingStatus.online ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        id: bandwidth
                        text: i18n.tr("Bandwith")
                        subText: NetworkingStatus.limitedBandwith ? "Bandwith limited" : "Bandwith not limited"
                    }

                    ListItem.Subtitled {
                        id: flightMode
                        text: i18n.tr("flight mode")
                        subText: NetworkingStatus.flightMode ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        id: status
                        text: i18n.tr("Status")
                        subText: getStatus(NetworkingStatus.status)
                    }

                    ListItem.Subtitled {
                        id: wifiEnabled
                        text: i18n.tr("wifiEnabled")
                        subText: NetworkingStatus.wifiEnabled ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        id: flightModeSwichEnabled
                        text: i18n.tr("FlightModeSwitchEnabled")
                        subText: NetworkingStatus.FlightModeSwitchEnabled ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        text: i18n.tr("WifiSwitchEnabled")
                        subText: NetworkingStatus.WifiSwitchEnabled ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        text: i18n.tr("unstoppableOperationHappening")
                        subText: NetworkingStatus.unstoppableOperationHappening ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        text: i18n.tr("modemAvailable")
                        subText: NetworkingStatus.modemAvailable ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        text: i18n.tr("hotspotSsid")
                        subText: NetworkingStatus.hotspotSsid
                    }

                    ListItem.Subtitled {
                        text: i18n.tr("hotspotPassword")
                        subText: NetworkingStatus.hotspotPassword
                    }

                    ListItem.Subtitled {
                        text: i18n.tr("hotspotEnabled")
                        subText: NetworkingStatus.hotspotEnabled ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        id: hotspotSwitchEnabled
                        text: i18n.tr("HotspotSwitchEnabled")
                        subText: NetworkingStatus.HotspotSwitchEnabled ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        id: hotspotEnabled
                        text: i18n.tr("hotspotEnabled")
                        subText: NetworkingStatus.hotspotEnabled ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        id: hotspotPassword
                        text: i18n.tr("hotspotPassword")
                        subText: NetworkingStatus.hotspotPassword
                    }

                    ListItem.Subtitled {
                        text: i18n.tr("hotspotMode")
                        subText: NetworkingStatus.hotspotMode
                    }

                    ListItem.Subtitled {
                        text: i18n.tr("hotspotAuth")
                        subText: NetworkingStatus.hotspotAuth
                    }

                    ListItem.Subtitled {
                        id: hotspotStored
                        text: i18n.tr("hotspotStored")
                        subText: NetworkingStatus.hotspotStored ? "yes" : "no"
                    }

                    ListItem.Subtitled {
                        id: initialized
                        text: i18n.tr("Initialized")
                        subText: NetworkingStatus.Initialized ? "yes" : "no"
                    }

                    Rectangle {
                        width: parent.width
                        height: units.gu(0.1)
                        color: "red"
                    }

                    Label {
                        anchors.left: parent.left
                        anchors.leftMargin: units.gu(1)
                        text: "vpnConnections:"
                    }

                    ListView {
                        id: listview
                        width: parent.width
                        height: units.gu(5)
                        model: NetworkingStatus.vpnConnections
                        delegate: Label {
                            width:listview.width
                            text: ca + " " + connectionType
                        }
                    }
                }
            }
        }
    }
}

