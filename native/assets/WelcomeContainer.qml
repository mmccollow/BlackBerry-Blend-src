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
          layout: StackLayout {
              orientation: LayoutOrientation.LeftToRight
          }
          
          ImageView {
              horizontalAlignment: HorizontalAlignment.Left
              verticalAlignment: VerticalAlignment.Center
              minWidth: ui.du(20)
              minHeight: ui.du(20)
              scalingMethod: ScalingMethod.AspectFit
              imageSource: "asset:///images/blend_ic.png"
          }
          
          Label {
              text: qsTr("Welcome to BlackBerry Blend") + Retranslate.onLanguageChanged
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
      }

      ScrollView {
          topMargin: ui.du(4.5)
          
          Label {
              text: qsTr("BlackBerry Blend seamlessly brings messaging and content that’s on your BlackBerry smartphone to your computer and tablet. Get instant notifications, read and respond to your work and personal messages, and access your documents, calendar, contacts, and media in real time on whatever device you are on, powered by your BlackBerry.") + Retranslate.onLanguageChanged
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
