FROM alpine:edge

ENV BUILD_PATH /workspace/build

WORKDIR /workspace

COPY bin .

# 'ninja' IS NOT included in 'cmake'
RUN apk update \
    && apk add g++ ninja meson

# '-p' make directory recursiely
# Also only create if does not exist
RUN mkdir -p $BUILD_PATH

USER root

RUN /usr/bin/meson setup $BUILD_PATH

# '-C' the dir where build.ninja is located
RUN /usr/bin/meson compile -C $BUILD_PATH

# optional but simplifies CMD
RUN mv $BUILD_PATH/main .

CMD ["./main"]