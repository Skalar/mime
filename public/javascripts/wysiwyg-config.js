CKEDITOR.editorConfig = function( config )
{
	config.toolbar = 'mime';
	config.toolbarCanCollapse = false;
	config.resize_dir = 'vertical';
	config.format_tags = 'p;h2;h3';
	config.extraPlugins = 'mimeimage,mimelink,autogrow';
	config.removePlugins = 'link,forms,image'; // Remove this to avoid the plugin registering for doubleclicks on links
	config.autoGrow_minHeight = 500;
	config.defaultLanguage = 'nb';
	config.contentsCss = ['http://yui.yahooapis.com/3.2.0/build/cssreset/reset-min.css', '/stylesheets/wysiwyg.css'];
	config.toolbar_mime = [
		[	'Format',
			'Bold', 'Italic', 'Underline', 'MimeImage', 'MimeLink', 'Unlink', '-',
			// Leave out image for now until the server side is ready
			// 'NumberedList', 'BulletedList', 'Image', 'Table', '-', 
			'NumberedList', 'BulletedList', 'Table', '-',
			'Subscript', 'Superscript', 'Blockquote', '-',
			'Undo', 'Redo'
		]
	];
};