

function showImage(id) {
    $.get(getPagesUrl + id, function (data) {
        var popup =
            '<div id="imgModal-' + id + '" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="imgModalLabel-' + id + '"aria-hidden="true">' +
            '   <div class="modal-header">' +
            '       <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> ×</button>' +
            '       <h3 id="imgModalLabel-' + id + '">Image</h3>' +
            '   </div>' +
            '    <div class="modal-body">' +
            '       <div id="carousel-' + id + '" class="carousel slide">' +
            '           <ol class="carousel-indicators">';
        for (var i = 0; i < data.ids.length; i++) {
            popup += '      <li data-target="#carousel-' + id + '" data-slide-to="' + i + '" class="' + (i == 0 ? "active" : "") + '"></li>';
        }
        popup +=
            '           </ol>' +
            '           <div class="carousel-inner">';
        for (var i = 0; i < data.ids.length; i++) {
            popup += '      <div class="item ' + (i == 0 ? "active" : "") + '">';
            popup += '          <img alt="' + data.ids[i] + '" src="' + getPageUrl + data.ids[i] + '">';
            popup += '      </div>';
        }
        popup += '      </div>';
        if (data.ids.length > 1) {
            popup += '          <a class="carousel-control left" href="#carousel-' + id + '" data-slide="prev">&lsaquo;</a>';
            popup += '          <a class="carousel-control right" href="#carousel-' + id + '" data-slide="next">&rsaquo;</a>';
        }
        popup +=
            '       </div>' +
            '   </div>' +
            '</div>';
        $('.thumbnails').append(popup);
        $('#imgModal-' + id).modal('show').on('hidden', function () {
            $('#imgModal-' + id).remove();
        });
    });
    $('#imgModal-' + id).remove();
}