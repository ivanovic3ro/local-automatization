my_route=$(pwd)
echo ${my_route}
echo "execute command"
sudo chmod -R 777 ${my_route}
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache
