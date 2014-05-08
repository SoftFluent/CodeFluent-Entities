function addDocument(id, title) {
    addDocumentContent(id);
    addDocumentHeader(id, title);
    showDocument(id);
}
function addDocumentHeader(id, title) {
    $('#docHeader').append('<li><a href="#' + id + '" id="headerTab-' + id + '" data-id="' + id + '">' + title + '</a></li>');
    $('#docHeader').append(
    '<div id="titleModal-' + id + '" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="titleModalLabel-' + id + '" aria-hidden="true">' +
	'    <div class="modal-header">' +
	'	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>' +
	'	    <h3 id="titleModalLabel-' + id + '">Titre du document</h3>' +
	'    </div>' +
	'    <div class="modal-body">' +
	'	    <p>' +
	'		    <input id="title-' + id + '" value="' + title + '"/>' +
	'		    <a href="#" onclick="return modifyTitle(\'' + id + '\');" class="btn">Modifier</a>' +
	'	    </p>' +
	'    </div>' +
    '</div>'
    );
    $('#headerTab-' + id).sortable({ update: function (event, ui) {
        $('#thumbs-' + $(this).data('id')).append(ui.item);
        $(this).tab('show');
        updateOrder($('#thumbs-' + $(this).data('id')));
    }
    });
    $('[href="#' + id + '"]').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
}
function updateOrder(el) {
    var items = $(el).find('li');

    var id = $(el).data('id');
    var list = new Array();
    for (var i = 0; i < items.length; i++) {
        list.push($(items[i]).data('id'));
    }
    //        console.log(list);
    $.ajax({
        type: 'Post',
        dataType: 'json',
        url: reorderUrl,
        data: JSON.stringify({ id: id, list: list }),
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            // console.log('reordered');
        }
    });
}
function addDocumentContent(id) {
    $('#docContent').append('<div class="tab-pane" id="' + id + '"><a href="#titleModal-' + id + '" role="button" class="btn" data-toggle="modal"><i class="icon-pencil"></i>Modifier le titre</a><ul id="thumbs-' + id + '" class="thumbnails" data-id="' + id + '"></ul></div>');
    $('#thumbs-' + id).sortable({ connectWith: "#docHeader li a", update: function (event, ui) {
        updateOrder(this);
    }
    });
    getPages(id);
}
function showDocument(id) {
    $('[href="#' + id + '"]').tab('show');
}
function addPage(id, title, idPage) {
    if ($('#docHeader li').length == 1) {
        addDocument(id, title);
    } else {
        addPageContent($('#docContent .tab-pane.active').attr('id'), idPage);
    }
}
function addPageContent(id, idPage) {
    $('#docContent .tab-pane#' + id + ' ul').append(
            '<li class="page-item item-' + id + '" id="page-' + id + '" data-id="' + idPage + '">' +
            '<img class="img-polaroid" alt="' + idPage + '" style="width: 100px; height: 100px;" src="' + getPageUrl + idPage + '"/>' +
            '</li>'
            );
    $('#thumbs-' + id).sortable("refresh");
}
function getPages(id) {
    $.get(getPagesUrl + id, function (data) {
        for (var i = 0; i < data.ids.length; i++) {
            addPageContent(id, data.ids[i]);
        }
    });
}

function modifyTitle(id) {
    var title = $('#title-' + id).val();

    $.post(setTitleUrl, { id: id, title: title }, function (data) {
        $('#headerTab-' + id).text(title);
        $('#titleModal-' + id).modal('hide');
    });
    return false;
}
function createDoc() {
    var title = $('#newTitle').val();
    $.post(createDocUrl, { title: title }, function (data) {
        addDocument(data.id, title);
        $('#newTitle').val('');
        $('#newDoc').modal('hide');
    });
    return false;
}

$(function () {
    $('#docHeader').tab();

    $(document).on('dragenter', '#dropfile', function () {
        $(this).css('border', '3px dashed #BBBBEE');
        return false;
    });

    $(document).on('dragover', '#dropfile', function (e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).css('border', '3px dashed #BBBBEE');
        return false;
    });

    $(document).on('dragleave', '#dropfile', function (e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).css('border', '3px dashed #BBBBBB');
        return false;
    });

    $(document).on('drop', '#dropfile', function (e) {
        if (e.originalEvent.dataTransfer) {
            if (e.originalEvent.dataTransfer.files.length) {
                // Stop the propagation of the event
                e.preventDefault();
                e.stopPropagation();
                $(this).css('border', '3px dashed green');
                // Main function to upload
                upload(e.originalEvent.dataTransfer.files);
            }
        }
        else {
            $(this).css('border', '3px dashed #BBBBBB');
        }
        return false;
    });

    var selectedFiles = false;
    $('#selectFile').change(function (e) {
        selectedFiles = e.target.files;
        return false;
    });

    $('#addFile').click(function () {
        if (selectedFiles) {
            upload(selectedFiles);
            selectedFiles = false;
        }
    });

    function upload(files) {
        //            console.log(files);

        for (var i = 0; i < files.length; i++) {
            uploadFile(files[i]);
        }
        //            $('#dropfile').css('border', '3px dashed #BBBBBB');
    }
    function uploadFile(f) {
        var reader = new FileReader();

        if ((f.size / 1024 / 1024) > 5) {
            alert('Fichier trop volumineux (5Mo maximum).');
            return false;
        }

        // When the image is loaded,
        // run handleReaderLoad function
        reader.onload = function (evt) {
            return handleReaderLoad(evt, f);
        }

        // Read in the image file as a data URL.
        reader.readAsDataURL(f);
    }

    function handleReaderLoad(evt, f) {
        var id = $('table tbody tr').length + 1;
        $('table tbody').append('<tr id="fileUpload' + id + '"><td>' + f.name + '</td></tr>');
        //            console.log('upload : ' + f.name + " pending");
        $.ajax({
            type: 'POST',
            url: 'NewAjax',
            data: {
                dirId: $('#dirId').val(),
                fileName: f.name,
                fileContent: evt.target.result.split(',')[1],
                docId: ($('#docHeader li.active a').length == 0 ? "" : $('#docHeader li.active a').attr('href').replace('#', ''))
            },
            success: function (data) {
                if (data.multipage) {
                    addDocument(data.id, data.title);
                } else {
                    addPage(data.id, data.title, data.idPage);
                }
                $('table tbody tr#fileUpload' + id).remove();
            }
        });
    }
});