function confirmBox(message, callback) {
    var html = '';

    html += '<div title="confirmation" class="modal">';
    html += '   <div class="modal-header">';
    html += '       <a href="#" class="close" data-dismiss="modal">x</a>';
    html += '       <h3>Confirmation</h3>';
    html += '   </div>';
    html += '   <div class="modal-body">';
    html += '       <p>' + message + '</p>';
    html += '   </div>';
    html += '   <div class="modal-footer">';
    html += '       <a href="#" class="btn" data-dismiss="modal">Annuler</a>';
    html += '       <a href="#" onclick="' + callback + '" class="btn btn-primary" data-dismiss="modal">Confirmer</a>';
    html += '   </div>';
    html += '</div>';

    //créer la popup et l'insérer dans le DOM
    var popup = $(html);

    $('form:eq(0)').append(popup);

    $(popup).on('shown', function () {
        $('.modal-backdrop').last().attr('style', 'z-index: 1055;');
        $(popup).attr('style', 'z-index: 1060;');
    });

    $(popup).modal({ show: false });

    $(popup).on('hidden', function () {
        $(popup).remove();
    });

    $(popup).modal('show');

    return false; //pour bloquer l'action du bouton
}

function alertBox(message) {

    var html = '';

    html += '<div title="Notification" class="modal">';
    html += '   <div class="modal-header">';
    html += '       <a href="#" class="close" data-dismiss="modal">x</a>';
    html += '       <h3>Notification</h3>';
    html += '   </div>';
    html += '   <div class="modal-body">';
    html += '       <p>' + message + '</p>';
    html += '   </div>';
    html += '</div>';


    var popup = $(html);

    $('form').append(popup);

    $(popup).on('shown', function () {
        $('.modal-backdrop').last().attr('style', 'z-index: 1055;');
        $(popup).attr('style', 'z-index: 1060;');
    });

    $(popup).modal({ show: false });

    $(popup).on('hidden', function () {
        $(popup).remove();
    });

    $(popup).modal('show');
}