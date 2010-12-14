// 
//  mimeimage.js
//  mime
//  
//  Created by Peter Haza on 2010-11-16.
//  Copyright 2010 Budstikka.Media. All rights reserved.
// 

CKEDITOR.dialog.add('mimeimage', function(editor) {
	
	var	lang = editor.lang.mimeimage,
			onUploadComplete = function(event, id, file, response, data) {
				var	jRes = jQuery.parseJSON(response),
						newData = '<figure>' +
						'<img src="'+jRes.thumb.url+'" data-id="'+jRes.media._id+'" data-thumbsize="'+jRes.thumb.width+'x'+jRes.thumb.height+'" contenteditable="false" data-size="'+jRes.size+'">' +
						'<figurecaption style="width: '+jRes.thumb.width+'px"></figurecaption>' +
						'</figure>' +
						'<p></p>',
						fakeElement = CKEDITOR.plugins.mimeimage.createFakeElement(
							editor,
							CKEDITOR.dom.element.createFromHtml(newData),
							jRes.thumb.width + 'x' + jRes.thumb.height);
				
				editor.insertElement(fakeElement);
				editor.fire('dataReady');
			};

	return {
		title: 'Bildeopplasting',
		minHeight: 100,
		minWidth: 400,
		buttons: [CKEDITOR.dialog.okButton],
		contents: [
			{
				id: 'page1',
				label: lang.dialog_label,
				elements: [
					{
						id:		'upload',
						type: 'html',
						html: '<div id="dialog_file_upload"></div>'
					},
					{
						id:		'info',
						type: 'html',
						html: '<ul></ul>'
					}
				]
			}
		],
		resizable: CKEDITOR.DIALOG_RESIZE_NONE,
		onOk: function() {
		},
		onShow: function() {
			var	that = this,
					settings = {
				uploader:				'/lib/jquery.uploadify-v2.1.4/uploadify.swf',
				expressInstall:	'/lib/jquery.uploadify-v2.1.4/expressInstall.swf',
				script:					'/medias',
				cancelImg:			'/lib/jquery.uploadify-v2.1.4/cancel.png',
				buttonText:			lang.buttonText,
				auto:						true,
				fileExt:				'*.jpg;*.jpeg;*.png;*.gif',
				fileDesc:				lang.images_only,
				fileDataName:		'media[file]',
				wmode:					'transparent',
				width: 150,
				height: 100,
				scriptData: {
					// Double encode intended
					authenticity_token: encodeURI(encodeURIComponent(jQuery('meta[name="csrf-token"]').attr('content'))),
					format: 'json',
					size: '250x200'
				},
				sizeLimit: 1024 * 1024 * 10,
				onComplete: onUploadComplete,
				onAllComplete: function() {
					that.getButton('ok').getElement().show();
				},
				onSelect: function() {
					that.getButton('ok').getElement().hide();
				}
			},
			session_key = jQuery('#session_key_name');
			
			settings.scriptData[session_key.attr('name')] = encodeURI(encodeURIComponent(session_key.val()));
			jQuery('#dialog_file_upload').siblings().remove().end().uploadify(settings);
		}
	};
});