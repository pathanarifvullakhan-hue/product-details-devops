FROM nginx:alpine
COPY index.html style.css products.js app.js /usr/share/nginx/html/
EXPOSE 80
