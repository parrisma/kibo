# Exposing port based services

Nginx is better suited to http traffic flow, so this test looks at how we can manage flow to specific tcp based offerings as part of a deployment or stateful set.

We create a super simple echo/ping python pair of test apps as a way to verify what is going on, if ports are open and also to confirm which container responded from a load balanced or stateful service.

Run the script create-config-maps.bat or copy and pate commands to create the two python scripts as config maps as they are mounted by the various deployments as files from those config maps.

