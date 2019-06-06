docker build -t blazorboilerplate.server .

docker run -it --rm -p 8000:80 --name coreapp2 blazorboilerplate.server

docker rm coreapp

docker container ls