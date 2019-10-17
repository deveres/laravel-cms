# Laravel-cms
Laravel CMS based on z-song/laravel-admin

<p align="center"><img src="https://laravel.com/assets/img/components/logo-laravel.svg"></p>

<p align="center">
<a href="https://travis-ci.org/laravel/framework"><img src="https://travis-ci.org/laravel/framework.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://poser.pugx.org/laravel/framework/d/total.svg" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://poser.pugx.org/laravel/framework/v/stable.svg" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://poser.pugx.org/laravel/framework/license.svg" alt="License"></a>
</p>

# README #

### Requirements ###
* nodejs, php >=7.1 
* nodejs modules grunt-cli,bower,gulp ( global )
* PHP >= 7.1.0
* Laravel >= 5.7.0
* Fileinfo PHP Extension



### Additional ###

* [encore/laravel-admin: "^1.6"](https://github.com/z-song/laravel-admin)
* [doctrine/dbal: "^2.6"](https://github.com/doctrine/dbal)
* [barryvdh/laravel-ide-helper: "^2.4"](https://github.com/barryvdh/laravel-ide-helper)
* [barryvdh/laravel-debugbar: "^3.1"](https://github.com/barryvdh/laravel-debugbar)


### Laravel-admin documentation ###
*  http://laravel-admin.org/docs/#/
*  [laravel-admin demo source](https://github.com/z-song/laravel-admin.org)

### Installing ###
* composer install
* npm install --save-dev gulp-cli
* npm install --save-dev gulp 
* npm install --save-dev laravel-elixir
* npm install --save-dev laravel-elixir-vue-2
* npm install --save-dev laravel-elixir-webpack-official
* npm install gulp -D 
* touch gulpfile.js
* npm install -g bower
* npm install (from root path; processing - package.json)
* bower install (optional)
* gulp


### Admin part install ###
* php artisan make:auth (optional)
* php artisan admin:install (optional - if database is not installed)
* php artisan migrate (optional)

### Additional: php code check ###
* [check PSR-1/PSR-2](https://habrahabr.ru/sandbox/101278/)
* [friendsofphp/php-cs-fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer)
* [Setup PHPStorm](https://hackernoon.com/how-to-configure-phpstorm-to-use-php-cs-fixer-1844991e521f)
```bash
  $ composer global require friendsofphp/php-cs-fixer
  $ export PATH="$PATH:$HOME/.composer/vendor/bin"
```
run:
```bash
php-cs-fixer --diff --dry-run -v fix app
```