import bb.cascades 1.2

Page {
    titleBar: TitleBar {
        title: qsTr("NFC Pairing");
    }

    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                _fuse.stopPairingNFC();
                _navigation.pop();
            }
        }
    }

    content: Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }

        Container {
            topPadding: 20
            bottomPadding: 20
            leftPadding: 20
            rightPadding: 20

            Label {
                text: qsTr("Ensure that NFC is enabled on your tablet, press the 'Pair' button, and place your devices back-to-back.")
                multiline: true
            }
        }

        Divider {
        }

        Container {
            topPadding: 20
            bottomPadding: 20
            leftPadding: 20
            rightPadding: 20

            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Fill

            Button {
                id: pairButton
                text: qsTr("Pair")

                horizontalAlignment: HorizontalAlignment.Center
                onClicked: {
                    _fuse.startPairingNFC();
                }
            }

            Label {
                id: pairingSuccessLabel
                horizontalAlignment: HorizontalAlignment.Center
            }
        }

    }

    onCreationCompleted: {
        _fuse.pairingNFCFinished.connect(nfcFinishedHandler);
        _fuse.pairingNFCError.connect(nfcErrorHandler);
    }

    function nfcFinishedHandler() {
        pairButton.enabled = false
        pairingSuccessLabel.text = qsTr("Successfully sent pairing!")
    }

    function nfcErrorHandler(error) {
        pairButton.enabled = true;
        pairingSuccessLabel.text = qsTr("Unable to send pairing (rc=%1)").arg(error)
    }
}
