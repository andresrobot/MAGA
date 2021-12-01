## Run app
In order to execute the system first you need to clone the repository, to do this it is necessary to open a terminal and insert the command git clone https://github.com/andresrobot/MAGA.git next you need to restore the database in your favorite database manager app this is located in branch folder /database/db.sql, the database user is root2, password: andres12 and the name is db_links. Once the database is restored, we need to mount the application, for this we locate it via terminal in the branch folder, then insert the command npm install when the installation is finished, insert the command npm run dev. Finally, the app is ready to use


## File Structure
- database, it's the folder with all the sql queries, you can use to recreate the database for this application
- src, it's all the code for the Backend and Frontend Application
- docs
