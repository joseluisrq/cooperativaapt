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

//mix.js('resources/js/app.js', 'public/js')
//   .sass('resources/sass/app.scss', 'public/css');


mix.styles([
        // 'resources/plantilla/css/font-awesome.min.css',
        'resources/plantilla/css/bootstrap.min.css',
        'resources/plantilla/css/vendor.bundle.addons.css',
        'resources/plantilla/css/vendor.bundle.base.css',
        'resources/plantilla/css/style.css',
    ], 'public/css/plantilla.css')
    .scripts([
        'resources/plantilla/js/jquery.min.js',
        'resources/plantilla/js/popper.min.js',
        'resources/plantilla/js/off-canvas.js',
        'resources/plantilla/js/bootstrap.min.js',

        //'resources/plantilla/js/misc.js',
        'resources/plantilla/js/vendor.bundle.base.js',
        'resources/plantilla/js/vendor.bundle.addons.js',

        'resources/plantilla/js/dashboard.js',
        'resources/plantilla/js/Chart.min.js',
        'resources/plantilla/js/pace.min.js',
        'resources/plantilla/js/template.js',
        'resources/plantilla/js/sweetalert2.js',

    ], 'public/js/plantilla.js')
    .js([


        'resources/js/app.js',


    ], 'public/js/app.js')