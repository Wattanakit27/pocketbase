FROM alpine:3.18

WORKDIR /app

# ติดตั้ง curl และ unzip
RUN apk add --no-cache curl unzip

# โหลด pocketbase binary (แก้เวอร์ชันตามล่าสุด เช่น 0.22.9)
RUN curl -L https://github.com/pocketbase/pocketbase/releases/download/v0.22.9/pocketbase_0.22.9_linux_amd64.zip -o pb.zip \
    && unzip pb.zip \
    && rm pb.zip

EXPOSE 8090

CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
