import bb.cascades 1.2

Page {
    titleBar: TitleBar {
        title: qsTr("Add New Android Tablet");
    }

    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                _navigation.pop();
            }
        }
    }

    Container {
        ScrollView {
            scrollViewProperties {
                scrollMode: ScrollMode.Vertical
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
                        text: qsTr("You have two ways to Fuse your Android tablet with your BlackBerry phone.")
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
                        text: qsTr("NFC")
                        onClicked: {
                            var addTabletNFCPage = addTabletNFCDefinition.createObject();
                            _navigation.push(addTabletNFCPage);
                        }
                    }

                    Button {
                        text: qsTr("Barcode")
                        onClicked: {
                            var addTabletBarcodePage = addTabletBarcodeDefinition.createObject();
                            _navigation.push(addTabletBarcodePage);
                        }
                    }

                    attachedObjects: [
                        ComponentDefinition {
                            id: addTabletBarcodeDefinition
                            source: "AddNewTabletBarcode.qml"
                        },
                        ComponentDefinition {
                            id: addTabletNFCDefinition
                            source: "AddNewTabletNFC.qml"
                        }
                    ]
                }
            }
        }
    }
}
