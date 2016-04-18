/*
Script: MooEditable.Image.js
        Extends MooEditable to insert image with manipulation options.
 
Usage:
   Add the following tags in your html
   <link rel="stylesheet" type="text/css" href="MooEditable.Table.css">
   <script type="text/javascript" src="mootools.js"></script>
   <script type="text/javascript" src="MooEditable.js"></script>
   <script type="text/javascript" src="MooEditable.Image.js"></script>
 
   <script type="text/javascript">
        window.addEvent('load', function(){
                var mooeditable = $('textarea-1').mooEditable({
                        actions: 'bold italic underline strikethrough | image | toggleview'
                });
   </script>
 
License:
        MIT-style license.
 
Author:
    Radovan Lozej <radovan lozej gmail com>
*/

MooEditable.UI.ImageDialog = function(editor){
        var html = 'url <input type="text" class="dialog-url" value="" size="15" /> '
                + 'width <input type="text" class="dialog-width" value="" size="2" /> '
                + '<select class="dialog-measure" style="margin-right: 15px;"><option>%</option><option>px</option></select> '
                + 'align <select class="dialog-align"><option>none</option><option>left</option><option>center</option><option>right</option></select> '
                + '<button class="dialog-button dialog-ok-button">OK</button> '
                + '<button class="dialog-button dialog-cancel-button">Cancel</button>';
                
        return new MooEditable.UI.Dialog(html, {
                'class': 'mooeditable-prompt-dialog',
                onOpen: function(){
                        var input = this.el.getElement('.dialog-url');
                        var node = editor.selection.getNode();
                        if (node.get('tag') == 'img'){

                                //MLB
                                node_width_measure = node.style.width
                                node_width = node_width_measure.replace('px', '');
                                if(node_width == node_width_measure){
                                    node_width = node_width_measure.replace('%', '');
                                    node_measure = '%'
                                }
                                else{
                                    node_measure = 'px'
                                }
                                //MLB

                                this.el.getElement('.dialog-url').set('value', node.get('src'));
                                this.el.getElement('.dialog-width').set('value', node_width);
                                this.el.getElement('.dialog-align').set('align', node.get('align'));
                                this.el.getElement('.dialog-measure').set('value', node_measure);
                        }
                        (function(){
                                input.focus();
                                input.select();
                        }).delay(10);
                },
                onClick: function(e){
                        if (e.target.tagName.toLowerCase() == 'button') e.preventDefault();
                        var button = document.id(e.target);
                        if (button.hasClass('dialog-cancel-button')){
                                this.close();
                        } else if (button.hasClass('dialog-ok-button')){
                                this.close();
                                var node = editor.selection.getNode();
                                if (node.get('tag') == 'img'){
                                        node.set('src', this.el.getElement('.dialog-url').get('value').trim());
                                       

                                        width = this.el.getElement('.dialog-width').get('value').trim();
                                        measure = this.el.getElement('.dialog-measure').get('value').trim();
                                        node.set('style', 'width:'+width+measure);


                                        node.set('align', this.el.getElement('.dialog-align').get('value'));
                                } else {
                                        var div = new Element('div');


                                        width = this.el.getElement('.dialog-width').get('value').trim();
                                        measure = this.el.getElement('.dialog-measure').get('value').trim();

                                        new Element('img', {
                                                'src' : this.el.getElement('.dialog-url').get('value').trim(),
                                                'style' : 'width:'+width+measure,
                                                'align' : this.el.getElement('.dialog-align').get('value')
                                        }).inject(div);
                                        editor.selection.insertContent(div.get('html'));
                                }
                        }
                }
        });
};


Object.append(MooEditable.Actions, {    
        
        image: {
                title: 'Add/Edit Image',
                options: {
                        shortcut: 'm'
                },
                dialogs: {
                        prompt: function(editor){
                                return MooEditable.UI.ImageDialog(editor);
                        }
                },
                command: function(){
                        this.dialogs.image.prompt.open();
                }
        }
        
});
