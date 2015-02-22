import bb.cascades 1.2
import bb.cascades.multimedia 1.0

Page {
    id: barcodePage

    titleBar: TitleBar {
        title: qsTr("Barcode Pairing");
    }

    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                _navigation.pop();
            }
        }
    }

    Container {
        topPadding: 20
        bottomPadding: 20
        leftPadding: 20
        rightPadding: 20

        Container {
            bottomPadding: 20
            horizontalAlignment: HorizontalAlignment.Fill

            Label {
                text: qsTr("Launch the BlackBerry Fuse application on your tablet and scan the barcode.")
                multiline: true
            }
        }

        Container {
            objectName: "barcodeContainer"
            horizontalAlignment: HorizontalAlignment.Fill
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.0
            }

            layout: DockLayout {
            }

            // BarcodeView will be inserted here
        }
    }

    onCreationCompleted: {
        _fuse.displayBarcode(barcodePage);
    }
}
