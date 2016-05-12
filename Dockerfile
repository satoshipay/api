FROM nginx
COPY build /usr/share/nginx/html/api
COPY index.html /usr/share/nginx/html/

