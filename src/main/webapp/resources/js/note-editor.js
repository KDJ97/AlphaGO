/**
 * 작성자 : 예현의
 * 작성일 : 2022-07-07
 * 쪽지함 editor 사용을 위한 javascript 파일
 */

// ckeditor
ClassicEditor
.create( document.querySelector( '#ckeditor-classic' ) )
.then( function(editor) {
    editor.ui.view.editable.element.style.height = '500px';
} )
.catch( function(error) {
    console.error( error );
} );