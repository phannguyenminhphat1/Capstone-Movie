FROM node:20
WORKDIR /home
COPY package*.json ./
RUN yarn install
COPY prisma ./prisma/
RUN yarn prisma generate
RUN yarn config set network-timeout 3000000
COPY . .
RUN yarn build
EXPOSE 8080
CMD ["yarn","start"]