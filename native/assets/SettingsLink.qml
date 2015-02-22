
import bb.cascades 1.3
import bb.system 1.0

Container {
    id: settingsLinkContainer
    property alias text: _label.text
    property int alignment: HorizontalAlignment.Fill
    property string uri
    
    signal invokeCard(string uri)

    horizontalAlignment: alignment
    Label {
        horizontalAlignment: HorizontalAlignment.Fill
        id: _label
        multiline: true
        textStyle {
            color: Color.create("#0073bc") // This color (magic number) is same as current setting color.
            fontSize: FontSize.Medium
        }
    }
    
    gestureHandlers:
    [
        TapHandler
        {
            onTapped:
            {
                settingsLinkContainer.launchUriOrAction();
            }
        }
    ]
    
    function launchUriOrAction()
    {
        invokeCard(uri);
    }
}
