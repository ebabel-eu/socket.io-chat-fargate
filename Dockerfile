FROM mhart/alpine-node:9 AS build
WORKDIR /srv
ADD package.json .
RUN yarn install
ADD . .

FROM mhart/alpine-node:base-9
COPY --from=build /src .
EXPOSE 3000
CMD ["node", "index.js"]