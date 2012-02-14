$ ->
    textile_settings = {
        nameSpace:           "textile"
        onShiftEnter:        {keepDefault:false, replaceWith:'\n\n'}
        markupSet: [
            {name:'Heading 1', key:'1', openWith:'h1(!(([![Class]!]))!). ' }
            {name:'Heading 2', key:'2', openWith:'h2(!(([![Class]!]))!). ' }
            {name:'Heading 3', key:'3', openWith:'h3(!(([![Class]!]))!). ' }
            {separator:' ' }
            {name:'Bold', key:'B', closeWith:'*', openWith:'*'}
            {name:'Italic', key:'I', closeWith:'_', openWith:'_'} 
            {name:'Stroke through', key:'S', closeWith:'-', openWith:'-'} 
            {separator:' ' }
            {name:'Bulleted list', openWith:'(!(* |!|*)!)'} 
            {name:'Numeric list', openWith:'(!(# |!|#)!)'} 
            {separator:' ' }
            {name:'Picture', replaceWith:'![![Source:!:http://]!]([![Alternative text]!])!'}, 
            {name:'Link', openWith:'"', closeWith:'([![Title]!])":[![Link:!:http://]!]' }
        ]
    }
    
    $(".textile_editor").markItUp(textile_settings)
    