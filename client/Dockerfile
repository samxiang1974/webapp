FROM node:12 as build

WORKDIR /client

COPY package.json /client/package.json

RUN npm install

RUN npm install react-scripts -g

COPY . /client

RUN npm run build

# => Run container
FROM nginx:1.16.1

COPY --from=build /client/build /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80

# Start Nginx server
CMD ["/bin/bash", "-c", "nginx -g \"daemon off;\""]
