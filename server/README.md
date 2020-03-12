Done:  
- code commit  
   Create a demo express nodejs app to receive REST requests from client and write metadata to mysql database. Also support POD liveness and readiness probe  
- Dockerfile  
   Create docker image  
- Chart creation  
   including sa,secrets,deployment,service  

Ongoing:  
- CICD scripting  
   build docker image, push to repository,install charts  
   To save time it might be ugly for crendentials  
- scripting to install mariadb  
   has to be seperated from server chart due to the request for different namespace   
- Run some test  
