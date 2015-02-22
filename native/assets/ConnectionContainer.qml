import bb.cascades 1.3
   
  Container {  
      opacity: 0;
      
      topPadding: ui.du(5.5)
      bottomPadding: ui.du(5.5)
      leftPadding: ui.du(4)
      rightPadding: ui.du(4)
      
      horizontalAlignment: HorizontalAlignment.Center
      verticalAlignment: VerticalAlignment.Center
      
      layout: StackLayout {
          orientation: LayoutOrientation.TopToBottom
      }
      
      Container {
          horizontalAlignment: HorizontalAlignment.Left
          verticalAlignment: VerticalAlignment.Center
          
          layout: StackLayout {
              orientation: LayoutOrientation.LeftToRight
          }
          
          ImageView {
              horizontalAlignment: HorizontalAlignment.Center
              verticalAlignment: VerticalAlignment.Center
              minWidth: ui.du(48)
              minHeight: ui.du(16)
              scalingMethod: ScalingMethod.AspectFit
              imageSource: "asset:///images/tutorial_connections.png"
          }
      }
      
      ScrollView {
          topMargin: ui.du(4.5)
          
          Container {
              Label {
                  text: qsTr("Connect in three ways") + Retranslate.onLanguageChanged
                  horizontalAlignment: HorizontalAlignment.Left
                  verticalAlignment: VerticalAlignment.Center
                  multiline: true
                  preferredWidth: 0
                  
                  textStyle {
                      color: Color.White
                      fontSize: FontSize.PointValue
                      fontSizeValue: _textConstants.titleFontSize
                      fontWeight: FontWeight.W500
                      base: SystemDefaults.TextStyles.PrimaryText
                  }
              }
              
              Label {
                  topMargin: ui.du(4.5)
                  
                  text: qsTr("You can connect to BlackBerry Blend wirelessly over a Wi-Fi network or mobile network by signing in with your BlackBerry ID. You can also use a USB cable connection with your computer.") + Retranslate.onLanguageChanged
                  horizontalAlignment: HorizontalAlignment.Center
                  verticalAlignment: VerticalAlignment.Center
                  multiline: true
                  preferredWidth: 0
                  
                  textStyle {
                      color: Color.create("#6e6a14")
                      fontSize: FontSize.PointValue
                      fontSizeValue: _textConstants.descriptionFontSize
                      base: SystemDefaults.TextStyles.PrimaryText
                  }
              }
          }
          
          scrollViewProperties {
              scrollMode: ScrollMode.Vertical
          }
      }
      
      attachedObjects: [
          TextConstants {
              id: _textConstants
          }
      ] 
  }
