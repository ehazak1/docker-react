# BUILD
FROM node:alpine as buildphase
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# RUN NGINX
#/app/build <-- all the stuff we care about
FROM nginx
EXPOSE 80
COPY --from=buildphase /app/build /usr/share/nginx/html
# nginx start automatically when using the nginx image