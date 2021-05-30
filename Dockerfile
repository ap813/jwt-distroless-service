FROM python:3.7-slim AS build

RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# root dir as /app
WORKDIR /app
RUN mkdir -p /app
COPY . /app
RUN ls /app

# Private/Public Key creation
RUN openssl genrsa -out private.pem 2048
RUN openssl rsa -in private.pem -pubout -out public.pem

# Copy the virtualenv into a distroless image
FROM gcr.io/distroless/python3-debian10
COPY --from=build /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/

ENV LC_ALL C.UTF-8
ENV PYTHONPATH=/usr/local/lib/python3.7/site-packages/
WORKDIR /app
COPY --from=build /app /app

CMD ["-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]