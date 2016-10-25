FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY server.bundle /etc/ssl/server.bundle
COPY server.key /etc/ssl/server.key
COPY dhparam.pem /etc/ssl/dhparam.pem

EXPOSE 80 443
