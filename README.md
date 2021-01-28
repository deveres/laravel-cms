# Laravel-cms
Laravel CMS based on encore/laravel-admin <img src="https://laravel-admin.org/images/logo002.png" height="25px"> with multilanguage content

<p align="center"><img src="https://laravel.com/assets/img/components/logo-laravel.svg"></p>

<p align="center">
<a href="https://travis-ci.org/laravel/framework"><img src="https://travis-ci.org/laravel/framework.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://poser.pugx.org/laravel/framework/d/total.svg" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://poser.pugx.org/laravel/framework/v/stable.svg" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://poser.pugx.org/laravel/framework/license.svg" alt="License"></a>
</p>

# README #


### Requirements ###
* nodejs, php >=7.2
* Laravel 6.x, 7.x


### Additional ###
* [encore/laravel-admin: "1.8.*"](https://github.com/z-song/laravel-admin) - https://github.com/z-song/laravel-admin

### Laravel-admin documentation ###
*  https://laravel-admin.org/docs
*  [laravel-admin demo source](https://github.com/z-song/demo.laravel-admin.org)

### Installation ###

Create a new database with name ```laravel_cms_7``` in MySql (v.8).
The database dump is in ```storage/mysql_dump/dump.sql``` and you can import it:

```shell
mysql> create database `laravel_cms_7`;

mysql> use `laravel_cms_7`;

mysql> source storage/mysql_dump/dump.sql
```

Then install the project:
```bash
composer install
php artisan migrate 
npm install
npm run
```



### Optional installation commands ###
Run this commands if want to reinstall ``encore/laravel-admin`` interface:

To publish assets and config:
```shell
php artisan vendor:publish --provider="Encore\Admin\AdminServiceProvider"
```

Finish install:
```shell
php artisan admin:install
```

### Additional: php code check ###
* [code check PSR-1/PSR-2](https://habrahabr.ru/sandbox/101278/)
* [friendsofphp/php-cs-fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer)
* [PHPStorm setup](https://hackernoon.com/how-to-configure-phpstorm-to-use-php-cs-fixer-1844991e521f)
```shell
  $ composer global require friendsofphp/php-cs-fixer
  $ export PATH="$PATH:$HOME/.composer/vendor/bin"
```
run:
```shell
php-cs-fixer --diff --dry-run -v fix app
```


