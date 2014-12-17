FROM tutum/wordpress-stackable:latest

# Add an initial data which will be automatically loaded when creating the database for the first time
# ADD initial_db.sql /initial_db.sql

# Add custom themes, plugins and/or uploads
# ADD themes/ /app/wp-content/themes/
# ADD plugins/ /app/wp-content/plugins/
# ADD uploads/ /app/wp-content/uploads/
# RUN chown www-data:www-data /app/wp-content -R

Add startup.sh startup.sh 

CMD ["/startup.sh"]
