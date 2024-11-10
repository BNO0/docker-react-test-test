# Build stage
# as builder : 다음 FROM 까지 build임을 명시
FROM node:alpine as builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# Run stage
FROM nginx
# COPY --from=builder [WORKDIR]/build /usr/share/nginx/html
# builder 의 /app/build 의 파일들을 /usr/share/nginx/html(nginx 의 기본 설정장소) 로 복사
# docker build -t [컨테이너명] ./
# docker run -p [local port]:80
COPY --from=builder /app/build /usr/share/nginx/html