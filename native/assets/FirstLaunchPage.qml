import bb.cascades 1.3

Page {
    
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            imageSource: "asset:///images/action_home.png"
            onTriggered: {
                _navPane.pop();
                
                if (firstLaunchPage.themeChange) {
                    Application.themeSupport.setVisualStyle(VisualStyle.Bright);
                }
            }
        }
    }
    
    Container {
        
        id: firstLaunchPage
        
        property int pageIndex: 0
        property bool themeChange: false
        
        signal pageIndexChanged(int previousIndex, int index)
        
        function goNextPage() {
            console.log("DEBUG current page index = " + pageIndex + "; go to next page."); 
            
            if (pageIndex > 2) {
                console.log("DEBUG last page.");
                
                _navPane.pop();
                
                if (themeChange) {
                    Application.themeSupport.setVisualStyle(VisualStyle.Bright);
                }
                return;
            }
            
            
            _actionNext.enabled = false;
            _actionRestart.enabled = false;
            _actionBack.enabled = false;
            var previousPage = pageIndex;
            pageIndex ++;
            firstLaunchPage.pageIndexChanged(previousPage, pageIndex); 
        }
        
        function goPreviousPage() {
            console.log("DEBUG current page index = " + pageIndex + "; go to previous page.");
            
            if (pageIndex > 1) {
                
                var previousPage = pageIndex;
                pageIndex --;
                
                firstLaunchPage.pageIndexChanged(previousPage, pageIndex); 
            
            }  
        }
        
        function goFirstPage() {
            console.log("DEBUG current page index = " + pageIndex + "; go to first page."); 
            
            if (pageIndex <= 1) {
                console.log("DEBUG something wrong.");
                return;
            }
            
            
            _actionNext.enabled = false;
            _actionRestart.enabled = false;
            _actionBack.enabled = false;
            var previousPage = pageIndex;
            pageIndex = 1;
            firstLaunchPage.pageIndexChanged(previousPage, pageIndex); 
        }
        
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        
        layout: DockLayout {}
        
        ImageView {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            imageSource: "asset:///images/background.png"
            scalingMethod: ScalingMethod.AspectFill
        }
        
        Container {
            id: pageContainer
            
            visible: false
            
            layout: DockLayout {}
            background: Color.create("#dcd427");
            verticalAlignment: VerticalAlignment.Center
            
            animations: [
                
                ParallelAnimation {
                    id: firstIn
                    
                    ScaleTransition {
                        id: scaleFirstIn
                        easingCurve: StockCurve.CubicOut
                        duration: 800
                        
                        fromY: 0.5
                        toY: 1.0
                    }
                    
                    onEnded: {
                        pageContainer.scaleY = 1.0;
                        
                        welcomePage.opacity = 1;
                        _actionNext.enabled = true;
                        _actionBack.enabled = false;
                        _actionRestart.enabled = false;
                    }
                
                },
                
                ParallelAnimation {
                    id: pageOut
                    
                    ScaleTransition {
                        id: pageScaleOut
                        easingCurve: StockCurve.CubicOut
                        duration: 350
                    }
                    
                    onEnded: {  
                        if (firstLaunchPage.pageIndex == 1) {
                            welcomePage.opacity = 1;
                            
                            _actionNext.enabled = true;
                            _actionBack.enabled = false;
                            _actionRestart.enabled = false;
                        } else if (firstLaunchPage.pageIndex == 2) {
                            connectionPage.opacity = 1;
                            
                            _actionNext.enabled = true;
                            _actionBack.enabled = true;
                            _actionRestart.enabled = true;
                        
                        } else if (firstLaunchPage.pageIndex == 3) {
                            startPage.opacity = 1;
                            
                            _actionNext.enabled = true;
                            _actionBack.enabled = true;
                            _actionRestart.enabled = true;
                        }
                    }
                }
            ]

            
            function onPageIndexChanged(previousIndex, index) {
                if (previousIndex == 0) {
                    if (index == 1) {
                        // First page loaded.
                        console.log("Loading first page");
                        
                        welcomePage.visible = true;
                        connectionPage.visible = false;
                        startPage.visible = false;
                        pageContainer.scaleY = 0.5
                        pageContainer.visible = true;
                        
                        firstIn.play();
                    }
                } else {
                    
                    if (previousIndex == 1) {
                        welcomePage.opacity = 0;
                    } else if (previousIndex == 2) {
                        connectionPage.opacity = 0;
                    } else if (previousIndex == 3) {
                        startPage.opacity = 0;
                    }
                    
                    if (index == 1) {       
                        welcomePage.visible = true;
                        connectionPage.visible = false;
                        startPage.visible = false;
                    } else if (index == 2) { 
                        welcomePage.visible = false;
                        connectionPage.visible = true;
                        startPage.visible = false;
                    } else if (index == 3) {
                        welcomePage.visible = false;
                        connectionPage.visible = false;
                        startPage.visible = true;
                    }
                    
                    pageScaleOut.toY = 1.0;
                    pageOut.play();
                }
            }
            
            WelcomeContainer {
                id: welcomePage
            }
            
            ConnectionContainer {
                id: connectionPage
            }
            
            StartContainer {
                id: startPage
            }
        }
        
        onCreationCompleted: {
            console.log("DEBUG current page indes = " + pageIndex);
            
            if (Application.themeSupport.theme.colorTheme.style == VisualStyle.Bright) {
                Application.themeSupport.setVisualStyle(VisualStyle.Dark);
                themeChange = true;
            }
            
            _actionNext.enabled = false;
            _actionBack.enabled = false;
            _actionRestart.enabled = false;
            
            firstLaunchPage.pageIndexChanged.connect(pageContainer.onPageIndexChanged);
            
            firstLaunchPage.goNextPage();   
        }
    }
    
    actions: [
        
        ActionItem {
            id: _actionBack
            title: qsTr("Previous") + Retranslate.onLanguageChanged
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/action_back.png"
            onTriggered: {
                firstLaunchPage.goPreviousPage();
            }
        },
        
        ActionItem {
            id: _actionRestart
            title: qsTr("Restart") + Retranslate.onLanguageChanged
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/action_restart.png"
            
            onTriggered: {
                firstLaunchPage.goFirstPage();
            }
        },
        
        ActionItem {
            id: _actionNext
            title: qsTr("Next") + Retranslate.onLanguageChanged
            ActionBar.placement: ActionBarPlacement.Signature
            backgroundColor: Color.create("#dcd427");
            imageSource: "asset:///images/action_next.png"
            
            onTriggered: {
                firstLaunchPage.goNextPage();
            }
        }
    ]
    
    attachedObjects: [
        Delegate {
            id: previousActionItem
            ActionItem {
                id: previousAction
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/action_back.png"
                onTriggered: {
                    firstLaunchPage.goPreviousPage();
                }
            }
        }
    ]
}
