#Solr 5 Cloudera Service Definition
This project contains the a service definition for managing Solr 5 server from Cloudera Manager.
This project doesn't provide a parcel for installing Solr on the target machines, Solr should be installed before using the services provided by this project.

##Structure

This project contains:

  - A service description [service.sdl](src/descriptor/service.sdl), see the ['Service Descriptor Language Reference'](https://github.com/cloudera/cm_ext/wiki/Service-Descriptor-Language-Reference) for more details.
  - A [control script](src/scripts/control.sh) that implements the 'start' and 'stop' operations.
  - A Solr 5 [icon](src/images/solr.ico) file that is shown the Cloudera Manager interface.
  
  
##Build this project
This a very simple Maven project that can be build using the command:

  ```mvn clean install```
  
##Distribution and Installation

  1. Install Solr 5 on the target machines
  2. Build the project
  3. Copy the generated jar file into the path ```//opt/cloudera/csd``` in the Cloudera Manager server
  4. Restart the Cloudera Manager service ```service cloudera-scm-server restart```
  5. From the Cloudera Manager interface, restart the _Cloudera Managament Service_ (usually called _mgmt1_).
  6. Add the Solr 5 service using the _Add Service_ wizard.
  7. Configure the Solr services adding the environment variables to the _Solr Service Environment Advanced Configuration_ in the service configuration page.
  8. Restart the Solr services.
  
##Know Issues

A [_stopRunner_](https://github.com/cloudera/cm_ext/wiki/Service-Descriptor-Language-Reference#stoprunner) it's basically used by CDH Manager to notify running processes that the service will be shutdown by sending a _SIGTERM_ after executing the _stopRunner_. However, in this case the Solr 5 service it's completely stopped by the _stopRunner_, which means that by the time the _SIGTERM_ is sent no process is running, this will be notified in CDH Manager using the error _"Abruptly stop the remaining roles..Failed to execute command Stop on service Solr5"_ and its details view will show _"At least one role must be started."_. There's nothing that can be done to prevent this behaviour using the default Solr installation scripts, please *Ignore* this error.


