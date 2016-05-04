FROM nginx
ENV NGINX_PORT=80
COPY build /usr/share/nginx/html/api