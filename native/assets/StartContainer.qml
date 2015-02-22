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
              minWidth: ui.du(16)
              minHeight: ui.du(16)
              scalingMethod: ScalingMethod.AspectFit
              imageSource: "asset:///images/blend_ic.png"
          }
          
          ImageView {
              leftMargin: ui.du(2)
              horizontalAlignment: HorizontalAlignment.Center
              verticalAlignment: VerticalAlignment.Center
              minWidth: ui.du(16)
              minHeight: ui.du(16)
              scalingMethod: ScalingMethod.AspectFit
              imageSource: "asset:///images/tablet_and_laptop.png"
          }
      }
      
      ScrollView {
          topMargin: ui.du(4.5)
          
          Container {
              horizontalAlignment: HorizontalAlignment.Left
              
              Label {
                  text: qsTr("Let's get started") + Retranslate.onLanguageChanged
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
                  
                  text: qsTr("To get started, you’ll need to install BlackBerry Blend on your computer and/or tablet.") + Retranslate.onLanguageChanged
                  horizontalAlignment: HorizontalAlignment.Left
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
              
              TextArea {
                  text: qsTr("Visit www.blackberry.com/blend for more information.") + Retranslate.onLanguageChanged
                  horizontalAlignment: HorizontalAlignment.Left
                  verticalAlignment: VerticalAlignment.Center
                  
                  leftPadding: 0
                  rightPadding: 0
                  backgroundVisible: false
                  editable: false
                  
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

