var elixir = require('laravel-elixir')

//require('laravel-elixir-vue-2')

elixir(function(mix) {
    mix.less("app.less")
        .less('./resources/backend/less/admin-custom.less', './public/backend/css/admin-custom.css')
        .copy('./vendor/vakata/jstree/dist', './public/vendor/vakata/jstree')
    ;
});