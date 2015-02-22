import bb.cascades 1.2
import bb.cascades.multimedia 1.0

Page {
    titleBar: TitleBar {
        title: qsTr("Add New Tablet");
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
                        text: qsTr("Select the type of tablet to Fuse with.")
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
                    verticalAlignment: VerticalAlignment.Center

                    Button {
                        text: qsTr("Android")

                        onClicked: {
                            var addNewTabletAndroidPage = addNewTabletAndroidDefinition.createObject();
                            _navigation.push(addNewTabletAndroidPage);
                        }
                    }

                    Button {
                        text: qsTr("iPad")
                        enabled: false

                        onClicked: {
                            var addNewTabletApplePage = addNewTabletAppleDefinition.createObject();
                            _navigation.push(addNewTabletApplePage);
                        }
                    }

                    attachedObjects: [
                        ComponentDefinition {
                            id: addNewTabletAndroidDefinition
                            source: "AddNewTabletAndroid.qml"
                        }
                    ]
                }
            }
        }
    }
}
