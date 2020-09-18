FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
#빌드파일을 컨테이너 안에 생성해준다.
RUN npm run build

#nginx를 작동시킨다.
FROM nginx
##빌더라는 스테이지에서 오기때문에 현재 빌드된파일은 /usr/src/app/build에 올라가있다.
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
