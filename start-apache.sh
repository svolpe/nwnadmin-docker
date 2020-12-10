echo "Start \n" > /var/www/html/apacheCrash.log
while true; do
	apache2ctl -D FOREGROUND
	echo "crash \n" >> /var/www/html/apacheCrash.log
done
