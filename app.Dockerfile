FROM tomcat:7

RUN rm -rf /usr/local/tomcat/webapps/*
COPY ROOT.war /usr/local/tomcat/webapps/ROOT/ROOT.war
RUN cd /usr/local/tomcat/webapps/ROOT/ && unzip /usr/local/tomcat/webapps/ROOT/ROOT.war && rm /usr/local/tomcat/webapps/ROOT/ROOT.war
COPY database.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/database.properties
RUN echo "AUTHBIND=yes" >> /etc/default/tomcat7
COPY server.xml /usr/local/tomcat/conf/server.xml

