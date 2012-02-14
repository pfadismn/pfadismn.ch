$ ->
    buttons = $(".buttons")
    
    buttons.find("a").button()
    
    buttons.find("a.new").button( icons: {primary: 'ui-icon-document'}, text: false )
    buttons.find("a.edit").button( icons: {primary: 'ui-icon-pencil'}, text: false )
    buttons.find("a.delete").button( icons: {primary: 'ui-icon-trash'}, text: false )
    
    buttons.find("a.new.with-text").button( icons: {primary: 'ui-icon-document'}, text: true)
    buttons.find("a.edit.with-text").button( icons: {primary: 'ui-icon-pencil'}, text: true)
    buttons.find("a.delete.with-text").button( icons: {primary: 'ui-icon-trash'}, text: true)