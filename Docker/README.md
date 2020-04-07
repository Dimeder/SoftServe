

Start application on local machine

    git clone git@github.com:Kv-062-DevOps/frontend.git
    cd frontend/app/
    virtualenv flask
    source flask/bin/activate
    pip3 install -r requirements.txt
    python3 app.py
    Follow link http://localhost:8080/

Run application with docker

    git clone git@github.com:Kv-062-DevOps/frontend.git
    cd frontend/
    docker build -t front .
    docker run -p 8080:8080 -d -e URL_GET="get_url" -e POST_URL="post_url" front:latest
    Follow link http://localhost:8080/

Run application with docker form dockerhub

    docker run -p 8080:8080 -d -e URL_GET="get_url" -e URL_POST="post_url" dimeder13/frontend:latest

