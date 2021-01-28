function createUploader(uploaderId, config) {
    var $uploader = $('#uploader-' + uploaderId);

    if (!$uploader || !$uploader.length) {
        alert('Cannot find uploader');
    }

    var $filelist = $uploader.find('.filelist'),
        $resultFilesContainer = $('#uploaded_files_lists_result' + uploaderId),
        $uploaded = $uploader.find('.uploaded'),
        $uploadAction = $uploader.find('.upload-actions'),
        $uploadBtn = $('#' + $uploader.data('uploadbtn')) || false,
        //options = config || $uploader.data('options') || {},
        options = config || {},
        autoStart = $uploader.data('autostart') || false,
        deleteUrl = $uploader.data('deleteurl') || false,
        deleteMethod = $uploader.data('deletemethod') || 'DELETE';

    defaultOptions = {
        init: {
            PostInit: function (up) {
                if (!autoStart && $uploadBtn) {
                    $uploadBtn.click(function () {
                        up.start();
                        return false;
                    });
                }
            },

            FilesAdded: function (up, files) {
                $.each(files, function (i, file) {
                    $filelist.append(
                        '<div id="' + file.id + '" class="alert alert-file">' +
                        '<div class="filename hide">' + file.name + ' (' + plupload.formatSize(file.size) + ')  <button type="button" class="close cancelUpload">&times;</button></div>' +
                        '<div class="progress progress-striped"><div class="progress-bar" style="width: 0;"></div></div></div>');

                    $filelist.on('click', '#' + file.id + ' button.cancelUpload', function () {
                        var $this = $(this),
                            $file = $('#' + file.id),
                            deleteUrl = $this.data('deleteurl') || false,
                            id = $this.data('id') || false;

                        if (deleteUrl) {
                            $.ajax({
                                dataType: 'json',
                                type: deleteMethod,
                                url: deleteUrl,
                                data: options.multipart_params,
                                success: function (result) {
                                    if (result.success) {
                                        up.removeFile(file);
                                        $file.remove();
                                        $('#' + file.id + '-hidden').remove();
                                        $uploadAction.show();
                                    }
                                    else {
                                        $('#' + file.id).append('<span class="text-danger">' + result.message + '</span>');
                                    }
                                }
                            });
                        }
                        else {
                            $uploadAction.show();
                            $file.remove();
                            $('#' + file.id + '-hidden').remove();
                            up.removeFile(file);
                        }
                    });
                });
                up.refresh(); // Reposition Flash/Silverlight
                if (autoStart) {
                    $uploadAction.hide();
                    up.start();
                }
            },

            UploadProgress: function (up, file) {
                $uploadAction.hide();
                $('#' + file.id + ' .progress').addClass('active');
                $('#' + file.id + ' button.cancelUpload').hide();
                $('#' + file.id + ' .progress .progress-bar').animate({width: file.percent + '%'}, 100, 'linear');
            },

            Error: function (up, err) {
                $filelist.append('<div class="alert alert-danger"><button type="button" class="close" data-dismiss="alert">&times;</button>' +
                    'Error: ' + err.code + ', Message: ' + err.message +
                    (err.file ? ', File: ' + err.file.name : '') +
                    "</div>"
                );
                up.refresh(); // Reposition Flash/Silverlight
            },

            FileUploaded: function (up, file, info) {
                var response = JSON.parse(info.response);

                $('#' + file.id + ' .progress .progress-bar').animate({width: '100%'}, 100, 'linear');
                $('#' + file.id + ' .progress').removeClass('progress-striped').removeClass('active').fadeOut();
                $('#' + file.id + ' .filename').removeClass('hide').show();
                $('#' + file.id + ' button.cancelUpload').show();

                if (response.result.id) {
                    $('#' + file.id + ' button.cancelUpload').attr('data-id', response.result.id);
                    $('<input type="hidden" name="' + uploaderId + '_files[]" value="' + response.result.id + '" id="' + file.id + '-hidden">').appendTo($uploader);
                }

                if (response.result.deleteUrl) {
                    $('#' + file.id + ' button.cancelUpload').attr('data-deleteurl', response.result.deleteUrl);
                }

                if (response.result.url) {
                    $('#' + file.id).append('<img src="' + response.result.url + '" class="img-responsive img-thumbnail" />');
                }

                if (response.result.success == true && response.result.data.id) {

                    $resultFilesContainer.append('    <div id="mod-img-' + response.result.data.id + '" class="col-sm-3 col-md-3 mod-img-item" style="max-width: 200px;"> \n' +
                        ' <i class="fa fa-star text-success icon-main" title="Главная"></i>' +
                        '            <div class="thumbnail krajee-default file-preview-frame">\n' +
                        '                <img src="' + response.result.urlImage + '" alt="' + response.result.data.alt + '">\n' +
                        '                <div class="caption">\n' +
                        '                    <span class="text-muted">' + response.result.data.filename + '</span>\n' +
                        '                    <p><a href="#" data-id="' + response.result.data.id + '" data-item_id="' + response.result.data.item_id + '" data-module="' + response.result.data.module + '" class="btn btn-success btn-xs mod-img-main" role="button">Главная</a> ' +
                        '                       <a href="#" data-id="' + response.result.data.id + '" class="btn btn-danger btn-xs mod-img-delete" role="button">Удалить</a></p>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>');
                } else if (response.result.message.file) {
                    $.each(response.result.message.file, function (key, val) {
                        toastr.error(val);
                    });
                }

            }
        }
    };

    $.extend(options, defaultOptions);

    //var uploader = new plupload.Uploader(options);
    //uploader.init();

    $uploader.plupload(options);


}

