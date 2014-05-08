$(function () {
    getPages($('#Id').val());
    $('#docContent ul').sortable({ update: function (event, ui) {
        updateOrder($('.thumbnails'));
    }
    });
});

function updateOrder(el) {
    var items = $(el).find('li');

    var id = $('#Id').val(); // $(el).data('id');
    var list = new Array();
    for (var i = 0; i < items.length; i++) {
        list.push($(items[i]).data('id'));
    }
    //    console.log(list);
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
function addPage(id, title, idPage) {
    addPageContent($('#Id').val(), idPage);
}
function addPageContent(id, idPage) {
    $('#docContent ul').append(
            '<li class="page-item item-' + id + '" id="page-' + idPage + '" data-id="' + idPage + '">' +
            '<img class="img-polaroid" alt="' + idPage + '" style="width: 100px; height: 100px;" src="' + getPageUrl + idPage + '"/>' +
            '<a class="close" href="#" onclick="return confirmBox(\'Etes-vous sur de vouloir supprimer cette page ?\', \'deletePage(\\\'' + idPage + '\\\');\');">&times;</a>' +
            '</li>'
            );
}
function deletePage(id) {
    $.post(deletePageUrl + '?id=' + id, function (data) {
        $('#page-' + id).remove();
    });
}

function getPages(id) {
    $.get(getPagesUrl + id, function (data) {
        $('.thumbnails').empty();
        for (var i = 0; i < data.ids.length; i++) {
            addPageContent(id, data.ids[i]);
        }
    });
}


$(function () {

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
                docId: $('#Id').val(),
                forceDoc: true
            },
            success: function (data) {
                getPages($('#Id').val());
                $('table tbody tr#fileUpload' + id).remove();
            }
        });
    }
});