
import bb.cascades 1.3
import bb.system 1.0

NavigationPane {
    id: _navPane

    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                _invokeHelp.trigger("bb.action.OPEN");
            }
        }
    }
    
    attachedObjects: [
        Invocation {
            id: _invokeHelp
            query.mimeType: "text/html"
            query.uri: "help://sys.fuse"
            query.perimeter: SecurityPerimeter.Personal
        }
    ]

    Page {
        
        id: mainPage

        titleBar: TitleBar {
            title: qsTr("BlackBerry Blend") + Retranslate.onLanguageChanged;
        }

        Container {   
            topPadding: 20
            bottomPadding: 20

            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            
            Container {
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                visible: true

                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }

                Label {
                    text: qsTr("This device has been paired with one or more computers or tablets") + Retranslate.onLanguageChanged
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    multiline: true
                    
                    textStyle {
                        fontSize: FontSize.Medium
                    }
                }
                
                SettingsLink {
                    text: qsTr("Go to Device Connections settings") + Retranslate.onLanguageChanged
                    uri: "settings://link"
                    
                    onInvokeCard: {
                        _fuse.onInvokeCard(uri);
                    }
                }
                
                Divider {
                }
            }
            
            Container {
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                visible: true
                
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
            
                Label {
                    text: qsTr("Connections") + Retranslate.onLanguageChanged
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    multiline: true
                    preferredWidth: 0
                    
                    textStyle {
                        color: Color.create("#c0c0c0")
                    }
                }
                
                Divider {
                }
                
                Label {
                    id: pairMessageLable
                    text: qsTr("No Paired computers or tablets \n\nLaunch BlackBerry Blend on your computer or tablet to start pairing") + Retranslate.onLanguageChanged
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    multiline: true
                    preferredWidth: 0
                    
                    visible: _fuse.pairedDeviceCount == 0 ? true : false
                }
                
                ListView {
                    id: _listDevices
                    property alias confirmDelete: _confirmDelete
                    property string deletedClientUID
                    
                    dataModel: _fuse.clientModel
                    
                    function disconnectClient(UID) {
                        _fuse.onClientDisconnect(UID);
                    }
                    
                    function enableClient(UID, checked)
                    {
                        _fuse.onClientEnabled(UID, checked);
                    }
                    
                    listItemComponents: [

                        ListItemComponent {
                            type: "item"
                            
                            Container {
                                id: _item
                                verticalAlignment: VerticalAlignment.Center
                                
                                background: _item.ListItem.selected ? Color.create("#0073bc") : Color.Transparent
                                
                                contextActions: [
                                    ActionSet {
                                        ActionItem {
                                            title: qsTr("Disconnect") + Retranslate.onLanguageChanged
                                            enabled: ListItemData.clientConnected ? true : false
                                            
                                            imageSource: "asset:///images/disconnect.png"
                                            onTriggered: {
                                                _item.ListItem.view.disconnectClient(ListItemData.clientUID);
                                            }
                                        
                                        }
                                        
                                        DeleteActionItem {
                                            onTriggered: {
                                                var listView = _item.ListItem.view;
                                                listView.deletedClientUID = ListItemData.clientUID;
                                                listView.confirmDelete.title = qsTr("Delete %1?").arg(ListItemData.clientName) + Retranslate.onLanguageChanged;
                                                listView.confirmDelete.show();
                                            }
                                        }
                                    }
                                ]
                                
                                Container {
                                    topPadding: 8
                                    bottomPadding: 8      
                                    verticalAlignment: VerticalAlignment.Center

                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    
                                    ImageView {
                                        horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Center
                                        preferredWidth: ui.du(8)
                                        preferredHeight: ui.du(8)
                                        minWidth: ui.du(8)
                                        minHeight: ui.du(8)
                                        maxWidth: ui.du(8)
                                        maxHeight: ui.du(8)
                                        scalingMethod: ScalingMethod.AspectFit
                                        imageSource: "asset:///images/computer_ic.png"
                                    }
                                    
                                    Container {
                                        horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Center
                                        
                                        leftPadding: 20
                                        
                                        layout: StackLayout {
                                            orientation: LayoutOrientation.TopToBottom
                                        }
                                        
                                        Label {
                                            bottomPadding: 0
                                            bottomMargin: 0
                                            
                                            text: {
                                                if (ListItemData.clientName) {
                                                    ListItemData.clientName;
                                                } else {
                                                    qsTr("Desktop-") + ListItemData.clientUID.substr(-4);
                                                }
                                            }
                                            horizontalAlignment: HorizontalAlignment.Left
                                            verticalAlignment: VerticalAlignment.Center
                                            preferredWidth: 0
                                            
                                            textStyle {
                                                fontSize: FontSize.Large
                                            }
                                        }
                                        
                                        Label {
                                            topPadding: 0
                                            topMargin: 0
                                            text: {
                                                if (ListItemData.clientEnabled) {
                                                    if (ListItemData.clientConnected) {
                                                        if (ListItemData.clientTransport == 1) {
                                                            qsTr("Connected over a Wi-Fi network") + Retranslate.onLanguageChanged;
                                                        } else if (ListItemData.clientTransport == 2) {
                                                            qsTr("Connected using a USB cable") + Retranslate.onLanguageChanged;
                                                        } else if (ListItemData.clientTransport == 3) {
                                                            qsTr("Connected over a Mobile network") + Retranslate.onLanguageChanged;
                                                        } else {
                                                            qsTr("Connected") + Retranslate.onLanguageChanged;
                                                        }
                                                    } else {
                                                        qsTr("Disconnected") + Retranslate.onLanguageChanged;
                                                    }
                                                } else {
                                                    qsTr("Disabled") + Retranslate.onLanguageChanged;
                                                }
                                            }
                                            horizontalAlignment: HorizontalAlignment.Left
                                            verticalAlignment: VerticalAlignment.Center
                                            preferredWidth: 0
                                            
                                            textStyle {
                                                fontSize: FontSize.Small
                                                color: Color.create("#c0c0c0")
                                            }
                                        }
                                    }
                                    
                                    ImageView {
                                        horizontalAlignment: HorizontalAlignment.Right
                                        verticalAlignment: VerticalAlignment.Center
                                        
                                        rightPadding: 20
                                        
                                        preferredWidth: ui.du(8)
                                        preferredHeight: ui.du(8)
                                        minWidth: ui.du(8)
                                        minHeight: ui.du(8)
                                        maxWidth: ui.du(8)
                                        maxHeight: ui.du(8)
                                        scalingMethod: ScalingMethod.AspectFit
                                        visible: ListItemData.clientConnected;
                                        imageSource: {
                                            if (ListItemData.clientTransport == 1) {
                                                "asset:///images/wifi_ic.png"
                                            } else if (ListItemData.clientTransport == 2) {
                                                "asset:///images/usb_ic.png"
                                            } else if (ListItemData.clientTransport == 3) {
                                                "asset:///images/cellular_ic.png"
                                            } else {
                                                "asset:///images/wifi_ic.png"
                                            }
                                        }
                                    }
                                    
                                    ToggleButton {
                                        horizontalAlignment: HorizontalAlignment.Right
                                        verticalAlignment: VerticalAlignment.Center
                                        
                                        checked: ListItemData.clientEnabled;
                                        onCheckedChanged: {
                                            _item.ListItem.view.enableClient(ListItemData.clientUID, checked);
                                        }
                                    }
                                }   
                                
                                Divider {
                                    
                                }
                                
                            }

                        }
                    ]
                }
            }
        }

        actions: [
            ActionItem {
                id: launchStartup
                title: qsTr("Information") + Retranslate.onLanguageChanged
                imageSource: "asset:///images/learnmore_ic.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    var firstLaunchPage = firstLaunchPageDef.createObject();
                    _navPane.push(firstLaunchPage);
                }
            }
            
        ]
        
        attachedObjects: [
            ComponentDefinition {
                id: firstLaunchPageDef
                source: "FirstLaunchPage.qml"
            }, 
            
            SystemDialog {
                id: _confirmDelete
                body: qsTr("You won't be able to use this computer or tablet with BlackBerry Blend.") + Retranslate.onLanguageChanged
                confirmButton.label: qsTr("Delete") + Retranslate.onLanguageChanged
                onFinished: {
                    if(value == SystemUiResult.ConfirmButtonSelection) {
                        console.log("DEBUG Delete the client " + _listDevices.deletedClientUID);
                        _fuse.onClientDelete(_listDevices.deletedClientUID);
                    }
                }
            }
        ]
        
        onCreationCompleted: {
            if (_fuse.firstLaunch) {
                console.log("DEBUG frist launch Blend.");
                _fuse.cleanFirstLaunch();
                var firstLaunchPage = firstLaunchPageDef.createObject();
                _navPane.push(firstLaunchPage);
            }
            
            _fuse.pairedDeviceCountChanged.connect(onPairedDeviceCountChanged);
        }
        
        function onPairedDeviceCountChanged(count) {
            console.log("DEBUG The paired device count: " + count);
            pairMessageLable.visible = count == 0 ? true : false
        }
    }

    onPopTransitionEnded: {
        page.destroy();
    }
}