var deleteImage = 0;

function initDeleteAction(deleteUrl) {

    $(document).on("click", ".mod-img-delete", function (e) {

        e.preventDefault();

        var id = $(this).attr('data-id');
        var $container = $(this).parents('.mod-img-item');

        if (deleteImage == 1) {
            toastr.warning('Удаление уже запущено, дождитесь окончания.');
            return false;
        }
        deleteImage = 1;

        $.ajax({
            method: 'post',
            url: deleteUrl,
            data: {
                _token: LA.token,
                id: id
            },
            success: function (result) {
                deleteImage = 0;
                //$.pjax.reload('#pjax-container');
                if (result.success == true) {
                    $container.remove();
                    toastr.success('Фаил удален успешно');
                } else {
                    toastr.error('Ошибка. Попробуйте позже.');
                }
            },
            error: function () {
                deleteImage = 0;
            }
        });

    });

}


function initDeleteAllAction(deleteAllUrl, pluploader_id) {
    $(document).on("click", ".mod-img-remove-all", function (e) {

        e.preventDefault();


        var item_id = $(this).attr('data-item_id');
        var module = $(this).attr('data-module');

        if (!confirm('Вы действительно хотите удалить все изображения?')) {
            return false;
        }


        $.ajax({
            method: 'post',
            url: deleteAllUrl,
            data: {
                _token: LA.token,

                item_id: item_id,
                module: module,
            },
            success: function (result) {
                mainImage = 0;
                //$.pjax.reload('#pjax-container');
                if (result.success == true) {
                    $('#uploaded_files_lists_result' + pluploader_id + ' .mod-img-item').remove();
                    toastr.success('Все файлы удалены успешно.');
                } else {
                    toastr.error('Ошибка. Попробуйте позже.');
                }
            },
            error: function () {
                toastr.error('Ошибка. Попробуйте позже.');
            }
        });

    });
}

var mainImage = 0;

function initMainImageAction(mainImageUrl, pluploader_id) {

    $(document).on("click", ".mod-img-main", function (e) {

        e.preventDefault();

        var id = $(this).attr('data-id');
        var item_id = $(this).attr('data-item_id');
        var module = $(this).attr('data-module');
        var $container = $(this).parents('.mod-img-item');

        if (mainImage == 1) {
            toastr.warning('Изменения уже запущены, дождитесь окончания.');
            return false;
        }
        mainImage = 1;

        $.ajax({
            method: 'post',
            url: mainImageUrl,
            data: {
                _token: LA.token,
                id: id,
                item_id: item_id,
                module: module,
            },
            success: function (result) {
                mainImage = 0;
                //$.pjax.reload('#pjax-container');
                if (result.success == true) {
                    $('#uploaded_files_lists_result' + pluploader_id + ' .icon-main').hide();
                    $container.find('.icon-main').show();
                    toastr.success('Данные успешно изменены');
                } else {
                    toastr.error('Ошибка. Попробуйте позже.');
                }
            },
            error: function () {
                deleteImage = 0;
            }
        });

    });
}