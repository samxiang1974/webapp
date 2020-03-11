FROM node:alpine
RUN adduser -D server
USER server
WORKDIR /home/server
COPY package.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start" ]
