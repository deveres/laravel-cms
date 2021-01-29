const mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

mix.js('resources/js/app.js', 'public/js')
    .sass('resources/sass/app.scss', 'public/css')
    .copy('resources/backend/images', 'public/backend/images')
    .copy('resources/backend/js', 'public/backend/js')
    .copy('vendor/moxiecode/plupload', 'public/backend/js/plupload-2.3.6')
    .copy('resources/assets/plupload', 'public/backend/js/plupload')
    .copy('vendor/vakata/jstree/dist', 'public/backend/js/vakata/jstree')
    .copy('resources/backend/vakata/jstree', 'public/backend/js/vakata/jstree')
    .copy('resources/frontend/img', 'public/img')
    .less('resources/backend/less/admin-custom.less', 'public/backend/css');
