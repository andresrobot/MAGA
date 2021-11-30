## Run app
In order to execute the system first you need to clone the repository, for this it is necessary to open a command prompt and put the command git clone https://github.com/andresrobot/MAGA.git next you need to restore the database in your favorite database manager app this is located in branch folder /database/db.sql, the database user is root2, password: andres12 and the name is db_links. Once the database is restored, we need to mount the application, for this we go to the command prompt and locate in the branch folder, next introduce the command npm install when the installation finish insert the command npm run dev. With these the app is ready to use


## File Structure
- database, it the folder with all the sql queries, you can use to recreate the database for this application
- src, it's all the code for the Backend and Frontend Application
- docs
