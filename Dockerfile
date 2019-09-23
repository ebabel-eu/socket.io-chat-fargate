FROM mhart/alpine-node:12 AS build
WORKDIR /srv
ADD package.json .
RUN yarn install
ADD . .

FROM mhart/alpine-node:slim-12
COPY --from=build /srv .
EXPOSE 3000
CMD ["node", "index.js"]